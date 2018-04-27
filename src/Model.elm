module Model
    exposing
        ( Direction(..)
        , Food
        , Model
        , Snake
        , init
        )

import Map exposing (..)


type alias Model =
    { snake : Snake
    , direction : Direction
    , food : Food
    , dead : Bool
    , map : Map
    }


type alias Food =
    Maybe Position


type alias Snake =
    { head : Position
    , tail : List Position
    , isGrowing : Bool
    }


type Direction
    = Up
    | Down
    | Left
    | Right


init =
    ( Model
        snake
        Up
        (Just
            ( 2, 2 )
        )
        False
        (createMap 20)
    , Cmd.none
    )


snake =
    Snake
        ( 5, 5 )
        [ ( 5, 6 ) ]
        True
