module Page.History exposing (view)

import Color
import Element exposing (..)
import Element.Font as Font
import Html.Attributes
import List.Extra as List
import Type.Window exposing (Window)
import UI


artists : { y2019 : List String, y2018 : List String, y2017 : List String, y2016 : List String, y2015 : List String }
artists =
    { y2019 = [ "Inglorious Retards", "AARB", "Astralplane", "Drukkenbolt", "Dance Commander", "Dømt", "Helt Greit Band", "Helmer", "Impaired", "The Loop Brothers", "Andreas Fagertun", "Janos", "Levitation B Band", "Blacklands", "Bolt", "!Pysh", "Thundering Voices", "Sorgen", "Dj Damik" ]
    , y2018 = [ "Detroit Sound", "Rainbowhead", "Forgetaboutit", "Bucktooth Dan", "Marius Abrahamsen", "Sorgen", "Norrøna Band", "Sigurd og Røkla", "Konger og Keisere", "Honeyroll", "Inglorious Retards", "Dårlig Hjort", "Helt Greit Band", "Thundering Voices", "Dance Commander", "Nasty Dogs", "Glutton", "Victor & Dacota" ]
    , y2017 = [ "Skamfuret Værbitt", "Porto", "Glass Club", "Mark Steiner & His Problems", "Somewhere Beyond", "The Dead Beat", "Punch", "Thundering Voices", "Helt Greit Band", "HARB", "Forbeaboutit", "Inglorious Retards", "Axsang" ]
    , y2016 = [ "Jow Blob", "Honeyroll", "Pantalones El Chico Grande", "NARB", "Vossafårs", "Inglorious Retards", "Festivalsjefen og Jeg", "State of Confusion", "Punch", "Helt Greit Band", "Lazy Petite", "Requinox" ]
    , y2015 = [ "Jow Blob", "Ingloriuos Retards", "Lazy Petite", "Kokt Torsk/Stekt Torsk", "Helt Greit Band", "Pantalones El Chico Grande", "Leafy" ]
    }


bannerImageAttributes : Window -> List (Attribute msg)
bannerImageAttributes window =
    [ UI.lSpacing
    , UI.responsivePadding window
    , UI.fillWidth
    ]


artistList : List String -> Element msg
artistList a =
    a
        |> List.sort
        |> List.intersperse "•"
        |> List.map text
        |> wrappedRow [ UI.fillWidth, UI.mSpacing ]


view : Window -> Element msg
view window =
    let
        deviceClass =
            (classifyDevice window).class

        ( imageHeading, move2018Heading, ( height2018Logo, width2018Logo ) ) =
            case deviceClass of
                BigDesktop ->
                    ( UI.h1, -250, ( px 600, px <| round <| 600 * 0.7587719298 ) )

                Desktop ->
                    ( UI.h1, -175, ( px 600, px <| round <| 600 * 0.7587719298 ) )

                _ ->
                    ( UI.h3, -75, ( shrink, fill ) )

        ( pageHeading, subHeading, imagePadding ) =
            case deviceClass of
                Phone ->
                    ( UI.h2, UI.h3, UI.sPadding )

                _ ->
                    ( UI.h1, UI.h2, UI.lPadding )
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
        [ UI.p <| pageHeading [] <| text "Historie"
        , UI.p <| subHeading [ Font.color Color.yellow ] <| text "Tidligere år"
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ image
                    (UI.fillWidth
                        :: centerX
                        :: imagePadding
                        :: UI.class "shake"
                        :: UI.boxed
                    )
                    { src = "/images/logo-2019-mm-transparent.png", description = "Logo 2019" }
                , artistList artists.y2019
                , image [ UI.fillWidth ] { src = "/images/tak-2019-tk.jpg", description = "Fellesbilde 2019" }
                ]
        , el [ moveUp 9, UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column
                    (UI.fillWidth
                        :: imagePadding
                        :: UI.class "shake"
                        :: UI.boxed
                    )
                    [ imageHeading [ centerX, Font.color Color.yellow, htmlAttribute <| Html.Attributes.style "transform" <| "rotate(-30deg) translateX(" ++ String.fromInt move2018Heading ++ "px)" ] <| text "2018"
                    , image
                        [ centerX
                        , UI.fillWidth
                        , height height2018Logo
                        , width width2018Logo
                        ]
                        { src = "/images/logo-2018-mm-transparent.png", description = "Logo 2018" }
                    ]
                , artistList artists.y2018
                , image [ UI.fillWidth ] { src = "/images/tak-2018-tk.jpg", description = "Fellesbilde 2018" }
                ]
        , el [ moveUp 9, UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image
                        (UI.fillWidth
                            :: imagePadding
                            :: UI.class "shake"
                            :: UI.boxed
                        )
                        { src = "/images/logo-2017-mm.png", description = "Logo 2017" }
                    , artistList artists.y2017
                    , image [ UI.fillWidth ] { src = "/images/tak-2017-tk.jpg", description = "Fellesbilde 2017" }
                    ]
                ]
        , el [ moveUp 9, UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column [ UI.fillWidth, UI.lSpacing ]
                    [ image
                        (UI.fillWidth
                            :: imagePadding
                            :: UI.class "shake"
                            :: UI.boxed
                        )
                        { src = "/images/logo-2016-mm.png", description = "Logo 2016" }
                    , artistList artists.y2016
                    , image [ UI.fillWidth ] { src = "/images/tak-2016-tk.jpg", description = "Fellesbilde 2016" }
                    ]
                ]
        , el [ moveUp 9, UI.fillWidth, paddingXY (9 * 12) 0, centerX ] <| UI.horisontalDivider
        , el [ UI.sPadding ] <|
            column (bannerImageAttributes window)
                [ column
                    (UI.fillWidth
                        :: imagePadding
                        :: UI.class "shake"
                        :: UI.boxed
                    )
                    [ imageHeading [ UI.mPadding, centerX, Font.color Color.yellow ] <| text "2015"
                    , image [ UI.fillWidth, centerX ] { src = "/images/logo-2015.jpg", description = "Logo 2015" }
                    ]
                , artistList artists.y2015
                , image [ UI.fillWidth ] { src = "/images/tak-2015-1-tk.jpg", description = "Fellesbilde 2015" }
                ]
        , UI.p <| subHeading [ Font.color Color.yellow ] <| text "Hva er RønsenROCK?"
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
