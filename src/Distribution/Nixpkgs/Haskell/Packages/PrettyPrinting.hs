module Distribution.Nixpkgs.Haskell.Packages.PrettyPrinting where

import Language.Nix.PrettyPrinting

import Prelude hiding ((<>))

compilerConfig :: Doc -> Doc
compilerConfig body =
  funargsCurried ["self", "super"] <+> body

packageSetConfig :: Doc -> Doc
packageSetConfig body = vcat
  [ funargs ["pkgs", "stdenv", "callPackage"]
  , ""
  , funargsCurried ["self"] <+> "{"
  , nest 2 body
  , "}"]

overrides :: Doc -> Doc
overrides body = funargsCurried ["self", "super"] <+> body

-- | Function argument
-- output 'arg:'
funarg :: Doc -> Doc
funarg = flip (<>) colon

-- | Function arguments curried
-- output 'arg1: arg2:'
funargsCurried :: [Doc] -> Doc
funargsCurried = hsep . fmap funarg
