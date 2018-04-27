module Memory.Model exposing (..)


type alias Model =
    { gameState : GameState
    }


type alias Card =
    { id : String
    , state : CardState
    , group : Group
    }


type alias Deck =
    List Card


type CardState
    = Open
    | Closed
    | Matched


type Group
    = A
    | B


type GameState
    = Choosing Deck
    | Matching Card Deck
    | GameOver


init : Model
init =
    { gameState = Choosing cards
    }


card id state group =
    { id = id
    , state = state
    , group = group
    }


cards : Deck
cards =
    [ card "1" Closed A
    , card "1" Closed B
    , card "2" Closed A
    , card "2" Closed B
    ]
