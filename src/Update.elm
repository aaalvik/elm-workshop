module Update exposing (..)

import Keyboard exposing (..)
import Map exposing (Map, Position)
import Model exposing (..)
import Time
import Tuple exposing (first, second)


type Msg
    = KeyPressed KeyCode
    | SecondPassed Time.Time


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        KeyPressed keyCode ->
            case getDirection keyCode of
                Just dir ->
                    ( { model | direction = dir }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        SecondPassed time ->
            let
                newModel =
                    moveSnake model
            in
            ( newModel, Cmd.none )


moveSnake : Model -> Model
moveSnake model =
    let
        snake =
            model.snake

        newHead =
            moveHead snake.head model.direction

        newTail =
            if snake.isGrowing then
                snake.head :: snake.tail
            else
                snake.head :: List.take (List.length snake.tail - 1) snake.tail

        isDead =
            hitWall model.map newHead

        newFood =
            Maybe.andThen
                (\pos ->
                    if pos == newHead then
                        Nothing
                    else
                        Just pos
                )
                model.food

        newSnake =
            { snake | head = newHead, tail = newTail, isGrowing = False }

        -- case food of
        --     Just pos ->
        --         if pos == newHead then Nothing else Just pos
        --     Nothing ->
    in
    { model | snake = newSnake, dead = isDead, food = newFood }


hitWall : Map -> Position -> Bool
hitWall map pos =
    let
        hi =
            List.length map
    in
    first pos
        >= hi
        || first pos
        <= 1
        || second pos
        >= hi
        || second pos
        <= 1


moveHead : Position -> Direction -> Position
moveHead pos dir =
    case dir of
        Left ->
            ( first pos, second pos - 1 )

        Up ->
            ( first pos - 1, second pos )

        Right ->
            ( first pos, second pos + 1 )

        Down ->
            ( first pos + 1, second pos )


getDirection : KeyCode -> Maybe Direction
getDirection keyCode =
    case keyCode of
        37 ->
            Just Left

        38 ->
            Just Up

        39 ->
            Just Right

        40 ->
            Just Down

        _ ->
            Nothing
