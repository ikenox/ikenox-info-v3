module Page.BlogPost exposing (Model, view)

import Browser
import Component.Layout exposing (layout)
import Html exposing (div)
import Markdown


type alias Model =
    { title : String
    , postId : String
    }


view : Model -> Browser.Document msg
view model =
    { title = model.title
    , body =
        layout
            [ div
                []
                [ Markdown.toHtml
                    []
                    """
# foo
## bar
- fizz
- bazz
"""
                ]
            ]
    }
