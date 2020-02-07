module Page.FestivalMap exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import List.Extra as List
import Type.Window exposing (Window)
import UI


view : Window -> Element msg
view window =
    el
        [ UI.lSpacing
        , UI.lPadding
        , centerX
        , width
            (fill
                |> maximum 1000
            )
        ]
    <|
        UI.imageWithAttribution [] { src = "/images/kart-lm.jpg", description = "Festivalkart", attribution = "Lisa Løtvedt Martinsen" }
