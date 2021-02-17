module Page.FestivalMap exposing (view)

import Color
import Element exposing (..)
import Element.Font as Font
import UI


view : DeviceClass -> Element msg
view deviceClass =
    case deviceClass of
        Phone ->
            UI.imageWithAttribution [ UI.sPadding ] { src = "/images/kart-lm.jpg", description = "Festivalkart", attribution = "🎨 Lisa Løtvedt Martinsen", isBoxed = False }

        _ ->
            column [ UI.mPadding, UI.xlSpacing, centerX ]
                [ UI.h1 [ Font.color Color.yellow ] <| text "Festivalkart"
                , el
                    [ UI.lSpacing
                    , UI.lPadding
                    , centerX
                    , width
                        (fill
                            |> maximum 1000
                        )
                    ]
                  <|
                    UI.imageWithAttribution [] { src = "/images/kart-lm.jpg", description = "Festivalkart", attribution = "🎨 Lisa Løtvedt Martinsen", isBoxed = True }
                ]
