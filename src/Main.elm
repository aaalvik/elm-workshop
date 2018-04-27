module Main exposing (..)

import Html exposing (..)
import Keyboard
import Model exposing (..)
import Time
import Update exposing (..)
import View


main =
    Html.program { view = View.view, update = Update.update, init = Model.init, subscriptions = subscriptions }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyPressed
        , Time.every Time.second SecondPassed
        ]
