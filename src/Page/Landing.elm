module Page.Landing exposing (view)

import Countdown
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html as Html
import Html.Attributes
import Type.Window exposing (Window)
import UI


view : { a | window : Window, time : Int } -> Element msg
view { window, time } =
    let
        logoSize =
            case (classifyDevice window).class of
                Phone ->
                    300

                BigDesktop ->
                    600

                _ ->
                    500
    in
    column [ UI.fillWidth, centerY, UI.lSpacing ]
        [ el
            [ Background.uncropped "/images/logo-2018-mm-transparent.png"
            , centerX
            , centerY
            , height <| px logoSize
            , width <| px logoSize
            , UI.class "shake"
            ]
            none
        , column [ centerX, Font.center, UI.sSpacing ]
            [ el [ Font.center, UI.fillWidth ] <| text "Spille på RønsenROCK2020?"
            , paragraph [ Font.center ]
                [ text "Send mail til "
                , link [ UI.class "hoverable" ] { label = text "booking@rønsenrock.no", url = "mailto:booking@rønsenrock.no" }
                ]
            ]
        , el [ centerX ] <| Countdown.view window time
        , el [ centerX ] <|
            html <|
                Html.iframe
                    [ Html.Attributes.src "https://open.spotify.com/embed/user/1113006308/playlist/6FfNqW0AcFkrhlUaDfqfpD?si=S36Q1tleRB6w5MYvFWtS2g"
                    , Html.Attributes.style "border" "none"
                    , Html.Attributes.style "height" "400px"
                    , Html.Attributes.style "width" "600px"
                    , Html.Attributes.style "max-width" "100%"
                    ]
                    []
        ]
