module Footer exposing (default)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import UI


default : Bool -> Element msg
default isMenuOpen =
    column
        [ Region.footer
        , alignBottom
        , Font.size 16
        , Background.color <| Color.whiteTransparent 0.1
        , UI.mPadding
        , UI.fillWidth
        , UI.class "dimmable"
        , if isMenuOpen then
            UI.dimmed

          else
            UI.class ""
        ]
        [ column [ UI.sSpacing, centerX ]
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
        ]
