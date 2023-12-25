{-# OPTIONS_GHC -fplugin-opt PlutusTx.Plugin:context-level=3 #-}
{-# OPTIONS_GHC -fplugin-opt PlutusTx.Plugin:no-typecheck #-}
{-# OPTIONS_GHC -fplugin-opt PlutusTx.Plugin:verbosity=2 #-}

module Script
  ( serialisedArcadeValidator,
  )
where

import PlutusLedgerApi.V2 qualified
import PlutusTx qualified
import PlutusTx.Prelude qualified

{-# INLINEABLE arcadeUntypedValidator #-}
arcadeUntypedValidator ::
  PlutusTx.Prelude.BuiltinData ->
  PlutusTx.Prelude.BuiltinData ->
  PlutusTx.Prelude.BuiltinData ->
  ()
arcadeUntypedValidator datum redeemer ctx =
  ()

{-# INLINEABLE arcadeValidatorScript #-}
arcadeValidatorScript ::
  PlutusTx.CompiledCode
    ( PlutusTx.Prelude.BuiltinData ->
      PlutusTx.Prelude.BuiltinData ->
      PlutusTx.Prelude.BuiltinData ->
      ()
    )
arcadeValidatorScript =
  $$(PlutusTx.compile [||arcadeUntypedValidator||])

serialisedArcadeValidator :: PlutusLedgerApi.V2.SerialisedScript
serialisedArcadeValidator = PlutusLedgerApi.V2.serialiseCompiledCode arcadeValidatorScript
