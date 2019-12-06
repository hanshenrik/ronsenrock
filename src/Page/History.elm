module Page.History exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Attributes
import UI


bannerImageAttributes : List (Attribute msg)
bannerImageAttributes =
    [ UI.sSpacing
    , centerX
    , width
        (fill
            |> maximum 1000
        )
    ]


view : Element msg
view =
    column [ UI.lSpacing, UI.fillWidth ]
        [ column bannerImageAttributes
            [ image [ UI.fillWidth ] { src = "/images/logo-2019-mm.png", description = "Logo 2019" }
            ]
        , column bannerImageAttributes
            [ image [ UI.fillWidth ] { src = "/images/logo-2018-mm.jpg", description = "Logo 2018" }
            ]
        , column bannerImageAttributes
            [ image [ UI.fillWidth ] { src = "/images/logo-2017-mm.png", description = "Logo 2017" }
            ]
        , column bannerImageAttributes
            [ image [ UI.fillWidth ] { src = "/images/logo-2016-mm.png", description = "Logo 2016" }
            ]
        , column bannerImageAttributes
            [ image [ UI.fillWidth ] { src = "/images/logo-2015.jpg", description = "Logo 2015" }
            ]
        ]
