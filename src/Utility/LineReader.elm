module Utility.LineReader where

import Time exposing (..)
import String exposing (..)
import List

import Utility.ListUtility exposing (..)

charReadTime : Char -> Time
charReadTime c =
  case c of
    '.' ->
      1 * second

    ',' ->
      0.25 * second

    _ ->
      0.01 * second

readString : Time -> String -> String
readString elapsedTime s =
  toList s
    |> readCharList elapsedTime
    |> toString

readCharList : Time -> List Char -> List Char
readCharList elapsedTime chars =
  List.map charReadTime chars
    |> scanlDrop1 (+) 0
    |> List.filter (\x -> x <= elapsedTime)
    |> List.length
    |> (\x -> List.take x chars)
