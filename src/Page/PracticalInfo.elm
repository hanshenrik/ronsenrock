module Page.PracticalInfo exposing (view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import List.Extra as List
import Type.Window exposing (Window)
import UI


view : DeviceClass -> Element msg
view deviceClass =
    let
        ( h1, h2, h3 ) =
            case deviceClass of
                Phone ->
                    ( UI.h3, UI.h4, UI.h4 )

                _ ->
                    ( UI.h1, UI.h2, UI.h3 )
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
        [ h1 [ Font.color Color.yellow ] <| text "Hvor er det?"
        , el (UI.xlPadding :: UI.boxed) <| h3 [] <| column [ UI.mSpacing, Font.center ] [ text "Rønsenvegen 121", text "2080 Eidsvoll" ]
        , h3 [] <| text "Med bil"
        , paragraph [ UI.sSpacing ]
            [ text "Kommer du nordfra, er det greieste å kjøre av E6 ved Minnesund. Deretter følger du skilting til Vormsund (177). Etter ca. 5 kilometer sørover vil du se skilting til festivalområdet." ]
        , paragraph [ UI.sSpacing ]
            [ text "Kommer du sørfra, og du ikke er lokalkjent, er det greieste å late som om du kommer nordfra og følge den samme veibeskrivelsen." ]
        , h3 [] <| text "Med tog"
        , paragraph [ UI.sSpacing ]
            [ text "I og med at Eidsvoll er Vy sin navle, er det mange togavganger som stopper på Eidsvoll stasjon. Sjekk vy.no for detaljer." ]
        , paragraph [ UI.sSpacing ]
            [ text "Når du har gått av på Eidsvoll stasjon (ikke Eidsvoll Verk!), er det fremdeles rundt 7 kilometer til du er framme. Kollektivtilbudet herfra er heller skralt, så her er alternativene taxi, venner med bil, sykkel eller å ta beina fatt." ]
        , paragraph [ UI.sSpacing ]
            [ text "Det er mange som kjører forbi stasjonen på vei til festivalen, så det er sikkert mulig å organisere samkjøring på Facebook-eventet." ]

        --
        , h1 [ Font.color Color.yellow ] <| text "Hvor mye koster det?"
        , paragraph [ UI.sSpacing ]
            [ text """
                RønsenROCK finansieres etter spleiselagprinsippet. Derfor oppfordrer vi alle til å bidra med 250,- per dag eller 350,- for festivalpass ved inngangen.
                I bytte mot bidraget får du et stilig festivalarmbånd. Men la det være klart: RønsenROCK gjør ikke forskjell på fattig og rik. Her er alle velkomne.
                Er du pengelens, kan du heller bidra med rock, roll og generelt god festivalstemning.
                """
            ]
        , paragraph [ UI.sSpacing ]
            [ text "250,- per dag eller 350,- for hele festivalen. Kontant, kort eller Vipps." ]
        , paragraph [ UI.sSpacing ]
            [ text "Du kan også bidra i etterkant av festivalen på kontonummer 8475 10 75285." ]

        --
        , h1 [ Font.color Color.yellow ] <| text "Andre spørsmål"
        , h3 [] <| text "Kan jeg overnatte?"
        , paragraph [ UI.sSpacing ]
            [ text """
                Jepp! Ta med telt, campingvogn, bilen eller hva du nå enn har å sove i. Det er god plass å campe på. De beste plassene blir tidlig okkupert,
                så dersom du trenger vatret underlag, bør du komme tidlig på torsdag.
                """
            ]

        --
        , h3 [] <| text "Hvilke fasiliteter finnes?"
        , paragraph [ UI.sSpacing ]
            [ text "På festivalområdet finnes utedasser, vann, grill, førstehjelpsutstyr, godt med beinplass og lun sønnavind. Mat, drikke, varme klær og myggmiddel må du ta med sjøl." ]

        --
        , UI.p <| h3 [] <| text "Hvordan får jeg tak i t-skjorte?"
        , paragraph [ UI.sSpacing ]
            [ text "Vi har igjen trykket opp t-skjorter med ny, fet logo. Disse selges for kroner 250,- ved inngangen." ]

        --
        , h3 [] <| text "Er det noe som ikke er lov?"
        , UI.ul
            [ UI.p <| text "Det er dessverre ikke lov til å ha med hund på festivalen."
            , UI.p <| text "Det er ikke tillatt å fyre bål i campen. Men ingen grunn til å fortvile – det er grillmuligheter på festivalområdet!"
            , UI.p <| text "Det er ikke lov å ha med eget anlegg i campen."
            ]

        --
        , h3 [] <| text "Blir det fett?"
        , paragraph [ UI.sSpacing ]
            [ text "Ja." ]
        ]
