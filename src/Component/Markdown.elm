module Component.Markdown exposing (markdown)

import Html exposing (Html)
import Markdown


markdown : String -> Html msg
markdown md =
    Markdown.toHtmlWith
        { githubFlavored = Just { tables = True, breaks = True }
        , defaultHighlighting = Nothing
        , sanitize = False
        , smartypants = False
        }
        []
        md
