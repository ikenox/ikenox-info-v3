module Page.AboutMe exposing (Model, view)

import Browser
import Component.Layout exposing (layout)
import Html exposing (text)


type alias Model =
    {}


view : Model -> Browser.Document msg
view model =
    { title = "about me"
    , body =
        layout [ text "naoto ikeno" ]
    }
