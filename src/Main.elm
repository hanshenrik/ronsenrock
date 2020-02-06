module Main exposing (main)

import Browser
import Browser.Events as Browser
import Browser.Navigation as Nav
import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Footer
import Html.Attributes
import Json.Decode as Decode
import Page.History
import Page.Landing
import Time
import Transit exposing (Step(..))
import Type.Flags as Flags
import Type.Window exposing (Window)
import UI
import Url
import Url.Parser as Url


type alias Model =
    Transit.WithTransition
        { key : Nav.Key
        , url : Url.Url
        , isMenuOpen : Bool
        , page : Page
        , window : Window
        , time : Int
        }


type Page
    = LandingPage
    | HistoryPage


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | SetPage Url.Url
    | ToggleMenu (Maybe Bool)
    | Resized Int Int
    | TransitMsg (Transit.Msg Msg)
    | Tick Time.Posix


pageFromUrl : Url.Url -> Page
pageFromUrl url =
    case url.path of
        "/" ->
            LandingPage

        "/historie" ->
            HistoryPage

        _ ->
            LandingPage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resized x y ->
            ( { model | window = { width = x, height = y } }, Cmd.none )

        SetPage url ->
            ( { model | page = pageFromUrl url, url = url }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            if model.url == url then
                ( model, Cmd.none )

            else
                Transit.start TransitMsg
                    (SetPage url)
                    ( 0, 300 )
                    { model
                        | isMenuOpen = False
                    }

        ToggleMenu maybeState ->
            ( { model | isMenuOpen = Maybe.withDefault (not model.isMenuOpen) maybeState }, Cmd.none )

        TransitMsg transitMsg ->
            Transit.tick TransitMsg transitMsg model

        Tick time ->
            let
                millis =
                    Time.posixToMillis time
            in
            ( { model | time = millis }
            , Cmd.none
            )


header : Bool -> Element Msg
header isMenuOpen =
    row [ UI.class "position-sticky", UI.mSpacing, UI.mPadding, UI.fillWidth ] [ openMenuButton ]


navMenu : Model -> Element Msg
navMenu model =
    el
        [ Region.navigation
        , width (fill |> maximum 300)
        , height fill
        , Background.color Color.yellow
        , Border.shadow
            { offset = ( 0, 0 )
            , size = 1
            , blur = 4
            , color = Color.gray
            }
        , Font.color Color.black
        , Font.center
        , if model.isMenuOpen then
            htmlAttribute <| Html.Attributes.class "open"

          else
            htmlAttribute <| Html.Attributes.class "closed"
        ]
    <|
        column
            [ UI.mPadding
            , UI.mSpacing
            ]
            [ closeMenuButton
            , link [ UI.class "hoverable" ] { label = text "Hjem", url = "/" }
            , link [ UI.class "hoverable" ] { label = text "Historie", url = "/historie" }
            ]


toggleMenuButton : Bool -> Element Msg
toggleMenuButton isMenuOpen =
    Input.button [ UI.sPadding, Font.color Color.white, Font.size 30, UI.class "hoverable-alternative" ]
        { label =
            text <|
                if isMenuOpen then
                    "🍟"

                else
                    "🍔"
        , onPress = Just <| ToggleMenu Nothing
        }


openMenuButton : Element Msg
openMenuButton =
    toggleMenuButton False


closeMenuButton : Element Msg
closeMenuButton =
    toggleMenuButton True


mainContent : Model -> Element Msg
mainContent model =
    el
        [ UI.fillWidth
        , height fill
        , paddingEach { top = 9 * 6, right = 0, bottom = 0, left = 0 }
        , Region.mainContent
        ]
    <|
        el
            [ UI.class "dimmable"
            , UI.fillWidth
            , centerX
            , if model.isMenuOpen then
                UI.dimmed

              else
                UI.class ""
            ]
        <|
            case model.page of
                LandingPage ->
                    Page.Landing.view model

                HistoryPage ->
                    Page.History.view model.window


view : Model -> Browser.Document Msg
view model =
    { title = "RønsenRock 2020"
    , body =
        [ layout [ Background.color Color.mainBackground, Font.color Color.white, UI.bodyFont ] <|
            column
                [ UI.fillWidth
                , height fill
                , inFront <| header model.isMenuOpen
                ]
                [ navMenu model
                , mainContent model
                , el [ UI.fillWidth, Events.onClick <| ToggleMenu (Just False) ] <| Footer.default model.window model.isMenuOpen
                ]
        ]
    }


init : Decode.Value -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    Flags.decode flags
        |> (\{ window, time } ->
                ( { key = key
                  , url = url
                  , isMenuOpen = False
                  , transition = Transit.empty
                  , page = pageFromUrl url
                  , window = window
                  , time = Time.posixToMillis time
                  }
                , Cmd.none
                )
           )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Transit.subscriptions TransitMsg model
        , Browser.onResize Resized
        , Time.every 1000 Tick
        ]


main : Program Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
