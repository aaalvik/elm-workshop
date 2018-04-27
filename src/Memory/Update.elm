module Memory.Update exposing (..)

import Memory.Model exposing (..)


type Msg
    = CardClick Card


update : Msg -> Model -> Model
update msg model =
    case msg of
        CardClick card ->
            { model | gameState = updateCardClick card model.gameState }


updateCardClick : Card -> GameState -> GameState
updateCardClick card gameState =
    case gameState of
        Choosing deck ->
            deck
                |> closeAllUnmatched
                |> setCardInDeck card Open
                |> Matching card

        Matching oldCard deck ->
            if oldCard.id == card.id then
                deck
                    |> setCardInDeck oldCard Matched
                    |> setCardInDeck card Matched
                    |> (\newDeck ->
                            if gameWon newDeck then
                                GameOver
                            else
                                Choosing newDeck
                       )
            else
                deck
                    |> setCardInDeck card Open
                    |> Choosing

        GameOver ->
            gameState


gameWon : Deck -> Bool
gameWon =
    List.all (\card -> card.state == Matched)


closeAllUnmatched : Deck -> Deck
closeAllUnmatched deck =
    List.map
        (\card ->
            if card.state == Open then
                setCard Closed card
            else
                card
        )
        deck


setCardInDeck : Card -> CardState -> Deck -> Deck
setCardInDeck card cardState cards =
    List.map
        (\c ->
            if c.id == card.id && c.group == card.group then
                setCard cardState c
            else
                c
        )
        cards


setCard : CardState -> Card -> Card
setCard state card =
    { card | state = state }
