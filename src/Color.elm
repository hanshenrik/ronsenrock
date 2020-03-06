module Color exposing
    ( black
    , darkPink
    , gray
    , gray15
    , lightPink
    , lightYellow
    , lightblack
    , mainBackground
    , orange
    , pink
    , transparent
    , white
    , withTransparency
    , yellow
    )

import Element exposing (..)


pink : Color
pink =
    rgb255 255 63 102


lightPink : Color
lightPink =
    rgb255 252 154 174


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


withTransparency : Color -> Float -> Color
withTransparency original alpha =
    let
        originalRgb =
            toRgb original
    in
    fromRgb <| { originalRgb | alpha = alpha }
