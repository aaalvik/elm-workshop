module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Map exposing (..)
import Model exposing (..)


view : Model -> Html a
view model =
    case model.dead of
        True ->
            text "You're dead!"

        False ->
            div [] <| List.map (\row -> viewRow row model) model.map


viewRow : Row -> Model -> Html a
viewRow row model =
    List.map (\tile -> viewTile tile model) row
        |> div [ class "row" ]


viewTile : Tile -> Model -> Html a
viewTile tile model =
    let
        className =
            case tile of
                Open pos ->
                    if isSnakeAtPosition pos model.snake then
                        "snake"
                    else if isFoodAtPosition pos model.food then
                        "food"
                    else
                        "open"

                Wall ->
                    "wall"
    in
    span [ class ("tile " ++ className) ] []


isSnakeAtPosition pos snake = 
    snake.head == pos || List.any (\tile -> tile == pos) snake.tail

isFoodAtPosition pos food =
    case food of
        Just foodPos ->
            Debug.log "FOOD" (foodPos == pos)

        Nothing ->
            False
