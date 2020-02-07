module Color exposing
    ( black
    , blackTransparent
    , darkPink
    , gray
    , gray15
    , lightYellow
    , lightblack
    , mainBackground
    , orange
    , pink
    , transparent
    , white
    , whiteTransparent
    , yellow
    )

import Element exposing (..)


pink : Color
pink =
    rgb255 255 63 102


darkPink : Color
darkPink =
    rgb255 214 25 91


white : Color
white =
    rgb255 250 250 250


transparent : Color
transparent =
    rgba255 0 0 0 0


lightblack : Color
lightblack =
    rgb255 21 21 21


black : Color
black =
    rgb255 2 2 2


yellow : Color
yellow =
    rgb255 255 184 20


lightYellow : Color
lightYellow =
    rgb255 248 198 82


orange : Color
orange =
    rgb255 255 96 43


mainBackground : Color
mainBackground =
    rgb255 26 26 26


gray : Color
gray =
    rgb255 100 100 100


gray15 : Color
gray15 =
    rgb255 50 50 50


whiteTransparent : Float -> Color
whiteTransparent alpha =
    let
        original =
            toRgb white
    in
    fromRgb <| { original | alpha = alpha }


blackTransparent : Float -> Color
blackTransparent alpha =
    let
        original =
            toRgb black
    in
    fromRgb <| { original | alpha = alpha }
