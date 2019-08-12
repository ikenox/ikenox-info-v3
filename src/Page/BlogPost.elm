module Page.BlogPost exposing (Model)

import Html exposing (Html)


type alias Model =
    { title : String
    , postId : String
    }
