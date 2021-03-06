module Main exposing (main)

import Types exposing (..)
import State exposing (..)
import View exposing (..)
import Html


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
