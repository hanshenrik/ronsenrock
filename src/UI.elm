module UI exposing
    ( bodyFont
    , boxed
    , buttonLink
    , class
    , divider
    , fillWidth
    , h1
    , h2
    , h3
    , h4
    , h5
    , headingFont
    , horisontalDivider
    , imageWithAttribution
    , lPadding
    , lSpacing
    , mPadding
    , mSpacing
    , monoFont
    , p
    , responsivePadding
    , rowOrColumn
    , sPadding
    , sRoundedCorners
    , sRoundedTopCorners
    , sSpacing
    , ul
    , verticalDivider
    , xlPadding
    , xlRoundedCorners
    , xlSpacing
    , xsPadding
    , xsSpacing
    , xxlPadding
    , xxlSpacing
    , xxsPadding
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


monoFont : Attribute msg
monoFont =
    Font.family
        [ Font.external
            { name = "Anonymous Pro"
            , url = "https://fonts.googleapis.com/css?family=Anonymous+Pro:700&display=swap"
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


spacingUnit : Int
spacingUnit =
    9


xxsPadding : Attribute msg
xxsPadding =
    padding 2


xsPadding : Attribute msg
xsPadding =
    padding 5


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


xlSpacing : Attribute msg
xlSpacing =
    spacing <| spacingUnit * 6


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
    el [ Border.widthEach { top = 0, left = 0, right = 0, bottom = 1 }, Border.color <| Color.withTransparency Color.white 0.1, width fill ] none


verticalDivider : Element msg
verticalDivider =
    el [ Border.widthEach { top = 0, left = 1, right = 0, bottom = 0 }, Border.color <| Color.withTransparency Color.white 0.1, height fill ] none


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
    , htmlAttribute <| Html.Attributes.style "box-shadow" "15px 15px 0px #0a0a0a, -15px -15px 0px #2a2a2a"
    , sRoundedCorners
    ]


buttonLink : List (Attribute msg) -> { label : Element msg, url : String } -> Element msg
buttonLink attributes parameters =
    newTabLink (Background.color Color.yellow :: Font.color Color.black :: paddingXY (9 * 4) (9 * 2) :: xlRoundedCorners :: attributes) parameters


imageWithAttribution : List (Attribute msg) -> { attribution : String, src : String, description : String, isBoxed : Bool } -> Element msg
imageWithAttribution attributes { attribution, src, description, isBoxed } =
    column attributes
        [ image
            ([ fillWidth
             , sRoundedCorners
             , clip
             ]
                ++ (if isBoxed then
                        boxed

                    else
                        []
                   )
            )
            { src = src, description = description }
        , el
            [ alignBottom
            , alignLeft
            , Border.roundEach { topLeft = 0, topRight = 4, bottomRight = 0, bottomLeft = 0 }
            , paddingXY
                (if isBoxed then
                    0

                 else
                    spacingUnit
                )
                (3 * spacingUnit)
            , Font.size 14
            ]
          <|
            text <|
                attribution
        ]


ul : List (Element msg) -> Element msg
ul elements =
    column
        [ mSpacing
        , paddingXY (4 * spacingUnit) 0
        ]
        (List.map (\element -> row [ sSpacing ] [ el [ alignTop ] <| text "•", element ]) elements)


p : Element msg -> Element msg
p element =
    paragraph
        [ htmlAttribute <| Html.Attributes.style "overflow-wrap" "break-word"
        , htmlAttribute <| Html.Attributes.style "line-height" "1.4"
        ]
        [ element ]
