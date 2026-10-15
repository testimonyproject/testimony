import TestimonyArguments
import Testimony.Tools.Pages
import TestimonyArguments.Tools.Catalogue

/-!
# TestimonyArguments.Tools.Pages — every argument, harvested

Every argument's page body — its module docstrings and documented declarations,
in source order — harvested once by the library's `derive_argument_bodies` and
read by both `argdoc` and `argtex`, so the site and the PDF are two settings of
one text. Only this package's namespace is harvested; the library it imports
has a fixture of its own, which is no argument.
-/

open Lean Testimony Testimony.Doc

namespace TestimonyArguments.Doc

derive_argument_bodies bodies under TestimonyArguments

#guard bodies.all fun b => arguments.any fun a => a.ns == b.ns
#guard arguments.all fun a => bodies.any fun b => b.ns == a.ns

end TestimonyArguments.Doc
