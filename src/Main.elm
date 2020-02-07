module Main exposing (main)

import Browser
import Browser.Events as Browser
import Browser.Navigation as Nav
import Color
import Ease
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
import Page.About
import Page.FestivalMap
import Page.History
import Page.Landing
import Page.PracticalInfo
import Page.Program
import SmoothScroll exposing (scrollTo)
import Task exposing (Task)
import Time
import Transit exposing (Step(..))
import Type.Flags as Flags
import Type.Window exposing (Window)
import UI
import Url
import Url.Parser as Url


scrollTo : Float -> Task x ()
scrollTo =
    SmoothScroll.scrollTo <| SmoothScroll.createConfig Ease.inOutQuint 400


scrollToTop : Cmd Msg
scrollToTop =
    Task.attempt (always NoOp) (scrollTo 0)


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
    | PracticalInfoPage
    | FestivalMapPage
    | AboutPage
    | ProgramPage


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | SetPage Url.Url
    | ToggleMenu (Maybe Bool)
    | Resized Int Int
    | TransitMsg (Transit.Msg Msg)
    | Tick Time.Posix
    | NoOp


pageFromUrl : Url.Url -> Page
pageFromUrl url =
    case url.path of
        "/" ->
            LandingPage

        "/tidligere-artister" ->
            HistoryPage

        "/praktisk" ->
            PracticalInfoPage

        "/om" ->
            AboutPage

        "/festivalkart" ->
            FestivalMapPage

        "/program" ->
            ProgramPage

        _ ->
            LandingPage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resized x y ->
            ( { model | window = { width = x, height = y } }, Cmd.none )

        SetPage url ->
            ( { model | page = pageFromUrl url, url = url }, scrollToTop )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            if model.url == url then
                ( { model
                    | isMenuOpen = False
                  }
                , scrollToTop
                )

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

        NoOp ->
            ( model, Cmd.none )


menuItems : List (Element Msg)
menuItems =
    [ link [ UI.class "hoverable", UI.sPadding ] { label = text "🎸 Hjem", url = "/" }
    , link [ UI.class "hoverable", UI.sPadding ] { label = text "📆 Program", url = "/program" }
    , link [ UI.class "hoverable", UI.sPadding ] { label = text "⛺️ Praktisk info", url = "/praktisk" }
    , link [ UI.class "hoverable", UI.sPadding ] { label = text "\u{1F9ED} Festivalkart", url = "/festivalkart" }
    , link [ UI.class "hoverable", UI.sPadding ] { label = text "📜 Tidligere artister", url = "/tidligere-artister" }
    , link [ UI.class "hoverable", UI.sPadding ] { label = text "ℹ️ Om RønsenROCK", url = "/om" }
    ]


navMenu : Model -> Element Msg
navMenu model =
    let
        deviceClass =
            (classifyDevice model.window).class
    in
    case deviceClass of
        Phone ->
            mobileNavMenu model

        Tablet ->
            mobileNavMenu model

        _ ->
            desktopNavMenu model


desktopNavMenu : Model -> Element Msg
desktopNavMenu model =
    el
        [ Region.navigation
        , UI.fillWidth
        , height shrink
        , htmlAttribute <| Html.Attributes.style "position" "sticky"
        , htmlAttribute <| Html.Attributes.style "top" "0"
        , htmlAttribute <| Html.Attributes.style "z-index" "2"
        , htmlAttribute <|
            Html.Attributes.style "background"
                """linear-gradient(122deg
                , rgb(255, 184, 20) 50%
                , rgb(255, 96, 43) 50%
                , rgb(255, 96, 43) 60%
                , rgb(255, 63, 102) 60%
                , rgb(255, 63, 102) 80%
                , rgb(214, 25, 91) 80%)
                """
        , Border.shadow
            { offset = ( 0, 0 )
            , size = 1
            , blur = 4
            , color = Color.gray15
            }
        , Font.color Color.mainBackground
        , Font.letterSpacing 2
        ]
    <|
        row
            [ UI.sPadding
            , UI.lSpacing
            , centerX
            ]
            menuItems


mobileNavMenu : Model -> Element Msg
mobileNavMenu model =
    el
        [ Region.navigation
        , width (fill |> maximum 280)
        , height fill
        , htmlAttribute <|
            Html.Attributes.style "background"
                """linear-gradient(150deg
                , rgb(255, 184, 20) 70%
                , rgb(255, 96, 43) 70%
                , rgb(255, 96, 43) 80%
                , rgb(255, 63, 102) 80%
                , rgb(255, 63, 102) 85%
                , rgb(214, 25, 91) 85%)
                """
        , Border.shadow
            { offset = ( 0, 0 )
            , size = 1
            , blur = 4
            , color = Color.gray15
            }
        , Font.color Color.black
        , Font.center
        , UI.class "mobile-nav"
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
            (closeMenuButton
                :: menuItems
            )


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
    let
        deviceClass =
            (classifyDevice model.window).class
    in
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
            , height fill
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

                PracticalInfoPage ->
                    Page.PracticalInfo.view deviceClass

                AboutPage ->
                    Page.About.view deviceClass

                FestivalMapPage ->
                    Page.FestivalMap.view deviceClass

                ProgramPage ->
                    Page.Program.view deviceClass


view : Model -> Browser.Document Msg
view model =
    { title = "RønsenRock 2020"
    , body =
        [ layout [ Background.color Color.mainBackground, Font.color Color.white, UI.bodyFont ] <|
            column
                [ UI.fillWidth
                , height fill
                , inFront <|
                    el
                        [ htmlAttribute <| Html.Attributes.style "position" "sticky"
                        , htmlAttribute <| Html.Attributes.style "top" "0"
                        , UI.mSpacing
                        , UI.mPadding
                        ]
                        openMenuButton
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
