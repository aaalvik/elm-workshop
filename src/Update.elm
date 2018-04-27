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
                ( newSnake, isDead ) =
                    moveSnake model.direction model.map model.snake
            in
            ( { model | snake = newSnake, dead = isDead }, Cmd.none )


moveSnake : Direction -> Map -> Snake -> ( Snake, Bool )
moveSnake direction map snake =
    let
        newHead =
            moveHead snake.head direction

        newTail =
            if snake.isGrowing then
                snake.head :: snake.tail
            else
                snake.head :: List.take (List.length snake.tail - 1) snake.tail

        isDead =
            hitWall map newHead
    in
    ( { snake | head = newHead, tail = newTail, isGrowing = False }, isDead )


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
