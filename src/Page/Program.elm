module Page.Program exposing (view)

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
        ( pageHeading, dayHeading ) =
            case deviceClass of
                Phone ->
                    ( UI.h2, UI.h3 )

                _ ->
                    ( UI.h1, UI.h2 )
    in
    column
        [ UI.lSpacing
        , UI.lPadding
        , centerX
        , centerY
        ]
        [ pageHeading [] <| text "Program"
        , column [ UI.mSpacing ]
            [ dayHeading [ Font.color Color.yellow ] <| text "Torsdag 2. juli"
            , row [ UI.lSpacing ]
                [ el [ alignTop, UI.monoFont ] <| text "🕛 12:00"
                , UI.p <| text "Festivalområdet åpner!"

                -- , el [ alignRight, UI.class "show-more-button", pointer, mouseOver [ scale 1.2 ] ] <| text "👇"
                ]

            -- , column [ UI.class "event-info" ]
            --     [ text "Her er det om å gjøre å være på plass og få seg den beste spotten! Vi har fire ulike camper som sprer seg over festivalområdet, og alle campsa kommer med “alltid hyggelig nabogaranti”."
            --     , text "Det er også en on-going konkurranse om den beste campen. De som vinner får æren av å eie vårt fantastiske vandretrofè og skryte rettighetene et helt år!"
            --     , text "Denne dagen handler om å finne festivalånden og bare kose seg med musikk, varmt øl, teltoppsetting og leik. Det utspiller seg alltid en heftig volleyballturnering utover dagen, og Rockbaya er aldri mer levende enn den første natta! I tillegg er DjDaMIK med på å sette stemningen over hele festivalplassen, med groovy toner fra platesamlinga si."
            --     ]
            ]
        , column [ UI.mSpacing ]
            [ dayHeading [ Font.color Color.yellow ] <| text "Fredag 3. juli"
            , row [ UI.lSpacing ]
                [ el [ alignTop, UI.monoFont ] <| text "🕔 17:00"
                , UI.p <| text "Tautrekking"

                -- , el [ alignRight, UI.class "show-more-button", pointer, mouseOver [ scale 1.2 ] ] <| text "👇"
                ]

            -- [ Html.img [ UI.src "/images/tautrekking3-sbf.jpg" ] []
            -- , el [] <| text "Tautrekking skrev seg inn i olympisk historie på 1900-tallet, og selv om det ikke er en gren i OL i dag har RønsenROCK tatt på seg jobben med å føre konkurransen videre! Her vanker det heftig premie til vinnerlaget."
            -- ]
            , row [ UI.lSpacing ]
                [ el [ alignTop, UI.monoFont ] <| text "🕖 19:00"
                , UI.p <| text "Konsertrekke #1"

                -- , el [ alignRight, UI.class "show-more-button", pointer, mouseOver [ scale 1.2 ] ] <| text "👇"
                ]

            --     [ el [] <| text "Klokka sju smeller det når RønsenROCKs uoffisielle husband åpner ballet"
            --     , Html.table []
            --         [ Html.tbody []
            --             [ Html.tr []
            --                 [ Html.td [] [ text "19:00" ]
            --                 , Html.td [] [ text "Inglorious Retards" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "20:00" ]
            --                 , Html.td [] [ text "AARB" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "21:00" ]
            --                 , Html.td [] [ text "Astralplane" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "22:00" ]
            --                 , Html.td [] [ text "Drukkenbolt" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "23:00" ]
            --                 , Html.td [] [ text "Dance Commander" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "00:00" ]
            --                 , Html.td [] [ text "Dømt" ]
            --                 ]
            --             ]
            --         ]
            --     ]
            ]
        , column [ UI.mSpacing ]
            [ dayHeading [ Font.color Color.yellow ] <| text "Lørdag 4. juli"
            , row [ UI.lSpacing ]
                [ el [ alignTop, UI.monoFont ] <| text "🕙 10:00"
                , UI.p <| text "Ryddeyoga"

                -- , el [ alignRight, UI.class "show-more-button", pointer, mouseOver [ scale 1.2 ] ] <| text "👇"
                ]

            -- , Html.div [ UI.class "event-info" ] [ el [] <| text "Når man bor sammen på slikt et stort område er det viktig å hjelpe hverandre med å holde det fint og hyggelig rundt seg. Vi inviterer derfor til yoga-time for å løsne litt på ledda og friske opp sjela, selvfølgelig med en kopp kaffe attot! Så tar vi oss en rydderunde og gjør oss klare til verdens koseligste dagssett" ]
            , row [ UI.lSpacing ]
                [ el [ alignTop, UI.monoFont ] <| text "🕛 12:00"
                , UI.p <| text "Konsertrekke #2"

                -- , el [ alignRight, UI.class "show-more-button", pointer, mouseOver [ scale 1.2 ] ] <| text "👇"
                ]

            --     [ Html.table []
            --         [ Html.tbody []
            --             [ Html.tr []
            --                 [ Html.td [] [ text "12:00" ]
            --                 , Html.td [] [ text "Helt Greit Band" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "12:30" ]
            --                 , Html.td [] [ text "Helmer" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "13:00" ]
            --                 , Html.td [] [ text "Impaired" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "13:30" ]
            --                 , Html.td [] [ text "The Loop Brothers" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "14:00" ]
            --                 , Html.td [] [ text "Andreas Fagertun" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "14:30" ]
            --                 , Html.td [] [ text "Janos" ]
            --                 ]
            --             ]
            --         ]
            --     ]
            , row [ UI.lSpacing ]
                [ el [ alignTop, UI.monoFont ] <| text "🕔 17:00"
                , UI.p <| text "Båreløp"

                -- , el [ alignRight, UI.class "show-more-button", pointer, mouseOver [ scale 1.2 ] ] <| text "👇"
                ]

            -- , Html.div [ UI.class "event-info" ]
            --     [ Html.img [ UI.src "/images/baare2-sbf.jpg" ] []
            --     , el [] <| text "Klokka fem vanker festivalens kuleste konkurranse, det legendariske Båreløpet! Etter vi har kåret vinneren av løpet og vinnerne av årets “BesteCamp” tar vi oss et lite pust i bakken før det nok en gang smeller fra scenen!"
            --     , Html.img [ UI.src "/images/beste-camp-mm.jpg" ] []
            --     ]
            , row [ UI.lSpacing ]
                [ el [ alignTop, UI.monoFont ] <| text "🕖 19:00"
                , UI.p <| text "Konsertrekke #3"

                -- , el [ alignRight, UI.class "show-more-button", pointer, mouseOver [ scale 1.2 ] ] <| text "👇"
                ]

            --     [ Html.table []
            --         [ Html.tbody []
            --             [ Html.tr []
            --                 [ Html.td [] [ text "19:00" ]
            --                 , Html.td [] [ text "Levitation B Band" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "20:00" ]
            --                 , Html.td [] [ text "Blacklands" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "21:00" ]
            --                 , Html.td [] [ text "Bolt" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "22:00" ]
            --                 , Html.td [] [ text "!Pysh" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "23:00" ]
            --                 , Html.td [] [ text "Thundering Voices" ]
            --                 ]
            --             , Html.tr []
            --                 [ Html.td [] [ text "00:00" ]
            --                 , Html.td [] [ text "Sorgen" ]
            --                 ]
            --             ]
            --         ]
            --     ]
            ]
        ]
