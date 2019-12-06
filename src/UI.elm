module UI exposing (class, dimmed, lPadding, lSpacing, mPadding, mSpacing, sPadding, sSpacing)

import Element exposing (..)
import Html.Attributes


class : String -> Attribute msg
class name =
    htmlAttribute <| Html.Attributes.class name


dimmed : Attribute msg
dimmed =
    htmlAttribute <| Html.Attributes.style "opacity" "0.5"


sPadding : Attribute msg
sPadding =
    padding 9


mPadding : Attribute msg
mPadding =
    padding 18


lPadding : Attribute msg
lPadding =
    padding 36


sSpacing : Attribute msg
sSpacing =
    spacing 9


mSpacing : Attribute msg
mSpacing =
    spacing 18


lSpacing : Attribute msg
lSpacing =
    spacing 36
