# Testimony brand assets

The mark is a **turnstile `⊢`** — logic's symbol for "proves" — drawn with
scroll finials so it reads as both a derivation symbol and a scroll rod. The
crossbar extends left of the vertical, and a **white Latin cross** of
traditional proportion (crossbar at the upper third) is inscribed *within* the
gold strokes. The white square closing the line is the **QED tombstone**.

The cross is inscribed, not overlaid: it is found within the mark's geometry
rather than placed on top of it. This is confessional honesty about whose
project this is — not a claim that the formalism proves the cross.

## Sources (edit these)

| File | Use |
|---|---|
| `testimony-mark.svg` | Primary mark. Gold 52 / white 28 on navy. |
| `testimony-mark-small.svg` | Simplified for ≤48px: QED square and finials dropped, heavier strokes, fills more of the tile. |
| `testimony-mark-light.svg` | Navy on white, for slides, print, papers. |
| `testimony-social.svg` | 2:1 banner with wordmark and proof-tree scaffolding. |

PNG/JPG files are **generated** — never edit them. Change the SVG, re-run:

```sh
python3 export.py
```

## Exports

`exports/` holds 17 sizes × PNG and JPG. Each is rasterised from vector at its
native resolution (not downscaled from one master), so strokes stay crisp.

| Size | Use |
|---|---|
| 16, 32, 48 | Favicons — **simplified mark** |
| 64 | Small avatar, Discord emoji |
| 128, 180, 192 | Docs header, apple-touch-icon, PWA/Android |
| 256 | GitHub org avatar (minimum) |
| 400 | X / Twitter profile |
| 512 | PWA maskable, Patreon avatar |
| 1024 | Print, high-DPI, app store |
| light-256/512/1024 | Light-background variant |
| social-1280×640 | GitHub social preview, X header |
| social-1600×800 | Patreon cover, high-DPI Open Graph |
| social-2400×1200 | Retina / print banner |

Prefer PNG. Use JPG only where a platform rejects PNG; all marks carry an
opaque background, so nothing is lost to the missing alpha channel.

## Palette

| Role | Hex |
|---|---|
| Ink (background, dark) | `#0d1b2a` → `#1f3a5f` gradient |
| Gold (strokes) | `#e8c87a` → `#c9a24d` |
| Bone (cross, QED, text) | `#f2f2f0` |
| Slate (secondary text) | `#9fb3c8` |

## Typography

Serif wordmark (Georgia / EB Garamond) for scholarship; monospace subtitle for
the formal layer.

## Please don't

- Add crosses, doves, or flames alongside the mark — the cross is already in
  the geometry, and duplicating it makes the mark a tract.
- Stretch the mark non-uniformly, recolour it outside the palette, or place
  the dark mark on a busy photograph.
- Use the full mark below 48px; use the simplified one.
