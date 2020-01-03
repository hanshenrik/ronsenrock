module Countdown exposing (view)

import Element exposing (..)
import UI


view : Int -> Element msg
view time =
    let
        -- 1593684000000 to posix time is 2020-07-02 12:00:00+02:00
        countdownTimestamp =
            1593684000000

        timeDiff =
            countdownTimestamp - time

        day =
            String.fromInt (round (toFloat timeDiff / toFloat (1000 * 60 * 60 * 24)))

        hour =
            String.fromInt (round (toFloat (remainderBy (1000 * 60 * 60 * 24) timeDiff) / toFloat (1000 * 60 * 60)))

        minute =
            String.fromInt (round (toFloat (remainderBy (1000 * 60 * 60) timeDiff) / toFloat (1000 * 60)))

        second =
            String.fromInt (round (toFloat (remainderBy (1000 * 60) timeDiff) / toFloat 1000))
    in
    el [] <|
        if timeDiff > 0 then
            UI.h3 <| text ("Bare " ++ day ++ "d " ++ hour ++ "t " ++ minute ++ "m og " ++ second ++ "s igjen!")

        else
            none
