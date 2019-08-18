module Route exposing (Route(..), fromUrl)

import Domain.BlogPost exposing (PostId)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, map, oneOf, s, string, top)


type Route
    = Home
    | Blog PostId
    | AboutMe


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map AboutMe (s "aboutme")
        , map AboutMe (s "about")
        , map Blog (s "blog" </> string)
        , map Home top
        ]


fromUrl : Url -> Maybe Route
fromUrl url =
    Parser.parse routeParser url
