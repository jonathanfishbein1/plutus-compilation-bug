{-# OPTIONS_GHC -fplugin-opt PlutusTx.Plugin:context-level=3 #-}
{-# OPTIONS_GHC -fplugin-opt PlutusTx.Plugin:no-typecheck #-}
{-# OPTIONS_GHC -fplugin-opt PlutusTx.Plugin:verbosity=2 #-}

module Script
  ( serialisedValidator,
  )
where

import PlutusLedgerApi.V2 qualified
import PlutusTx qualified
import PlutusTx.Prelude qualified

{-# INLINEABLE untypedValidator #-}
untypedValidator ::
  PlutusTx.Prelude.BuiltinData ->
  PlutusTx.Prelude.BuiltinData ->
  PlutusTx.Prelude.BuiltinData ->
  ()
untypedValidator datum redeemer ctx =
  ()

{-# INLINEABLE validatorScript #-}
validatorScript ::
  PlutusTx.CompiledCode
    ( PlutusTx.Prelude.BuiltinData ->
      PlutusTx.Prelude.BuiltinData ->
      PlutusTx.Prelude.BuiltinData ->
      ()
    )
validatorScript =
  $$(PlutusTx.compile [||untypedValidator||])

serialisedValidator :: PlutusLedgerApi.V2.SerialisedScript
serialisedValidator = PlutusLedgerApi.V2.serialiseCompiledCode validatorScript
