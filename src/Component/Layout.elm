module Component.Layout exposing (layout)

import Const exposing (siteName)
import Html exposing (Html, a, div, h1, text)
import Html.Attributes exposing (class, href, id)


layout : List (Html msg) -> List (Html msg)
layout content =
    [ h1 [] [ a [ href "/" ] [ text siteName ] ]
    , div [ id "content" ] content
    ]
