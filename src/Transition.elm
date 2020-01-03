module Transition exposing (fadeInWhen, slowTransition, transition, transitionAll)

import Element exposing (..)
import Html.Attributes


fast : Float
fast =
    0.2


slow : Float
slow =
    0.6


easing : String
easing =
    "ease-in-out"


style : String -> String -> Attribute msg
style property value =
    htmlAttribute <| Html.Attributes.style property value


genTransition : Float -> List String -> Attribute msg
genTransition speed properties =
    style "transition" <|
        String.join ", " <|
            List.map (\property -> property ++ " " ++ String.fromFloat speed ++ "s " ++ easing)
                properties


slowTransition : List String -> Attribute msg
slowTransition properties =
    genTransition slow properties


transition : List String -> Attribute msg
transition properties =
    genTransition fast properties


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
