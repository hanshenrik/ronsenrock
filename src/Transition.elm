module Transition exposing (fadeInWhen, transition, transitionAll)

import Element exposing (..)
import Html.Attributes


fast : Float
fast =
    0.2


easing : String
easing =
    "ease-in-out"


style : String -> String -> Attribute msg
style property value =
    htmlAttribute <| Html.Attributes.style property value


transition : List String -> Attribute msg
transition properties =
    style "transition" <|
        String.join ", " <|
            List.map (\property -> property ++ " " ++ String.fromFloat fast ++ "s " ++ easing)
                properties


transitionAll : Attribute msg
transitionAll =
    transition [ "all" ]


fadeInWhen : Bool -> List (Attribute msg)
fadeInWhen condition =
    [ transition [ "opacity" ]
    , style "opacity" <|
        if condition then
            "1"

        else
            "0"
    ]
