module Page.Landing exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Attributes
import Type.Window exposing (Window)
import UI


view : Window -> Element msg
view window =
    let
        logoSize =
            case (classifyDevice window).class of
                Phone ->
                    300

                BigDesktop ->
                    800

                _ ->
                    500
    in
    el
        [ Background.uncropped "/images/logo-2018-mm-transparent.png"
        , centerX
        , centerY
        , height <| px logoSize
        , width <| px logoSize
        , UI.class "shake"
        ]
        none
