module Route exposing (Route(..), fromUrl)

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, map, oneOf, s, string)


type Route
    = Home
    | Blog String
    | AboutMe


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map AboutMe (s "aboutme")
        , map Blog (s "blog" </> string)

        -- FIXME
        , map Home (s "src" </> s "Main.elm")
        ]


fromUrl : Url -> Maybe Route
fromUrl url =
    Parser.parse routeParser url
