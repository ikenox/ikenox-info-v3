module Main exposing (Model, Msg(..), main, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Const exposing (siteName)
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
    , page : Page
    }


type Page
    = None
    | Home Home.Model
    | BlogPost BlogPost.Model
    | NotFound NotFound.Model
    | AboutMe AboutMe.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    update (UrlChanged url) { page = None, key = key }



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotBlogPostMsg BlogPost.Msg
    | GotAboutMeMsg AboutMe.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { key, page } =
            model
    in
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Url.toString url |> Nav.pushUrl key )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            case fromUrl url of
                Just Route.Home ->
                    ( { model | page = Home {} }, Cmd.none )

                Just (Route.Blog postId) ->
                    let
                        ( m, c ) =
                            BlogPost.init postId
                    in
                    ( { model | page = BlogPost m }, Cmd.map GotBlogPostMsg c )

                Just Route.AboutMe ->
                    let
                        ( m, c ) =
                            AboutMe.init
                    in
                    ( { model | page = AboutMe m }, Cmd.map GotAboutMeMsg c )

                Nothing ->
                    ( { model | page = NotFound {} }, Cmd.none )

        GotBlogPostMsg subMsg ->
            case page of
                BlogPost subModel ->
                    let
                        ( sm, sc ) =
                            BlogPost.update subMsg subModel
                    in
                    ( { model | page = BlogPost sm }, Cmd.map GotBlogPostMsg sc )

                _ ->
                    ( model, Cmd.none )

        GotAboutMeMsg subMsg ->
            case page of
                AboutMe subModel ->
                    let
                        ( sm, sc ) =
                            AboutMe.update subMsg subModel
                    in
                    ( { model | page = AboutMe sm }, Cmd.map GotAboutMeMsg sc )

                _ ->
                    ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        { page } =
            model
    in
    case page of
        Home p ->
            Home.view p

        BlogPost p ->
            BlogPost.view p

        NotFound p ->
            NotFound.view p

        AboutMe p ->
            AboutMe.view p

        None ->
            { title = siteName
            , body = []
            }
