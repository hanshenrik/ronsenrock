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
    , h4
    , h5
    , headingFont
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
    , xsSpacing
    , xxlPadding
    , xxlSpacing
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


headingFont : Attribute msg
headingFont =
    Font.family
        [ Font.external
            { name = "Cabin Sketch"
            , url = "https://fonts.googleapis.com/css?family=Cabin+Sketch&display=swap"
            }
        , Font.sansSerif
        ]



-- Barriecito, Barrio, Cabin Sketch


heading : Int -> List (Attribute msg) -> Element msg -> Element msg
heading size attributes =
    el
        (Region.heading size
            :: headingFont
            :: attributes
        )


h1 : List (Attribute msg) -> Element msg -> Element msg
h1 attributes =
    heading 1 (Font.size 64 :: attributes)


h2 : List (Attribute msg) -> Element msg -> Element msg
h2 attributes =
    heading 2 (Font.size 48 :: attributes)


h3 : List (Attribute msg) -> Element msg -> Element msg
h3 attributes =
    heading 3 (Font.size 32 :: attributes)


h4 : List (Attribute msg) -> Element msg -> Element msg
h4 attributes =
    heading 3 (Font.size 24 :: attributes)


h5 : List (Attribute msg) -> Element msg -> Element msg
h5 attributes =
    heading 3 (Font.size 18 :: attributes)


class : String -> Attribute msg
class name =
    htmlAttribute <| Html.Attributes.class name


dimmed : Attribute msg
dimmed =
    htmlAttribute <| Html.Attributes.style "opacity" "0.5"


spacingUnit : Int
spacingUnit =
    9


sPadding : Attribute msg
sPadding =
    padding spacingUnit


mPadding : Attribute msg
mPadding =
    padding <| spacingUnit * 2


lPadding : Attribute msg
lPadding =
    padding <| spacingUnit * 4


xlPadding : Attribute msg
xlPadding =
    padding <| spacingUnit * 6


xxlPadding : Attribute msg
xxlPadding =
    padding <| spacingUnit * 8


responsivePadding : Window -> Attribute msg
responsivePadding { width } =
    padding <| clamp (spacingUnit * 2) (spacingUnit * 8) (spacingUnit * width // 320)


xsSpacing : Attribute msg
xsSpacing =
    spacing 5


sSpacing : Attribute msg
sSpacing =
    spacing spacingUnit


mSpacing : Attribute msg
mSpacing =
    spacing <| spacingUnit * 2


lSpacing : Attribute msg
lSpacing =
    spacing <| spacingUnit * 4


xxlSpacing : Attribute msg
xxlSpacing =
    spacing <| spacingUnit * 8


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
