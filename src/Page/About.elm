module Page.About exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import List.Extra as List
import Type.Window exposing (Window)
import UI


view : DeviceClass -> Element msg
view deviceClass =
    let
        heading =
            case deviceClass of
                Phone ->
                    UI.h3

                _ ->
                    UI.h1
    in
    column
        [ UI.lSpacing
        , UI.mPadding
        , centerX
        , width
            (fill
                |> maximum 1000
            )
        ]
        [ UI.p <| heading [ Font.color Color.yellow ] <| text "Hva er RønsenROCK?"
        , paragraph [ UI.sSpacing ]
            [ text """
                Ideen bak RønsenROCK dukket først opp på en bandøving i 2014. Alle band drømmer om et stort publikum,
                så hvorfor ikke sette Eidsvoll på kartet med tidenes rockefestival, og booke seg sjæl med i giggen? Dessuten: Hvor vanskelig kan det være å arrangere festival?
                """
            ]
        , paragraph [ UI.sSpacing ]
            [ text """
                Sommeren 2015 ble scene og utedasser bygget, og vi var i gang. Det viste seg fort at det heller ikke var umulig å finne en haug med rockere som ville komme å spille, og RønsenROCK var offisielt!
                """
            ]
        , UI.imageWithAttribution [] { src = "/images/festivalgjengen-tep.jpg", description = "Festivalgjengen", attribution = "📷 Tom Erik Paulsen", isBoxed = True }
        , paragraph [ UI.sSpacing ]
            [ text """
                Da det var duket for oppfølgeråret i 2016 måtte scenen ha en liten makeover, og er det noe dette festivallaget ikke mangler er det dugnadsånd! Venner og bekjente, frivillige og familie stilte opp og hjalp arrangørene med ny scene, salgsbu,
                hjemmesnekra ølkasser som går til banda som spiller, grillplass som brukes hyppig gjennom helga, hengekøyer, utvidet campområde, volleyballnett, og mye, mye mer! Alt for å gjøre denne helga helt spesiell.
                """
            ]
        , paragraph [ UI.sSpacing ]
            [ text """
                Festivalen er tuftet på goodwill og det overordnede målet er å legge til rette for en langhelg med ekte rockeglede, sjukt bra musikk, sosialt samvær og varmt øl. Og målet blir nådd hvert år med god margin.
                """
            ]
        , UI.imageWithAttribution [] { src = "/images/lydmann-tk.jpg", description = "Lydmann", attribution = "📷 Thomas Kvehaugen", isBoxed = True }
        , paragraph [ UI.sSpacing ]
            [ text """
                Festivalen har vokst og fortsetter å vokse. I prinsippet er dette en gratis festival, men arrangørene setter pris på økonomisk støtte fra deltakerne for å kunne opprettholde og utvikle festivalen videre.
                Det er viktig å understreke at RønsenROCK ikke hadde vært det det er i dag uten hjelp og støtte fra venner, familie og deltakere, og at dette er noe festivallaget setter ekstremt stor pris på.
                """
            ]
        , paragraph [ UI.sSpacing ]
            [ text """
                Ta turen, sjekk det ut, du vil ikke angre!
                """
            ]
        , el [] none
        ]
