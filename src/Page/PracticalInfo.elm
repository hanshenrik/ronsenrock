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

        dividerImageSize =
            case deviceClass of
                Phone ->
                    300

                BigDesktop ->
                    700

                _ ->
                    600
    in
    column
        [ UI.xlSpacing
        , UI.mPadding
        , centerX
        , width
            (fill
                |> maximum 1000
            )
        ]
        [ column [ UI.lSpacing ]
            [ h1 [ Font.color Color.yellow ] <| text "🗺 Hvor er det?"
            , el (UI.xlPadding :: centerX :: UI.boxed) <| h3 [] <| column [ UI.mSpacing, Font.center ] [ text "Rønsenvegen 121", text "2080 Eidsvoll" ]
            , h3 [] <| text "🚗 Med bil"
            , paragraph [ UI.sSpacing ]
                [ text "Kommer du nordfra, er det greieste å kjøre av E6 ved Minnesund. Deretter følger du skilting til Vormsund (177). Etter ca. 5 kilometer sørover vil du se skilting til festivalområdet." ]
            , paragraph [ UI.sSpacing ]
                [ text "Kommer du sørfra, og du ikke er lokalkjent, er det greieste å late som om du kommer nordfra og følge den samme veibeskrivelsen." ]
            , h3 [] <| text "🚂 Med tog"
            , paragraph [ UI.sSpacing ]
                [ text "I og med at Eidsvoll er Vy sin navle, er det mange togavganger som stopper på Eidsvoll stasjon. Sjekk ", newTabLink [ UI.class "hoverable" ] { label = text "vy.no", url = "https://vy.no" }, text " for detaljer." ]
            , paragraph [ UI.sSpacing ]
                [ text "Når du har gått av på Eidsvoll stasjon (ikke Eidsvoll Verk!), er det fremdeles rundt 7 kilometer til du er framme. Kollektivtilbudet herfra er heller skralt, så her er alternativene taxi, venner med bil, sykkel eller å ta beina fatt." ]
            , paragraph [ UI.sSpacing ]
                [ text "Det er mange som kjører forbi stasjonen på vei til festivalen, så det er sikkert mulig å organisere samkjøring på ", newTabLink [ UI.class "hoverable" ] { label = text "Facebook-eventet.", url = "https://www.facebook.com/events/1276322845893719/" } ]
            ]
        , column [ UI.lSpacing ]
            [ h1 [ Font.color Color.yellow ] <| text "💰 Hvor mye koster det?"
            , paragraph [ UI.sSpacing ]
                [ text """
                RønsenROCK finansieres etter spleiselagprinsippet. Derfor oppfordrer vi alle til å bidra litt, slik at vi har muligheten til å fortsette å arrangere RønsenROCK også i årene fremover.
                I bytte mot bidraget får du et stilig festivalarmbånd. Men la det være klart: RønsenROCK gjør ikke forskjell på fattig og rik. Her er alle velkomne.
                Er du pengelens, kan du heller bidra med rock, roll og generelt god festivalstemning.
                """
                ]
            , paragraph [ UI.sSpacing ]
                [ el [ Font.bold ] <| text "250,-", text " per dag eller ", el [ Font.bold ] <| text "350,-", text " for hele festivalen. 📱 Vipps, 💳 kort eller 💵 Kontant." ]
            , paragraph [ UI.sSpacing ]
                [ text "Du kan også bidra i etterkant av festivalen på kontonummer 8475 10 75285." ]
            ]
        , column [ UI.lSpacing ]
            [ h1 [ Font.color Color.yellow ] <| text "❓ Andre spørsmål"
            , h3 [] <| text "⛺️ Kan jeg overnatte?"
            , paragraph [ UI.sSpacing ]
                [ text """
                Jepp! Ta med telt, campingvogn, bilen eller hva du nå enn har å sove i. Det er god plass å campe på. De beste plassene blir tidlig okkupert,
                så dersom du trenger vatret underlag, bør du komme tidlig på torsdag.
                """
                ]
            , h3 [] <| text "👙 Hvor kan jeg bade?"
            , paragraph [ UI.sSpacing ]
                [ text "Ja! En kort rusletur fra festivalområdet kan vi by på finfine badefasiliteter!" ]
            , UI.imageWithAttribution [] { src = "/images/strand-mm.jpg", description = "Bading", attribution = "Maria Martinsen" }

            --
            , h3 [] <| text "🚽 Hvilke fasiliteter finnes?"
            , paragraph [ UI.sSpacing ]
                [ text "På festivalområdet finnes utedasser, vann, grill, førstehjelpsutstyr, godt med beinplass og lun sønnavind. Mat, drikke, varme klær og myggmiddel må du ta med sjøl." ]

            --
            , UI.p <| h3 [] <| text "👕 Hvordan får jeg tak i t-skjorte?"
            , paragraph [ UI.sSpacing ]
                [ text "Vi har igjen trykket opp t-skjorter med ny, fet logo. Disse selges for kroner 250,- ved inngangen." ]

            --
            , h3 [] <| text "🚫 Er det noe som ikke er lov?"
            , UI.ul
                [ UI.p <| text "Det er dessverre ikke lov til å ha med hund på festivalen."
                , UI.p <| text "Det er ikke tillatt å fyre bål i campen. Men ingen grunn til å fortvile – det er grillmuligheter på festivalområdet!"
                , UI.p <| text "Det er ikke lov å ha med eget anlegg i campen."
                ]

            --
            , h3 [] <| text "✌️ Blir det fett?"
            , paragraph [ UI.sSpacing ]
                [ text "Ja." ]
            , el [] none
            ]
        ]
