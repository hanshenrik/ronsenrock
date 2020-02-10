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
    [ UI.lSpacing
    , UI.responsivePadding window
    , UI.fillWidth
    ]


view : Window -> Element msg
view window =
    let
        deviceClass =
            (classifyDevice window).class

        ( imageHeading, move2018Heading, ( height2018Logo, width2018Logo ) ) =
            case deviceClass of
                BigDesktop ->
                    ( UI.h1, -250, ( px 600, px <| round <| 600 * 0.7587719298 ) )

                Desktop ->
                    ( UI.h1, -175, ( px 600, px <| round <| 600 * 0.7587719298 ) )

                _ ->
                    ( UI.h3, -75, ( shrink, fill ) )

        ( pageHeading, imagePadding ) =
            case deviceClass of
                Phone ->
                    ( UI.h2, UI.sPadding )

                _ ->
                    ( UI.h1, UI.lPadding )
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
        [ UI.p <| pageHeading [ Font.color Color.yellow, centerX ] <| text "Tidligere artister"
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ image
                    (UI.fillWidth
                        :: centerX
                        :: imagePadding
                        :: UI.class "shake"
                        :: UI.boxed
                    )
                    { src = "/images/logo-2019-mm-transparent.png", description = "Logo 2019" }
                , artists.y2019
                    |> List.sort
                    |> List.intersperse "•"
                    |> List.map text
                    |> wrappedRow [ UI.fillWidth, UI.sSpacing ]
                , image [ UI.fillWidth ] { src = "/images/tak-2019-tk.jpg", description = "Fellesbilde 2019" }
                ]
        , el [ moveUp (9 * 3), UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column
                    (UI.fillWidth
                        :: imagePadding
                        :: UI.class "shake"
                        :: UI.boxed
                    )
                    [ imageHeading [ centerX, Font.color Color.yellow, htmlAttribute <| Html.Attributes.style "transform" <| "rotate(-30deg) translateX(" ++ String.fromInt move2018Heading ++ "px)" ] <| text "2018"
                    , image
                        [ centerX
                        , UI.fillWidth
                        , height height2018Logo
                        , width width2018Logo
                        ]
                        { src = "/images/logo-2018-mm-transparent.png", description = "Logo 2018" }
                    ]
                , image [ UI.fillWidth ] { src = "/images/tak-2018-tk.jpg", description = "Fellesbilde 2018" }
                ]
        , el [ moveUp (9 * 3), UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image
                        (UI.fillWidth
                            :: imagePadding
                            :: UI.class "shake"
                            :: UI.boxed
                        )
                        { src = "/images/logo-2017-mm.png", description = "Logo 2017" }
                    , image [ UI.fillWidth ] { src = "/images/tak-2017-tk.jpg", description = "Fellesbilde 2017" }
                    ]
                ]
        , el [ moveUp (9 * 3), UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image
                        (UI.fillWidth
                            :: imagePadding
                            :: UI.class "shake"
                            :: UI.boxed
                        )
                        { src = "/images/logo-2016-mm.png", description = "Logo 2016" }
                    , image [ UI.fillWidth ] { src = "/images/tak-2016-tk.jpg", description = "Fellesbilde 2016" }
                    ]
                ]
        , el [ moveUp (9 * 3), UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column
                    (UI.fillWidth
                        :: imagePadding
                        :: UI.class "shake"
                        :: UI.boxed
                    )
                    [ imageHeading [ UI.sPadding, centerX, Font.color Color.yellow ] <| text "2015"
                    , image
                        [ UI.fillWidth
                        , centerX
                        ]
                        { src = "/images/logo-2015.jpg", description = "Logo 2015" }
                    ]
                , image [ UI.fillWidth ] { src = "/images/tak-2015-1-tk.jpg", description = "Fellesbilde 2015" }
                ]
        , el [] none
        ]
