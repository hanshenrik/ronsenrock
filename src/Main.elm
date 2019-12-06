module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Color
import Element exposing (..)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Attributes
import Transit exposing (Step(..))
import UI
import Url


type alias Model =
    Transit.WithTransition
        { key : Nav.Key
        , url : Url.Url
        , isMenuOpen : Bool
        , page : Page
        }


type Page
    = LandingPage
    | ProgramPage
    | ArtistsPage


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | Click Page
    | SetPage Page
    | ToggleMenu
    | TransitMsg (Transit.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Click page ->
            Transit.start TransitMsg (SetPage page) ( 200, 200 ) model

        SetPage page ->
            ( { model | page = page }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        ToggleMenu ->
            ( { model | isMenuOpen = not model.isMenuOpen }, Cmd.none )

        TransitMsg transitMsg ->
            Transit.tick TransitMsg transitMsg model


navMenu : Model -> Element Msg
navMenu model =
    el
        [ Region.navigation
        , width (fill |> maximum 300)
        , height fill
        , Background.color Color.lightpink
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
            , link [ UI.class "hoverable", Events.onClick (Click LandingPage) ] { label = text "Hjem", url = "/" }
            , link [ UI.class "hoverable", Events.onClick (Click ProgramPage) ] { label = text "Program", url = "/program" }
            , link [ UI.class "hoverable", Events.onClick (Click ArtistsPage) ] { label = text "Artister", url = "/artister" }
            , link [ UI.class "hoverable" ]
                { label = text "Facebook"
                , url = "https://facebook.com/rockogrull"
                }
            ]


header : Bool -> Element Msg
header isMenuOpen =
    row [ UI.mSpacing, UI.mPadding, width fill ] [ openMenuButton ]


footer : Bool -> Element Msg
footer isMenuOpen =
    column
        [ Region.footer
        , UI.mSpacing
        , UI.mPadding
        , alignBottom
        , centerX
        , width fill
        , UI.class "dimmable"
        , if isMenuOpen then
            UI.dimmed

          else
            UI.class ""
        ]
        [ column [ Font.size 16, centerX, UI.sSpacing ]
            [ row []
                [ text "✉️ "
                , link [ UI.class "hoverable" ] { label = text "post@rønsenrock.no", url = "mailto:post@rønsenrock.no" }
                ]
            , row []
                [ text "🎸 "
                , link [ UI.class "hoverable" ] { label = text "booking@rønsenrock.no", url = "mailto:booking@rønsenrock.no" }
                ]
            , row []
                [ text "🔨 av "
                , link [ UI.class "hoverable" ] { label = text "hanshenrik", url = "https://github.com/hanshenrik" }
                ]
            ]
        ]


toggleMenuButton : Bool -> Element Msg
toggleMenuButton isMenuOpen =
    Input.button [ UI.sPadding, Font.color Color.white, UI.class "hoverable" ]
        { label =
            text <|
                if isMenuOpen then
                    "🍟"

                else
                    "🍔"
        , onPress = Just ToggleMenu
        }


openMenuButton : Element Msg
openMenuButton =
    toggleMenuButton False


closeMenuButton : Element Msg
closeMenuButton =
    toggleMenuButton True


mainContent : Model -> Element Msg
mainContent model =
    column
        [ width fill
        , height fill
        , Region.mainContent
        , UI.class "dimmable"
        , if model.isMenuOpen then
            UI.dimmed

          else
            UI.class ""
        , htmlAttribute <| Html.Attributes.style "margin-bottom" ("" ++ String.fromFloat (20 * Transit.getValue model.transition) ++ "px")
        , htmlAttribute <| Html.Attributes.style "opacity" (String.fromFloat (Transit.getValue model.transition))
        ]
        [ case model.page of
            LandingPage ->
                el [ Region.heading 1, centerX, centerY, UI.class "shake" ] <| text "RønsenRock"

            ProgramPage ->
                column [ centerX ]
                    [ el [ Region.heading 1 ] <| text "Program"
                    , column []
                        []
                    ]

            ArtistsPage ->
                column [ centerX ]
                    [ el [ Region.heading 1 ] <| text "Artists"
                    , column []
                        []
                    ]
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "Rønsenrock 2020"
    , body =
        [ layout [ Background.color Color.black, Font.color Color.white ] <|
            column
                [ width fill
                , height fill
                ]
                [ header model.isMenuOpen
                , navMenu model
                , mainContent model
                , footer model.isMenuOpen
                ]
        ]
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , url = url
      , isMenuOpen = False
      , transition = Transit.empty
      , page = LandingPage
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Transit.subscriptions TransitMsg model


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
