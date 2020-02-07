module Page.History exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html.Attributes
import List.Extra as List
import Type.Window exposing (Window)
import UI


artists : { y2019 : List String, y2018 : List String }
artists =
    { y2019 =
        [ "Inglorious Retards"
        , "AARB"
        , "Astralplane"
        , "Drukkenbolt"
        , "Dance Commander"
        , "Dømt"
        , "Helt Greit Band"
        , "Helmer"
        , "Impaired"
        , "The Loop Brothers"
        , "Andreas Fagertun"
        , "Janos"
        , "Levitation B Band"
        , "Blacklands"
        , "Bolt"
        , "!Pysh"
        , "Thundering Voices"
        , "Sorgen"
        ]
    , y2018 = []
    }


bannerImageAttributes : Window -> List (Attribute msg)
bannerImageAttributes window =
    UI.mSpacing
        :: UI.responsivePadding window
        :: UI.boxed


view : Window -> Element msg
view window =
    let
        ( heading, move2018Heading ) =
            case (classifyDevice window).class of
                BigDesktop ->
                    ( UI.h1, -200 )

                Desktop ->
                    ( UI.h1, -100 )

                _ ->
                    ( UI.h2, -100 )
    in
    column
        [ UI.lSpacing
        , UI.mPadding
        , centerX
        , width
            (fill
                |> maximum 1000
            )
        ]
        [ el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image [ UI.fillWidth ] { src = "/images/logo-2019-mm-transparent.png", description = "Logo 2019" }
                    , artists.y2019
                        |> List.sort
                        |> List.map text
                        |> wrappedRow [ UI.fillWidth, UI.mSpacing ]
                    , image [ UI.fillWidth ] { src = "/images/tak-2019-tk.jpg", description = "Fellesbilde 2019" }
                    ]
                ]
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ heading [ centerX, Font.color Color.yellow, htmlAttribute <| Html.Attributes.style "transform" <| "rotate(-30deg) translateX(" ++ String.fromInt move2018Heading ++ "px)" ] <| text "2018"
                , column [ UI.fillWidth ]
                    [ image [ UI.fillWidth ] { src = "/images/logo-2018-mm-transparent.png", description = "Logo 2018" }
                    , image [ UI.fillWidth ] { src = "/images/tak-2018-tk.jpg", description = "Fellesbilde 2018" }
                    ]
                ]
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth ]
                    [ image [ UI.fillWidth ] { src = "/images/logo-2017-mm.png", description = "Logo 2017" }
                    , image [ UI.fillWidth ] { src = "/images/tak-2017-tk.jpg", description = "Fellesbilde 2017" }
                    ]
                ]
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth ]
                    [ image [ UI.fillWidth ] { src = "/images/logo-2016-mm.png", description = "Logo 2016" }
                    , image [ UI.fillWidth ] { src = "/images/tak-2016-tk.jpg", description = "Fellesbilde 2016" }
                    ]
                ]
        ]
