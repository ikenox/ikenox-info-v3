module Page.Home exposing (Model, view)

import Browser
import Component.Layout exposing (layout)
import Html exposing (Html, a, b, li, text, ul)
import Html.Attributes exposing (href)


type alias Model =
    {}


view : Model -> Browser.Document msg
view model =
    { title = "home"
    , body =
        layout
            [ ul []
                [ viewLink "/"
                , viewLink "/about"
                , viewLink "/blog/first-commit"
                , viewLink "/blog/ideavim-introduction"
                , viewLink "/wrong-url"
                , viewLink "https://google.com"
                ]
            ]
    }


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]
