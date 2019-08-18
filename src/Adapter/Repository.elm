module Adapter.Repository exposing (findByPath)

import Http exposing (Error)


findByPath : String -> (Result Error String -> msg) -> Cmd msg
findByPath path toMsg =
    Http.get
        { url = path
        , expect = Http.expectString toMsg
        }
