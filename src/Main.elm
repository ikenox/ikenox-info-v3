module Main exposing (Model, Msg(..), init, main, subscriptions, update, view, viewLink)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
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
    let
        model =
            case fromUrl url of
                Just Route.Home ->
                    Model key url (Home Home.Model)

                Just (Route.Blog postId) ->
                    Model key url (BlogPost (BlogPost.Model "foo" postId))

                Just Route.AboutMe ->
                    Model key url (AboutMe AboutMe.Model)

                Nothing ->
                    Model key url (Home Home.Model)

        --                    Model key url (NotFound NotFound.Model)
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
            ( { model | url = url }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.page of
        Home p ->
            { title = "home"
            , body =
                [ text "The current URL is: "
                , b [] [ text (Url.toString model.url) ]
                , ul []
                    [ viewLink "/"
                    , viewLink "/about"
                    , viewLink "/blog/post1"
                    , viewLink "/blog/post2"
                    , viewLink "/wrong-url"
                    , viewLink "https://google.com"
                    ]
                ]
            }

        BlogPost p ->
            { title = p.title, body = [ text p.title, text p.postId ] }

        NotFound p ->
            { title = "not found", body = [ text "not found" ] }

        AboutMe p ->
            { title = "about me", body = [ text "about me" ] }


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path, target "_blank" ] [ text path ] ]
