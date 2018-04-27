module Memory.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Memory.Model exposing (..)
import Memory.Update exposing (..)


view : Model -> Html Msg
view model =
    case model.gameState of
        Choosing deck ->
            viewCards deck

        Matching card deck ->
            viewCards deck

        GameOver ->
            text "Game won!"


viewCard : Card -> Html Msg
viewCard card =
    let
        myImg =
            case card.state of
                Closed ->
                    img [ src "/cats/closed.png", class "closed", onClick (CardClick card) ] []

                Open ->
                    img [ src <| "/cats/" ++ card.id ++ ".jpg", class "closed" ] []

                Matched ->
                    img [ src <| "/cats/" ++ card.id ++ ".jpg", class "matched" ] []
    in
    div [] [ myImg ]


viewCards : List Card -> Html Msg
viewCards cards =
    List.map (\card -> viewCard card) cards
        |> div [ class "cards " ]
