module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Color
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Attributes
import UI
import Url


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , isMenuOpen : Bool
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ToggleMenu


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
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


navMenu : Model -> Element Msg
navMenu model =
    column
        [ Region.navigation
        , width (fill |> maximum 300)
        , height fill
        , UI.mPadding
        , UI.mSpacing
        , Background.color Color.lightpink
        , Font.color Color.black
        , Font.center
        , if model.isMenuOpen then
            htmlAttribute <| Html.Attributes.class "open"

          else
            htmlAttribute <| Html.Attributes.class "closed"
        ]
        [ closeMenuButton
        , link [ UI.class "hoverable" ] { label = text "Hjem", url = "/" }
        , link [ UI.class "hoverable" ] { label = text "Historie", url = "/historie" }
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
            UI.class "dimmed"

          else
            UI.class ""
        ]
        [ row [ centerX ]
            [ text "✉️ "
            , link [ UI.class "hoverable" ] { label = text "post@rønsenrock.no", url = "mailto:post@rønsenrock.no" }
            , text " | "
            , link [ UI.class "hoverable" ] { label = text "booking@rønsenrock.no", url = "mailto:booking@rønsenrock.no" }
            ]
        , row [ centerX ]
            [ text "🔨 av "
            , link [ UI.class "hoverable" ] { label = text "hanshenrik", url = "https://github.com/hanshenrik" }
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


mainContent : Bool -> Element Msg
mainContent isMenuOpen =
    column
        [ width fill
        , height fill
        , Region.mainContent
        , UI.class "dimmable"
        , if isMenuOpen then
            UI.class "dimmed"

          else
            UI.class ""
        ]
        [ el [ Region.heading 1, centerX, centerY ] <| text "RønsenRock" ]


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
                , mainContent model.isMenuOpen
                , footer model.isMenuOpen
                ]
        ]
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , url = url
      , isMenuOpen = False
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


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
