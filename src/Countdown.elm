module Countdown exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Transition
import Type.Window exposing (Window)
import UI


view : Window -> Int -> Element msg
view window time =
    let
        -- 1593684000000 is 2020-07-02 12:00:00+02:00
        countdownTimestamp =
            1593684000000

        timeDiff =
            countdownTimestamp - time

        daysLeft =
            floor (toFloat timeDiff / toFloat (1000 * 60 * 60 * 24))

        hoursLeft =
            floor (toFloat (remainderBy (1000 * 60 * 60 * 24) timeDiff) / toFloat (1000 * 60 * 60))

        minutesLeft =
            floor (toFloat (remainderBy (1000 * 60 * 60) timeDiff) / toFloat (1000 * 60))

        secondsLeft =
            floor (toFloat (remainderBy (1000 * 60) timeDiff) / toFloat 1000)

        barColumn unitsLeft color =
            el
                [ alignBottom
                , Transition.transition [ "height" ]
                , Font.color Color.black
                , Font.bold
                , UI.xsSpacing
                , UI.sPadding
                , UI.sRoundedTopCorners
                , case (classifyDevice window).class of
                    Phone ->
                        width (px 60)

                    _ ->
                        width (px 120)
                , height <| px (2 * min 60 unitsLeft + 64)
                , Background.color color
                ]
            <|
                UI.h2 [ alignBottom, centerX ] <|
                    text <|
                        String.fromInt unitsLeft

        ( minutesLabel, secondsLabel ) =
            case (classifyDevice window).class of
                Phone ->
                    ( "min", "sek" )

                _ ->
                    ( "minutter", "sekunder" )
    in
    if timeDiff < 0 then
        none

    else
        row [ UI.fillWidth, spaceEvenly, UI.sSpacing, height <| px (2 * 60 + 64) ]
            [ column [ alignBottom, UI.sSpacing ] [ barColumn daysLeft Color.yellow, el [ centerX ] <| text "dager" ]
            , column [ alignBottom, UI.sSpacing ] [ barColumn hoursLeft Color.orange, el [ centerX ] <| text "timer" ]
            , column [ alignBottom, UI.sSpacing ] [ barColumn minutesLeft Color.pink, el [ centerX ] <| text minutesLabel ]
            , column [ alignBottom, UI.sSpacing ] [ barColumn secondsLeft Color.darkPink, el [ centerX ] <| text secondsLabel ]
            ]
