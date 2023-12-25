module Main (main) where

import Script qualified
import Prelude qualified

main :: Prelude.IO ()
main =
  do
    stampResult <-
      Prelude.writeFile
        "./build/script.plutus"
        (Prelude.show Script.serialisedValidator)
    Prelude.return ()