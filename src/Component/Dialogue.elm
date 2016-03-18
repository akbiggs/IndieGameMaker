module Component.Dialogue (create, update, view, Action(..), Model, mailbox) where

import Graphics.Collage exposing (..)
import Time exposing (..)
import Signal exposing (Mailbox, Address)
import Text

import Utility.LineReader exposing (readString)

-- MODEL

type alias Model =
  { string : String
  , elapsedTime : Time
  }

create : String -> Model
create line = Model line 0

-- UPDATE

type Action
  = NoOp
  | TimeElapsed Time
  | SkipDialogue

mailbox : Mailbox Action
mailbox = Signal.mailbox NoOp

update : Action -> Model -> Model
update a m =
  case a of
    NoOp ->
      m

    TimeElapsed dt ->
      { m | elapsedTime = m.elapsedTime + dt }

    SkipDialogue ->
      { m | elapsedTime = 1000000 * second }

-- VIEW

render : Model -> Form
render {string, elapsedTime} =
  readString elapsedTime string
    |> Text.fromString
    |> text

view : Model -> Signal Form
view dialogue =
  Signal.foldp update dialogue mailbox.signal
    |> Signal.map render
