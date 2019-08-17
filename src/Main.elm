module Main exposing (Model, Msg(..), main, subscriptions, update, view, viewPage)

import Browser
import Browser.Navigation as Nav
import Page.AboutMe as AboutMe
import Page.BlogPost as BlogPost
import Page.Home as Home
import Page.NotFound as NotFound
import Route exposing (fromUrl)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : Page
    }


type Page
    = Home Home.Model
    | BlogPost BlogPost.Model
    | NotFound NotFound.Model
    | AboutMe AboutMe.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    viewPage url key


viewPage : Url.Url -> Nav.Key -> ( Model, Cmd Msg )
viewPage url key =
    let
        model =
            case fromUrl url of
                Just Route.Home ->
                    Model key url <| Home Home.Model

                Just (Route.Blog postId) ->
                    Model key url <| BlogPost <| BlogPost.Model "foo" postId

                Just Route.AboutMe ->
                    Model key url <| AboutMe AboutMe.Model

                Nothing ->
                    Model key url <| NotFound NotFound.Model
    in
    ( model, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Url.toString url |> Nav.pushUrl model.key )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            viewPage url model.key



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.page of
        Home p ->
            Home.view p

        BlogPost p ->
            BlogPost.view p

        NotFound p ->
            NotFound.view p

        AboutMe p ->
            AboutMe.view p
