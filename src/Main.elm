module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


init : Model
init =
    { artists = []
    , previousArtists = []
    }


type alias Model =
    { artists : List String
    , previousArtists : List String
    }


type Msg
    = ArtistWasStarred


update : Msg -> Model -> Model
update msg model =
    case msg of
        ArtistWasStarred ->
            model


view : Model -> Html.Html Msg
view model =
    Element.layout [ Background.color (rgb255 30 30 30) ]
        myRowOfStuff


myRowOfStuff : Element msg
myRowOfStuff =
    row [ width fill, centerY, spacing 30 ]
        [ el [ centerX ] myElement
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
