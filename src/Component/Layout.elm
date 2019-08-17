module Component.Layout exposing (layout)

import Const exposing (siteName)
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class, id)


layout : List (Html msg) -> List (Html msg)
layout content =
    [ h1 [] [ text siteName ]
    , div [ id "content" ] content
    , text "this is footer"
    ]
