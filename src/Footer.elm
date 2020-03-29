module Footer exposing (default)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Html.Attributes
import Type.Window exposing (Window)
import UI


default : Window -> Element msg
default window =
    el
        [ Region.footer
        , htmlAttribute <| Html.Attributes.style "position" "sticky"
        , htmlAttribute <| Html.Attributes.style "bottom" "0"
        , Font.size 16
        , Background.color <| Color.withTransparency Color.white 0.2
        , UI.xlPadding
        , UI.fillWidth
        ]
    <|
        UI.rowOrColumn window
            [ centerX, UI.lSpacing ]
            [ column [ alignTop, UI.sSpacing ]
                [ row []
                    [ newTabLink [] { label = text "✉️ post@rønsenrock.no", url = "mailto:post@rønsenrock.no" }
                    ]
                , row []
                    [ newTabLink [] { label = text "🎸 booking@rønsenrock.no", url = "mailto:booking@rønsenrock.no" }
                    ]
                , row []
                    [ newTabLink [] { label = text "🔨 hanshenrik", url = "https://github.com/hanshenrik" }
                    ]
                ]
            , UI.divider window
            , column [ alignTop, UI.sSpacing ]
                [ newTabLink [] { label = text "🙂📘 Facebook", url = "https://facebook.com/rockogrull" }
                , newTabLink [] { label = text "📸 Instagram", url = "https://www.instagram.com/ronsen_rock/" }
                ]
            ]
