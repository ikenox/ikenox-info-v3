module Page.BlogPost exposing (Model, Msg, init, update, view)

import Adapter.Repository exposing (findByPath)
import Browser
import Component.Layout exposing (layout)
import Component.Markdown exposing (markdown)
import Debug exposing (log, toString)
import Domain.BlogPost exposing (BlogPost, PostId)
import Http
import Maybe exposing (Maybe, map, withDefault)


type alias Model =
    { blogPost : Maybe BlogPost
    }


type Msg
    = GotPlogPostMarkdown PostId (Result Http.Error String)


view : Model -> Browser.Document msg
view model =
    { title = model.blogPost |> map (\x -> x.title) |> withDefault "foo"
    , body =
        layout
            [ model.blogPost |> map (\x -> x.bodyMd) |> withDefault "" |> markdown
            ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotPlogPostMarkdown id (Ok body) ->
            ( { model
                | blogPost =
                    Just
                        { postId = "foo"
                        , title = "fasf"
                        , bodyMd = body
                        }
              }
            , Cmd.none
            )

        GotPlogPostMarkdown id (Err err) ->
            let
                _ =
                    toString err |> log
            in
            ( model, Cmd.none )


init : PostId -> ( Model, Cmd Msg )
init id =
    ( { blogPost = Nothing
      }
    , findByPath ("/static/documents/blog/" ++ id ++ ".md") (GotPlogPostMarkdown id)
    )
