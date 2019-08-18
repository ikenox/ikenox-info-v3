module Adapter.Repository exposing (findByPath)

import Http exposing (Error)
import Result exposing (map, mapError)


findByPath : String -> (Result String String -> msg) -> Cmd msg
findByPath path toMsg =
    Http.get
        { url = path
        , expect = Http.expectString (toMsg << mapError (\e -> ""))
        }
