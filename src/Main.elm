module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html
import Url


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


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url, Cmd.none )


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "RønsenROCK 2020"
    , body =
        [ Element.layout
            [ Background.color (rgb255 30 30 30) ]
            myRowOfStuff
        ]
    }


myRowOfStuff : Element msg
myRowOfStuff =
    column [ width fill, centerY, centerX, spacing 30 ]
        [ row [ centerX ]
            [ link
                [ Background.color (rgb255 240 0 245)
                , Font.color (rgb255 255 255 255)
                , Font.size 50
                , padding 50
                ]
                { url = "/"
                , label = text "RønsenROCK 2020"
                }
            ]
        , row [ centerX ]
            [ link
                [ Background.color (rgb255 240 0 245)
                , Font.color (rgb255 255 255 255)
                , Font.size 50
                , padding 50
                ]
                { url = "/historie"
                , label = text "Historie"
                }
            ]
        , row [ centerX ]
            [ link
                [ Background.color (rgb255 240 0 245)
                , Font.color (rgb255 255 255 255)
                , Font.size 50
                , padding 50
                ]
                { url = "https://facebook.com/rockogrull"
                , label = text "Facebook"
                }
            ]
        ]


myElement : Element msg
myElement =
    el
        [ Background.color (rgb255 240 0 245)
        , Font.color (rgb255 255 255 255)
        , Font.size 50
        , padding 50
        ]
        (text "RønsenROCK 2020")
