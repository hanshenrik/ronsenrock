module Main exposing (main)

import Animation as Animation
import Browser
import Browser.Navigation as Nav
import Color.Palette as Color
import Element exposing (Element, fill, htmlAttribute, layout, link, padding, row, spacing, text, width)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Url


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , isMenuOpen : Bool
    , menuStyle : Animation.State
    , toggleMenuButtonStyle : Animation.State
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | ToggleMenu
    | Animate Animation.Msg


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
            let
                newMenuStyle =
                    if model.isMenuOpen then
                        [ Animation.top (Animation.rem -4), Animation.opacity 0.0 ]

                    else
                        [ Animation.top (Animation.rem 0), Animation.opacity 1.0 ]

                newToggleMenuButtonStyle =
                    if model.isMenuOpen then
                        [ Animation.top (Animation.rem 0), Animation.opacity 1.0 ]

                    else
                        [ Animation.top (Animation.rem -4), Animation.opacity 0.0 ]
            in
            ( { model
                | isMenuOpen = not model.isMenuOpen
                , menuStyle = Animation.interrupt [ Animation.to newMenuStyle ] model.menuStyle
                , toggleMenuButtonStyle = Animation.interrupt [ Animation.to newToggleMenuButtonStyle ] model.toggleMenuButtonStyle
              }
            , Cmd.none
            )

        Animate animateMsg ->
            ( { model | menuStyle = Animation.update animateMsg model.menuStyle }
            , Cmd.none
            )


navMenu : Animation.State -> Element Msg
navMenu animationStyle =
    row
        (List.map htmlAttribute (Animation.render animationStyle) ++ [ width fill, padding 16, spacing 16, Background.color Color.lightpink, Font.color Color.black ])
        [ toggleMenuButton animationStyle
        , link [] { label = text "Hjem", url = "/" }
        , link [] { label = text "Historie", url = "/historie" }
        , link []
            { label = text "Facebook"
            , url = "https://facebook.com/rockogrull"
            }
        ]


toggleMenuButton : Animation.State -> Element Msg
toggleMenuButton animationStyle =
    Input.button (List.map htmlAttribute (Animation.render animationStyle) ++ [ spacing 8, padding 8, Font.color Color.white ])
        { label = text "🍔"
        , onPress = Just ToggleMenu
        }


view : Model -> Browser.Document Msg
view model =
    { title = "Rønsenrock 2020"
    , body =
        [ layout [ Background.color Color.black, Font.color Color.white ] <|
            row [ width fill ]
                [ toggleMenuButton model.toggleMenuButtonStyle
                , navMenu model.menuStyle
                ]
        ]
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , url = url
      , isMenuOpen = False
      , menuStyle =
            Animation.style
                [ Animation.top (Animation.rem -4)
                , Animation.opacity 0.0
                ]
      , toggleMenuButtonStyle =
            Animation.style
                [ Animation.top (Animation.rem 0)
                , Animation.opacity 1.0
                ]
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model.menuStyle ]


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
