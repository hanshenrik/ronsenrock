module Page.Program exposing (Msg(..), PanelState(..), view)

import Color
import Element exposing (..)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Transition
import UI


type PanelState
    = Open
    | Closed


type Msg
    = TogglePanel PanelState (Element Msg)


view : Element Msg -> PanelState -> DeviceClass -> Element Msg
view panelContent panelState deviceClass =
    let
        ( pageHeading, dayHeading ) =
            case deviceClass of
                Phone ->
                    ( UI.h2, UI.h3 )

                _ ->
                    ( UI.h1, UI.h2 )

        ( closeIconSize, closeIconAlign ) =
            case deviceClass of
                Phone ->
                    ( 50, alignRight )

                Tablet ->
                    ( 50, alignRight )

                _ ->
                    ( 30, alignLeft )

        panel content =
            column
                [ UI.class "program-panel"
                , width (fill |> maximum 500)
                , height fill
                , Background.color Color.darkPink
                , UI.mPadding
                , scrollbarY
                , case panelState of
                    Open ->
                        htmlAttribute <| Html.Attributes.class "open"

                    Closed ->
                        htmlAttribute <| Html.Attributes.class "closed"
                ]
                [ Input.button
                    [ closeIconAlign
                    , height <| px closeIconSize -- Safari fix
                    , Font.size closeIconSize
                    , Font.color Color.white
                    , Font.shadow { offset = ( 2, 2 ), blur = 0, color = Color.withTransparency Color.black 0.7 }
                    , UI.class "hoverable-alternative"
                    , htmlAttribute <| Html.Attributes.style "position" "sticky"
                    , htmlAttribute <| Html.Attributes.style "top" "2px"
                    , htmlAttribute <| Html.Attributes.style "z-index" "2"
                    ]
                    { label = text "⤫"
                    , onPress = Just <| TogglePanel Closed content
                    }
                , content
                ]

        entry clock time title info =
            Input.button [ pointer, Transition.transition [ "transform" ], mouseOver [ scale 1.025 ] ]
                { label =
                    row [ UI.mSpacing, UI.xxsPadding ]
                        [ el [ alignTop, UI.monoFont ] <| row [ UI.sSpacing ] [ el [ Font.size 30 ] <| text clock, text time ]
                        , text title
                        , text "👉"
                        ]
                , onPress =
                    Just <|
                        TogglePanel Open <|
                            column [ UI.mSpacing ]
                                ((UI.h3 [centerX] <|
                                    row [ UI.mSpacing, UI.xxsPadding ]
                                        [ el [ alignTop, UI.monoFont ] <| row [ UI.mSpacing ] [ text clock, text time ]
                                        , text "/"
                                        , text title
                                        ]
                                 )
                                    :: info
                                )
                }
    in
    column
        [ UI.lSpacing
        , UI.lPadding
        , centerX
        , centerY
        , inFront <| panel panelContent
        ]
        [ pageHeading [] <| text "Program"
        , column [ UI.mSpacing ]
            [ dayHeading [ Font.color Color.yellow ] <| text "Torsdag 2. juli"
            , entry "🕛"
                "12:00"
                "Åpning!"
                [ image [ centerX, width (fill |> maximum 450), height (fill |> maximum 300) ] { src = "/images/artists/djdamik.jpg", description = "Skilt" }
                , UI.p <| text "Her er det om å gjøre å være på plass og få seg den beste spotten! Vi har fire ulike camper som sprer seg over festivalområdet, og alle campsa kommer med “alltid hyggelig nabogaranti”."
                , UI.p <| text "Det er også en on-going konkurranse om den beste campen. De som vinner får æren av å eie vårt fantastiske vandretrofè og skryte rettighetene et helt år!"
                , UI.p <| text "Denne dagen handler om å finne festivalånden og bare kose seg med musikk, varmt øl, teltoppsetting og leik. Det utspiller seg alltid en heftig volleyballturnering utover dagen, og Rockbaya er aldri mer levende enn den første natta!"
                , UI.p <| text "I tillegg er DjDaMIK med på å sette stemningen over hele festivalplassen, med groovy toner fra platesamlinga si."
                ]
            ]
        , column [ UI.mSpacing ]
            [ dayHeading [ Font.color Color.yellow ] <| text "Fredag 3. juli"
            , entry "🕔"
                "17:00"
                "Tautrekking"
                [ image [ centerX, width (fill |> maximum 450), height (fill |> maximum 300) ] { src = "/images/tautrekking-1.jpg", description = "Tautrekking" }
                , UI.p <| text "Tautrekking skrev seg inn i olympisk historie på 1900-tallet, og selv om det ikke er en gren i OL i dag har RønsenROCK tatt på seg jobben med å føre konkurransen videre!"
                , UI.p <| text "Her vanker det heftig premie til vinnerlaget."
                ]
            , row [ UI.mSpacing ]
                [ el [ alignTop, UI.monoFont ] <| row [ UI.sSpacing ] [ el [ Font.size 30 ] <| text "🕖", text "19:00" ]
                , UI.p <| text "Konsertrekke #1"
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
            , entry "🕙"
                "10:00"
                "Ryddeyoga"
                [ image [ centerX, width (fill |> maximum 450), height (fill |> maximum 300) ] { src = "/images/ryddeyoga-2.jpg", description = "Ryddeyoga" }
                , UI.p <| text "Når man bor sammen på slikt et stort område er det viktig å hjelpe hverandre med å holde det fint og hyggelig rundt seg."
                , UI.p <| text "Vi inviterer derfor til yoga-time for å løsne litt på ledda og friske opp sjela, selvfølgelig med en kopp kaffe attot! Så tar vi oss en rydderunde og gjør oss klare til verdens koseligste dagssett"
                ]
            , row [ UI.mSpacing ]
                [ el [ alignTop, UI.monoFont ] <| row [ UI.sSpacing ] [ el [ Font.size 30 ] <| text "🕛", text "12:00" ]
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
            , entry "🕔"
                "17:00"
                "Båreløp"
                [ image [ centerX, width (fill |> maximum 450), height (fill |> maximum 300) ] { src = "/images/barelop-1.jpg", description = "Båreløp" }
                , UI.p <| text "Klokka fem vanker festivalens kuleste konkurranse, det legendariske Båreløpet!"
                , UI.p <| text "Etter vi har kåret vinneren av løpet og vinnerne av årets «BesteCamp» tar vi oss et lite pust i bakken før det nok en gang smeller fra scenen!"
                ]
            , row [ UI.mSpacing ]
                [ el [ alignTop, UI.monoFont ] <| row [ UI.sSpacing ] [ el [ Font.size 30 ] <| text "🕖", text "19:00" ]
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
