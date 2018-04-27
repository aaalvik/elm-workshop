module Memory.Main exposing (..)

-- MAIN

import Html
import Memory.Model as Model
import Memory.Update as Update
import Memory.View as View


main =
    Html.beginnerProgram { view = View.view, model = Model.init, update = Update.update }
