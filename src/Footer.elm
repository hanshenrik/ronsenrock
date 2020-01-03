module Footer exposing (default)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Type.Window exposing (Window)
import UI


default : Window -> Bool -> Element msg
default window isMenuOpen =
    el
        [ Region.footer
        , alignBottom
        , Font.size 16
        , Background.color <| Color.whiteTransparent 0.075
        , UI.lPadding
        , UI.fillWidth
        ]
    <|
        UI.rowOrColumn window
            [ centerX, UI.lSpacing ]
            [ column [ alignTop, UI.sSpacing ]
                [ row []
                    [ text "✉️ "
                    , link [ UI.class "hoverable" ] { label = text "post@rønsenrock.no", url = "mailto:post@rønsenrock.no" }
                    ]
                , row []
                    [ text "🎸 "
                    , link [ UI.class "hoverable" ] { label = text "booking@rønsenrock.no", url = "mailto:booking@rønsenrock.no" }
                    ]
                , row []
                    [ text "🔨 av "
                    , link [ UI.class "hoverable" ] { label = text "hanshenrik", url = "https://github.com/hanshenrik" }
                    ]
                ]
            , UI.divider window
            , column [ alignTop, UI.sSpacing ]
                [ link [ UI.class "hoverable" ] { label = text "Facebook", url = "https://facebook.com/rockogrull" }
                ]
            ]
