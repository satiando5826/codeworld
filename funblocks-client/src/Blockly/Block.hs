{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE JavaScriptFFI #-}

{-
  Copyright 2016 The CodeWorld Authors. All Rights Reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-}

module Blockly.Block ( Block(..)
                     , getFieldValue)
  where

import GHCJS.Types
import Data.JSString (pack, unpack)
import GHCJS.Foreign
import GHCJS.Marshal

newtype Block = Block JSVal

instance IsJSVal Block

getFieldValue :: Block -> String -> String
getFieldValue block fieldName = unpack $ js_getFieldValue block (pack fieldName)

instance ToJSVal Block where
  toJSVal (Block v) = return v

instance FromJSVal Block where
  fromJSVal v = return $ Just $ Block v

getType :: Block -> String
getType = unpack . js_type

--- FFI

foreign import javascript unsafe "$1.getFieldValue($2)"
  js_getFieldValue :: Block -> JSString -> JSString

foreign import javascript unsafe "$1.type"
  js_type :: Block -> JSString