module Color exposing (black, pink, white, whiteTransparent)

import Element exposing (..)


pink : Color
pink =
    rgb255 255 182 193


white : Color
white =
    rgb255 250 250 250


black : Color
black =
    rgb255 21 21 21


whiteTransparent : Float -> Color
whiteTransparent alpha =
    let
        original =
            toRgb white
    in
    fromRgb <| { original | alpha = alpha }
