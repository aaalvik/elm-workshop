module Map exposing (..)


createMap : Int -> Map
createMap size =
    List.map (createRow size) (List.range 1 size)


createRow : Int -> Int -> Row
createRow size x =
    List.map (\y -> generateTileAt size ( x, y )) (List.range 1 size)


generateTileAt : Int -> Position -> Tile
generateTileAt size ( x, y ) =
    if x == 1 || y == 1 || x == size || y == size then
        Wall
    else
        Open ( x, y )


type alias Row =
    List Tile


type alias Map =
    List Row


type Tile
    = Wall
    | Open Position


type alias Position =
    ( Int, Int )
