module UI exposing
    ( class
    , dimmed
    , divider
    , fillWidth
    , h1
    , h2
    , h3
    , horisontalDivider
    , lPadding
    , lSpacing
    , mPadding
    , mSpacing
    , responsivePadding
    , roundedCorners
    , rowOrColumn
    , sPadding
    , sSpacing
    , verticalDivider
    , xlPadding
    , xlSpacing
    , xsSpacing
    )

import Color
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html.Attributes
import Type.Window exposing (Window)


heading : Int -> List (Attribute msg) -> Element msg -> Element msg
heading size attributes =
    el (Region.heading size :: attributes)


h1 : Element msg -> Element msg
h1 =
    heading 1 [ Font.size 64 ]


h2 : Element msg -> Element msg
h2 =
    heading 2 [ Font.size 32 ]


h3 : Element msg -> Element msg
h3 =
    heading 3 [ Font.size 24 ]


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
    padding <| 9 * 2


lPadding : Attribute msg
lPadding =
    padding <| 9 * 4


xlPadding : Attribute msg
xlPadding =
    padding <| 9 * 8


responsivePadding : Window -> Attribute msg
responsivePadding { width } =
    padding <| clamp 9 (9 * 8) (9 * width // 320)


xsSpacing : Attribute msg
xsSpacing =
    spacing 5


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
    spacing <| 9 * 8


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


horisontalDivider : Element msg
horisontalDivider =
    el [ Border.widthEach { top = 0, left = 0, right = 0, bottom = 1 }, Border.color <| Color.whiteTransparent 0.1, width fill ] none


verticalDivider : Element msg
verticalDivider =
    el [ Border.widthEach { top = 0, left = 1, right = 0, bottom = 0 }, Border.color <| Color.whiteTransparent 0.1, height fill ] none


divider : Window -> Element msg
divider window =
    case (classifyDevice window).class of
        Phone ->
            horisontalDivider

        _ ->
            verticalDivider


roundedCorners : Attribute msg
roundedCorners =
    Border.rounded 1
