module Page.AboutMe exposing (Model, Msg, init, update, view)

import Adapter.Repository exposing (findByPath)
import Browser
import Component.Layout exposing (layout)
import Component.Markdown exposing (markdown)
import Const exposing (author)
import Debug exposing (log, toString)


type alias Model =
    { md : String }


type Msg
    = GotProfile (Result String String)


init : ( Model, Cmd Msg )
init =
    ( { md = "" }
    , findByPath "/static/documents/about.md" GotProfile
    )


view : Model -> Browser.Document msg
view model =
    { title = author
    , body =
        layout [ markdown model.md ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotProfile (Ok body) ->
            ( { model | md = body }, Cmd.none )

        GotProfile (Err err) ->
            let
                _ =
                    toString err |> log
            in
            ( model, Cmd.none )
