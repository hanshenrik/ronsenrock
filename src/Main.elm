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
import Json.Encode as Encode
import Page.FestivalMap
import Page.History
import Page.Landing
import Page.PracticalInfo
import Page.Program
import Ports
import SmoothScroll exposing (scrollTo)
import Task exposing (Task)
import Time
import Transit exposing (Step(..))
import Transition
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
        , programPanel : Element Page.Program.Msg
        , programPanelState : Page.Program.PanelState
        }


type Page
    = LandingPage
    | HistoryPage
    | PracticalInfoPage
    | FestivalMapPage
    | ProgramPage


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | SetPage Url.Url
    | ToggleMenu (Maybe Bool)
    | Resized Int Int
    | TransitMsg (Transit.Msg Msg)
    | Tick Time.Posix
    | GotProgramPageMsg Page.Program.Msg
    | NoOp


pageFromUrl : Url.Url -> Page
pageFromUrl url =
    case url.path of
        "/" ->
            LandingPage

        "/historie" ->
            HistoryPage

        "/praktisk" ->
            PracticalInfoPage

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
                        , programPanelState = Page.Program.Closed
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

        GotProgramPageMsg subMsg ->
            case subMsg of
                Page.Program.TogglePanel newProgramPanelState newProgramPanel ->
                    let
                        deviceClass =
                            (classifyDevice model.window).class

                        preventScrollMsg =
                            Ports.toggleBodyNoScroll <|
                                Encode.bool <|
                                    case newProgramPanelState of
                                        Page.Program.Open ->
                                            True

                                        Page.Program.Closed ->
                                            False
                    in
                    ( { model | programPanel = newProgramPanel, programPanelState = newProgramPanelState }
                    , case deviceClass of
                        Phone ->
                            preventScrollMsg

                        _ ->
                            Cmd.none
                    )

        NoOp ->
            ( model, Cmd.none )


menuItems : Url.Url -> DeviceClass -> List (Element Msg)
menuItems { path } deviceClass =
    let
        isActive url =
            path == url

        activeIndicator =
            case deviceClass of
                Phone ->
                    onRight <|
                        el
                            [ centerY
                            , width <| px 8
                            , height <| px 8
                            , moveRight 8
                            , UI.xlRoundedCorners
                            , Background.color Color.gray15
                            ]
                            none

                Tablet ->
                    onRight <|
                        el
                            [ centerY
                            , width <| px 8
                            , height <| px 8
                            , moveRight 8
                            , UI.xlRoundedCorners
                            , Background.color Color.gray15
                            ]
                            none

                _ ->
                    below <|
                        el
                            [ centerX
                            , width <| px 21
                            , height <| px 21
                            , Background.color Color.yellow
                            , htmlAttribute <| Html.Attributes.style "transform" "rotate(45deg)"
                            , htmlAttribute <| Html.Attributes.style "margin-top" "5px"
                            ]
                            none

        linkElement { label, url } =
            link
                ([ UI.class "hoverable"
                 , UI.sPadding
                 ]
                    ++ (if isActive url then
                            [ activeIndicator ]

                        else
                            []
                       )
                )
                { label = label, url = url }
    in
    [ linkElement { label = text "🎸 2020", url = "/" }
    , linkElement { label = text "📆 Program", url = "/program" }
    , linkElement { label = text "⛺️ Praktisk info", url = "/praktisk" }
    , linkElement { label = text "🌎 Festivalkart", url = "/festivalkart" }
    , linkElement { label = text "📜 Historie", url = "/historie" }
    ]


navMenu : Model -> Element Msg
navMenu model =
    let
        deviceClass =
            (classifyDevice model.window).class
    in
    case deviceClass of
        Phone ->
            mobileNavMenu model deviceClass

        Tablet ->
            mobileNavMenu model deviceClass

        _ ->
            desktopNavMenu model deviceClass


desktopNavMenu : Model -> DeviceClass -> Element Msg
desktopNavMenu { url } deviceClass =
    el
        [ Region.navigation
        , UI.fillWidth
        , height shrink
        , UI.class "desktop-nav"
        , htmlAttribute <| Html.Attributes.style "position" "sticky"
        , htmlAttribute <| Html.Attributes.style "top" "0"
        , htmlAttribute <| Html.Attributes.style "z-index" "2"
        , htmlAttribute <|
            Html.Attributes.style "background"
                """linear-gradient(122deg
                , rgb(255, 184, 20) 85%
                , rgb(255, 96, 43) 85%
                , rgb(255, 96, 43) 92%
                , rgb(255, 63, 102) 92%
                , rgb(255, 63, 102) 95%
                , rgb(214, 25, 91) 95%)
                """
        , Font.color Color.mainBackground
        , Font.letterSpacing 2
        ]
    <|
        row
            [ UI.mPadding
            , UI.lSpacing
            , centerX
            ]
        <|
            menuItems url deviceClass


mobileNavMenu : Model -> DeviceClass -> Element Msg
mobileNavMenu model deviceClass =
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
        column []
            [ closeMenuButton
            , column [ UI.mPadding, UI.mSpacing ] <| menuItems model.url deviceClass
            ]


toggleMenuButton : Bool -> Element Msg
toggleMenuButton isMenuOpen =
    Input.button
        [ Font.color Color.white
        , Font.size 30
        , UI.class "hoverable-alternative"
        , htmlAttribute <| Html.Attributes.style "position" "sticky"
        , htmlAttribute <| Html.Attributes.style "top" "2px"
        , htmlAttribute <| Html.Attributes.style "z-index" "2"
        , UI.mPadding
        ]
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
        , Background.color Color.mainBackground
        , htmlAttribute <| Html.Attributes.style "position" "relative"
        , htmlAttribute <| Html.Attributes.style "min-height" "100vh"
        , htmlAttribute <| Html.Attributes.style "z-index" "1"
        , inFront <|
            case deviceClass of
                Phone ->
                    openMenuButton

                Tablet ->
                    openMenuButton

                _ ->
                    none
        ]
    <|
        el
            [ UI.fillWidth
            , height fill
            , centerX
            ]
        <|
            case model.page of
                LandingPage ->
                    Page.Landing.view model

                HistoryPage ->
                    Page.History.view model.window

                PracticalInfoPage ->
                    Page.PracticalInfo.view deviceClass

                FestivalMapPage ->
                    Page.FestivalMap.view deviceClass

                ProgramPage ->
                    Element.map GotProgramPageMsg <| Page.Program.view model.programPanel model.programPanelState deviceClass


view : Model -> Browser.Document Msg
view model =
    { title = "RønsenRock 2020"
    , body =
        [ layout
            [ Background.color Color.mainBackground
            , Font.color Color.white
            , UI.bodyFont
            ]
          <|
            column
                [ UI.fillWidth
                , height fill
                , inFront <|
                    el
                        ([ UI.fillWidth
                         , height fill
                         , htmlAttribute <| Html.Attributes.style "z-index" "-1"
                         , Transition.transition [ "background-color" ]
                         , Background.color Color.transparent
                         ]
                            ++ (if model.isMenuOpen then
                                    [ Events.onClick <| ToggleMenu Nothing
                                    , Background.color <| Color.withTransparency Color.black 0.4
                                    , htmlAttribute <| Html.Attributes.style "z-index" "2"
                                    ]

                                else
                                    []
                               )
                        )
                        none
                ]
                [ navMenu model
                , mainContent model
                , Footer.default model.window
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
                  , programPanel = none
                  , programPanelState = Page.Program.Closed
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
