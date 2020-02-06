module UI exposing
    ( bodyFont
    , boxed
    , buttonLink
    , class
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
    , rowOrColumn
    , sPadding
    , sRoundedCorners
    , sRoundedTopCorners
    , sSpacing
    , verticalDivider
    , xlPadding
    , xlRoundedCorners
    , xlSpacing
    , xsSpacing
    , xxlPadding
    )

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html.Attributes
import Type.Window exposing (Window)


bodyFont : Attribute msg
bodyFont =
    Font.family
        [ Font.external
            { name = "Barlow"
            , url = "https://fonts.googleapis.com/css?family=Barlow:300,400,600,700&display=swap"
            }
        , Font.sansSerif
        ]



-- Barriecito, Barrio, Cabin Sketch


heading : Int -> List (Attribute msg) -> Element msg -> Element msg
heading size attributes =
    el
        (Region.heading size
            :: Font.family
                [ Font.external
                    { name = "Cabin Sketch"
                    , url = "https://fonts.googleapis.com/css?family=Cabin+Sketch&display=swap"
                    }
                , Font.sansSerif
                ]
            :: attributes
        )


h1 : List (Attribute msg) -> Element msg -> Element msg
h1 attributes =
    heading 1 (Font.size 64 :: attributes)


h2 : List (Attribute msg) -> Element msg -> Element msg
h2 attributes =
    heading 2 (Font.size 32 :: attributes)


h3 : List (Attribute msg) -> Element msg -> Element msg
h3 attributes =
    heading 3 (Font.size 24 :: attributes)


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
    padding <| 9 * 6


xxlPadding : Attribute msg
xxlPadding =
    padding <| 9 * 8


responsivePadding : Window -> Attribute msg
responsivePadding { width } =
    padding <| clamp (9 * 2) (9 * 8) (9 * width // 320)


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


sRoundedCorners : Attribute msg
sRoundedCorners =
    Border.rounded 4


sRoundedTopCorners : Attribute msg
sRoundedTopCorners =
    Border.roundEach { topLeft = 4, topRight = 4, bottomLeft = 0, bottomRight = 0 }


xlRoundedCorners : Attribute msg
xlRoundedCorners =
    Border.rounded 40


boxed : List (Attribute msg)
boxed =
    [ htmlAttribute <| Html.Attributes.style "background" "linear-gradient(145deg, #1c1c1c, #171717)"
    , htmlAttribute <| Html.Attributes.style "box-shadow" "15px 15px 0px #161616, -15px -15px 0px #1e1e1e"
    , sRoundedCorners
    ]


buttonLink : List (Attribute msg) -> { label : Element msg, url : String } -> Element msg
buttonLink attributes parameters =
    link (Background.color Color.yellow :: Font.color Color.black :: paddingXY (9 * 4) (9 * 2) :: xlRoundedCorners :: attributes) parameters
