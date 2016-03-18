module Utility.ListUtility where

import List exposing (..)

scanlDrop1 : (a -> b -> b) -> b -> List a -> List b
scanlDrop1 acc init xs = scanl acc init xs |> drop 1
