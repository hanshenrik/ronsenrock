module Page.History exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
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


bannerImageAttributes : List (Attribute msg)
bannerImageAttributes =
    [ UI.mSpacing
    , UI.xlPadding
    , Background.color <| Color.whiteTransparent 0.075
    , Border.rounded 2
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
                    (artists.y2019
                        |> List.sort
                        |> List.map text
                    )
                ]
            ]
        , column bannerImageAttributes
            [ UI.h1 <| text "2018"
            , rowOrColumn [ UI.fillWidth ]
                [ image [ UI.fillWidth ] { src = "/images/logo-2018-mm-transparent.png", description = "Logo 2018" }
                ]
            ]
        , column bannerImageAttributes
            [ UI.h1 <| text "2017"
            , rowOrColumn [ UI.fillWidth ]
                [ image [ UI.fillWidth ] { src = "/images/logo-2017-mm.png", description = "Logo 2017" }
                ]
            ]
        , column bannerImageAttributes
            [ UI.h1 <| text "2016"
            , rowOrColumn [ UI.fillWidth ]
                [ image [ UI.fillWidth ] { src = "/images/logo-2016-mm.png", description = "Logo 2016" }
                ]
            ]
        ]
