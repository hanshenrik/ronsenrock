module Page.History exposing (view)

import Element exposing (..)
import Type.Window exposing (Window)
import UI


bannerImageAttributes : List (Attribute msg)
bannerImageAttributes =
    [ UI.mSpacing
    , UI.mPadding
    ]


view : Window -> Element msg
view window =
    let
        rowOrColumn =
            case (classifyDevice window).class of
                BigDesktop ->
                    row

                _ ->
                    column
    in
    column
        [ UI.lSpacing
        , centerX
        , width
            (fill
                |> maximum 800
            )
        ]
        [ column bannerImageAttributes
            [ UI.h1 <| text "2019"
            , rowOrColumn [ UI.fillWidth ]
                [ image [ UI.fillWidth ] { src = "/images/logo-2019-mm-transparent.png", description = "Logo 2019" }
                , column [ UI.sSpacing, alignTop ]
                    [ text "Inglorious Retards"
                    , text "AARB"
                    , text "Astralplane"
                    , text "Drukkenbolt"
                    , text "Dance Commander"
                    , text "Dømt"
                    , text "Helt Greit Band"
                    , text "Helmer"
                    , text "Impaired"
                    , text "The Loop Brothers"
                    , text "Andreas Fagertun"
                    , text "Janos"
                    , text "Levitation B Band"
                    , text "Blacklands"
                    , text "Bolt"
                    , text "!Pysh"
                    , text "Thundering Voices"
                    , text "Sorgen"
                    ]
                ]
            ]
        , UI.horisontalDivider
        , column bannerImageAttributes
            [ UI.h1 <| text "2018"
            , rowOrColumn [ UI.fillWidth ]
                [ image [ UI.fillWidth ] { src = "/images/logo-2018-mm-transparent.png", description = "Logo 2018" }
                ]
            ]
        , UI.horisontalDivider
        , column bannerImageAttributes
            [ UI.h1 <| text "2017"
            , rowOrColumn [ UI.fillWidth ]
                [ image [ UI.fillWidth ] { src = "/images/logo-2017-mm.png", description = "Logo 2017" }
                ]
            ]
        , UI.horisontalDivider
        , column bannerImageAttributes
            [ UI.h1 <| text "2016"
            , rowOrColumn [ UI.fillWidth ]
                [ image [ UI.fillWidth ] { src = "/images/logo-2016-mm.png", description = "Logo 2016" }
                ]
            ]
        ]
