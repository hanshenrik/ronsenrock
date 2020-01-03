module Color exposing (black, darkpink, gray, pink, white, whiteTransparent)

import Element exposing (..)


pink : Color
pink =
    rgb255 255 182 193


darkpink : Color
darkpink =
    rgb255 143 101 108


white : Color
white =
    rgb255 250 250 250


black : Color
black =
    rgb255 21 21 21


gray : Color
gray =
    rgb255 100 100 100


whiteTransparent : Float -> Color
whiteTransparent alpha =
    let
        original =
            toRgb white
    in
    fromRgb <| { original | alpha = alpha }
