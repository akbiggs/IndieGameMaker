module Utility.FormUtility (viewMany) where

import List exposing (..)
import Graphics.Collage exposing (Form)

unpackInto : Signal Form -> Signal (List Form) -> Signal (List Form)
unpackInto formSignal formListSignal =
  Signal.map (\x ->
    Signal.map (\forms -> List.append forms [x]) formListSignal) formSignal

viewMany : List (Signal Form) -> Signal (List Form)
viewMany forms =
  let
    unpack formSignal forms =
      Signal.map (\x -> List.append forms [x]) formSignal

  in
    foldl unpack (Signal.constant []) forms
