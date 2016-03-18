module Main where

import Graphics.Collage exposing (collage)
import Graphics.Element exposing (Element)
import Time exposing (fps)
import Task exposing (Task)
import Signal

import Component.Dialogue as Dialogue
import Utility.FormUtility exposing (viewMany)

port sendTimeToDialogue : Signal (Task x ())
port sendTimeToDialogue =
  let
    dialogueMailboxAddress = .address Dialogue.mailbox
  in
    Signal.map Dialogue.TimeElapsed (fps 60)
      |> Signal.map (Signal.send dialogueMailboxAddress)

main : Element
main =
  [Dialogue.create "Hello"]
    |> List.map Dialogue.view
    |> viewMany
    |> Signal.map (collage 400 400)
