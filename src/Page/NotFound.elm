module Page.NotFound exposing (Model, view)

import Browser
import Component.Layout exposing (layout)
import Html exposing (Html, text)


type alias Model =
    {}


view : Model -> Browser.Document msg
view model =
    { title = "Not found", body = layout [ text "404 not found" ] }
