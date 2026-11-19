#!/usr/bin/env python3
"""Testimony brand export.

Renders the canonical SVG sources to every size the project needs, in PNG
(transparent-capable, lossless) and JPG (for platforms that reject PNG).

Chrome renders at the requested viewport, so each size is rasterised from
vector at its native resolution rather than downscaled from one master — text
and thin strokes stay crisp. Small sizes (<=48) use the simplified mark.

Usage:  python3 export.py          (writes into ../brand/exports/)
        python3 export.py STEM ...  (export only the named targets)
"""
import subprocess, pathlib, shutil, sys

CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
BRAND = pathlib.Path(__file__).parent
OUT = BRAND / "exports"

MARK = BRAND / "testimony-mark.svg"
MARK_SMALL = BRAND / "testimony-mark-small.svg"
MARK_LIGHT = BRAND / "testimony-mark-light.svg"
SOCIAL = BRAND / "testimony-social.svg"
SHORT_HEADER = BRAND / "testimony-short-header.svg"

# Overlays that must keep a clear background (PNG only, no JPG).
TRANSPARENT = {"testimony-short-header-1080x236"}

# (filename stem, source svg, width, height, purpose)
TARGETS = [
    # --- square mark: simplified below 48px ---
    ("testimony-16",    MARK_SMALL, 16, 16,   "favicon (browser tab)"),
    ("testimony-32",    MARK_SMALL, 32, 32,   "favicon (standard)"),
    ("testimony-48",    MARK_SMALL, 48, 48,   "favicon (Windows), small avatar"),
    ("testimony-64",    MARK, 64, 64,         "small avatar, Discord emoji"),
    ("testimony-128",   MARK, 128, 128,       "docs header, app icon"),
    ("testimony-180",   MARK, 180, 180,       "apple-touch-icon"),
    ("testimony-192",   MARK, 192, 192,       "PWA / Android icon"),
    ("testimony-256",   MARK, 256, 256,       "GitHub org avatar (min)"),
    ("testimony-400",   MARK, 400, 400,       "X / Twitter profile"),
    ("testimony-512",   MARK, 512, 512,       "PWA maskable, Patreon avatar"),
    ("testimony-1024",  MARK, 1024, 1024,     "print, high-DPI, app store"),
    # --- light-background variant ---
    ("testimony-light-256",  MARK_LIGHT, 256, 256,   "slides, light docs"),
    ("testimony-light-512",  MARK_LIGHT, 512, 512,   "print, papers"),
    ("testimony-light-1024", MARK_LIGHT, 1024, 1024, "print, high-DPI"),
    # --- banners / covers ---
    ("testimony-social-1280x640", SOCIAL, 1280, 640, "GitHub social preview, X header"),
    ("testimony-social-1600x800", SOCIAL, 1600, 800, "Patreon cover, high-DPI OG"),
    ("testimony-social-2400x1200", SOCIAL, 2400, 1200, "retina / print banner"),
    # --- video overlays ---
    ("testimony-short-header-1080x236", SHORT_HEADER, 1080, 236, "header bar for vertical videos (Shorts)"),
]


def render(svg: pathlib.Path, png: pathlib.Path, w: int, h: int, clear: bool = False) -> None:
    extra = ["--default-background-color=00000000"] if clear else []
    subprocess.run(
        [CHROME, "--headless", "--disable-gpu", "--hide-scrollbars",
         "--force-device-scale-factor=1", *extra,
         f"--screenshot={png}", f"--window-size={w},{h}", str(svg)],
        capture_output=True, check=False)


def to_jpg(png: pathlib.Path, jpg: pathlib.Path) -> None:
    """JPG has no alpha; the marks all carry an opaque background already."""
    shutil.copy(png, jpg)
    subprocess.run(["sips", "-s", "format", "jpeg", "-s", "formatOptions", "92",
                    str(jpg), "--out", str(jpg)], capture_output=True, check=False)


def main() -> int:
    if not pathlib.Path(CHROME).exists():
        print(f"Chrome not found at {CHROME}", file=sys.stderr)
        return 1
    OUT.mkdir(exist_ok=True)
    rows = []
    only = set(sys.argv[1:])  # optional: export just these stems
    for stem, svg, w, h, purpose in TARGETS:
        if only and stem not in only:
            continue
        png = OUT / f"{stem}.png"
        clear = stem in TRANSPARENT
        render(svg, png, w, h, clear)
        jsize = 0
        if not clear:
            jpg = OUT / f"{stem}.jpg"
            to_jpg(png, jpg)
            jsize = jpg.stat().st_size
        rows.append((stem, w, h, png.stat().st_size, jsize, purpose))
    print(f"{'file':32} {'size':>11} {'png':>8} {'jpg':>8}  purpose")
    for stem, w, h, ps, js, purpose in rows:
        print(f"{stem:32} {f'{w}x{h}':>11} {ps/1024:7.1f}K {js/1024:7.1f}K  {purpose}")
    print(f"\n{len(rows)} targets written to {OUT} (transparent overlays are PNG only)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
