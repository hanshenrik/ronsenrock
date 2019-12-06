module UI exposing (class, dimmed, fillWidth, lPadding, lSpacing, mPadding, mSpacing, rowOrColumn, sPadding, sSpacing, xlSpacing)

import Element exposing (..)
import Html.Attributes
import Type.Window exposing (Window)


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
    spacing <| 9 * 2


lSpacing : Attribute msg
lSpacing =
    spacing <| 9 * 4


xlSpacing : Attribute msg
xlSpacing =
    spacing <| 9 * 12


fillWidth : Attribute msg
fillWidth =
    width fill


rowOrColumn : Window -> (List (Attribute msg) -> List (Element msg) -> Element msg)
rowOrColumn window =
    case (classifyDevice window).class of
        Phone ->
            column

        _ ->
            row
