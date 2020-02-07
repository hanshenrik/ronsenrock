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
        deviceClass =
            (classifyDevice window).class

        ( heading2018, move2018Heading, ( height2018Logo, width2018Logo ) ) =
            case deviceClass of
                BigDesktop ->
                    ( UI.h1, -250, ( px 600, px <| round <| 600 * 0.7587719298 ) )

                Desktop ->
                    ( UI.h1, -175, ( px 600, px <| round <| 600 * 0.7587719298 ) )

                _ ->
                    ( UI.h2, -80, ( shrink, fill ) )

        pageHeading =
            case deviceClass of
                Phone ->
                    UI.h2

                _ ->
                    UI.h1
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
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image [ UI.fillWidth, UI.class "shake" ] { src = "/images/logo-2019-mm-transparent.png", description = "Logo 2019" }
                    , artists.y2019
                        |> List.sort
                        |> List.intersperse "•"
                        |> List.map text
                        |> wrappedRow [ UI.fillWidth, UI.sSpacing ]
                    , UI.imageWithAttribution [] { src = "/images/tak-2019-tk.jpg", description = "Fellesbilde 2019", attribution = "Thomas Kvehaugen", isBoxed = False }
                    ]
                ]
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ heading2018 [ centerX, Font.color Color.yellow, htmlAttribute <| Html.Attributes.style "transform" <| "rotate(-25deg) translateX(" ++ String.fromInt move2018Heading ++ "px)" ] <| text "2018"
                , column [ UI.fillWidth, UI.lSpacing ]
                    [ image
                        [ centerX
                        , UI.class "shake"
                        , height height2018Logo
                        , width width2018Logo
                        ]
                        { src = "/images/logo-2018-mm-transparent.png", description = "Logo 2018" }
                    , UI.imageWithAttribution [] { src = "/images/tak-2018-tk.jpg", description = "Fellesbilde 2018", attribution = "Thomas Kvehaugen", isBoxed = False }
                    ]
                ]
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image [ UI.fillWidth, UI.class "shake" ] { src = "/images/logo-2017-mm.png", description = "Logo 2017" }
                    , UI.imageWithAttribution [] { src = "/images/tak-2017-tk.jpg", description = "Fellesbilde 2017", attribution = "Thomas Kvehaugen", isBoxed = False }
                    ]
                ]
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image [ UI.fillWidth, UI.class "shake" ] { src = "/images/logo-2016-mm.png", description = "Logo 2016" }
                    , UI.imageWithAttribution [] { src = "/images/tak-2016-tk.jpg", description = "Fellesbilde 2016", attribution = "Thomas Kvehaugen", isBoxed = False }
                    ]
                ]
        , el [] none
        ]
