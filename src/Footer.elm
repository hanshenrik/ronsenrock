module Footer exposing (default)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Type.Window exposing (Window)
import UI


default : Window -> Bool -> Element msg
default window isMenuOpen =
    el
        [ Region.footer
        , alignBottom
        , Font.size 16
        , Background.color <| Color.whiteTransparent 0.1
        , UI.lPadding
        , UI.xlSpacing
        , UI.fillWidth
        , UI.class "dimmable"
        , if isMenuOpen then
            UI.dimmed

          else
            UI.class ""
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
