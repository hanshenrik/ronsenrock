module Main exposing (main)

import Animation exposing (percent, px, turn)
import Browser
import Browser.Navigation as Nav
import Color.Palette exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Url


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , widgets : List Widget
    }


type alias Widget =
    { label : String
    , action : Msg
    , style : Animation.State
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | RotateWidget Int
    | RotateAllAxis Int
    | ChangeColors Int
    | ChangeMultipleColors Int
    | FadeOutFadeIn Int
    | Shadow Int
    | Animate Animation.Msg


onStyle : (Animation.State -> Animation.State) -> Widget -> Widget
onStyle styleFn widget =
    { widget | style = styleFn widget.style }


onIndex : Int -> List a -> (a -> a) -> List a
onIndex i list fn =
    List.indexedMap
        (\j val ->
            if i == j then
                fn val

            else
                val
        )
        list


onWidgetStyle : Model -> Int -> (Animation.State -> Animation.State) -> Model
onWidgetStyle model index fn =
    { model
        | widgets =
            onIndex index model.widgets <|
                onStyle fn
    }


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

        RotateWidget i ->
            ( onWidgetStyle model i <|
                Animation.interrupt
                    [ Animation.to
                        [ Animation.rotate (turn 1) ]
                    , Animation.set
                        [ Animation.rotate (turn 0) ]
                    ]
            , Cmd.none
            )

        RotateAllAxis i ->
            ( onWidgetStyle model i <|
                Animation.interrupt
                    [ Animation.to
                        [ Animation.rotate3d (turn 1) (turn 1) (turn 1)
                        ]
                    , Animation.set
                        [ Animation.rotate3d (turn 0) (turn 0) (turn 0)
                        ]
                    ]
            , Cmd.none
            )

        ChangeColors i ->
            ( onWidgetStyle model i <|
                Animation.interrupt
                    [ Animation.to
                        [ Animation.backgroundColor (rgba 100 100 100 1.0)
                        , Animation.borderColor (rgba 100 100 100 1.0)
                        ]
                    , Animation.to
                        [ Animation.backgroundColor white
                        , Animation.borderColor white
                        ]
                    ]
            , Cmd.none
            )

        ChangeMultipleColors i ->
            ( onWidgetStyle model i <|
                (Animation.interrupt <|
                    List.map
                        (\color ->
                            Animation.to
                                [ Animation.backgroundColor color
                                , Animation.borderColor color
                                ]
                        )
                        [ red
                        , orange
                        , yellow
                        , green
                        , blue
                        , purple
                        , white
                        ]
                )
            , Cmd.none
            )

        FadeOutFadeIn i ->
            ( onWidgetStyle model i <|
                Animation.interrupt
                    [ Animation.to
                        [ Animation.opacity 0
                        ]
                    , Animation.to
                        [ Animation.opacity 1
                        ]
                    ]
            , Cmd.none
            )

        Shadow i ->
            ( onWidgetStyle model i <|
                Animation.interrupt
                    [ Animation.to
                        [ Animation.translate (px 100) (px 100)
                        , Animation.scale 1.2
                        , Animation.shadow
                            { offsetX = 50
                            , offsetY = 55
                            , blur = 15
                            , size = 0
                            , color = rgba 0 0 0 0.1
                            }
                        ]
                    , Animation.to
                        [ Animation.translate (px 0) (px 0)
                        , Animation.scale 1
                        , Animation.shadow
                            { offsetX = 0
                            , offsetY = 1
                            , size = 0
                            , blur = 2
                            , color = rgba 0 0 0 0.1
                            }
                        ]
                    ]
            , Cmd.none
            )

        Animate time ->
            ( { model
                | widgets =
                    List.map
                        (onStyle (Animation.update time))
                        model.widgets
              }
            , Cmd.none
            )


view : Model -> Browser.Document Msg
view model =
    { title = "Rønsenrock 2020"
    , body =
        [ div
            [ style "position" "absolute"
            , style "left" "0px"
            , style "top" "0px"
            , style "width" "100%"
            , style "height" "100%"
            , style "background-color" "#f0f0f0"
            ]
            [ div
                [ style "display" "flex"
                , style "flex-direction" "row"
                , style "flex-wrap" "wrap"
                , style "justify-content" "center"
                , style "position" "absolute"
                , style "left" "0px"
                , style "top" "0px"
                , style "width" "100%"
                ]
                (List.map viewWidget model.widgets)
            ]
        ]
    }


viewWidget : Widget -> Html Msg
viewWidget widget =
    div
        (Animation.render widget.style
            ++ [ style "position" "relative"
               , style "text-align" "center"
               , style "cursor" "pointer"
               , style "border-style" "solid"
               , style "vertical-align" "middle"
               , onMouseOver widget.action
               ]
        )
        [ text widget.label ]


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        initialWidgetStyle =
            Animation.style
                [ Animation.display Animation.inlineBlock
                , Animation.width (px 100)
                , Animation.height (px 100)
                , Animation.margin (px 50)
                , Animation.padding (px 25)
                , Animation.rotate (turn 0.0)
                , Animation.rotate3d (turn 0.0) (turn 0.0) (turn 0.0)
                , Animation.translate (px 0) (px 0)
                , Animation.opacity 1
                , Animation.backgroundColor white
                , Animation.color black
                , Animation.scale 1.0
                , Animation.borderColor white
                , Animation.borderWidth (px 4)
                , Animation.borderRadius (px 8)
                , Animation.translate3d (percent 0) (percent 0) (px 0)
                , Animation.shadow
                    { offsetX = 0
                    , offsetY = 1
                    , size = 0
                    , blur = 2
                    , color = rgba 0 0 0 0.1
                    }
                ]
    in
    ( { key = key
      , url = url
      , widgets =
            [ { label = "Rotate"
              , action = RotateWidget 0
              , style = initialWidgetStyle
              }
            , { label = "Rotate in All Kinds of Ways"
              , action = RotateAllAxis 1
              , style = initialWidgetStyle
              }
            , { label = "Change Colors"
              , action = ChangeColors 2
              , style = initialWidgetStyle
              }
            , { label = "Change Through Multiple Colors"
              , action = ChangeMultipleColors 3
              , style = initialWidgetStyle
              }
            , { label = "Fade Out Fade In"
              , action = FadeOutFadeIn 4
              , style = initialWidgetStyle
              }
            , { label = "Have a Shadow"
              , action = Shadow 5
              , style = initialWidgetStyle
              }
            ]
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate <|
        List.map .style model.widgets


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
