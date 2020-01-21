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

        barColumn unitsLeft label =
            column
                [ alignBottom
                , Transition.transition [ "height" ]
                , UI.xsSpacing
                , UI.sPadding
                , UI.roundedCorners
                , case (classifyDevice window).class of
                    Phone ->
                        width shrink

                    _ ->
                        width (px 120)
                , height <| px (2 * min 60 unitsLeft + 64)
                , Background.color Color.pink
                ]
                [ el [ alignBottom, centerX ] <| text <| String.fromInt unitsLeft
                , el [ alignBottom, centerX ] <| text label
                ]

        ( minutesLabel, secondsLabel ) =
            case (classifyDevice window).class of
                Phone ->
                    ( "min", "  s  " )

                _ ->
                    ( "minutter", "sekunder" )
    in
    if timeDiff < 0 then
        none

    else
        row [ UI.fillWidth, spaceEvenly, UI.sSpacing, Font.color Color.black, height <| px (2 * 60 + 64) ]
            [ barColumn daysLeft "dager"
            , barColumn hoursLeft "timer"
            , barColumn minutesLeft minutesLabel
            , barColumn secondsLeft secondsLabel
            ]
