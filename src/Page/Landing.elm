module Page.Landing exposing (view)

import Color
import Countdown
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import Type.Window exposing (Window)
import UI


view : { a | window : Window, time : Int } -> Element msg
view { window, time } =
    let
        deviceClass =
            (classifyDevice window).class

        ( ( logoSize, dividerImageSize ), ( responsivePadding, dateHeading ) ) =
            case deviceClass of
                Phone ->
                    ( ( 300, 300 ), ( UI.lPadding, UI.h2 ) )

                BigDesktop ->
                    ( ( 700, 1000 ), ( UI.xxlPadding, UI.h1 ) )

                _ ->
                    ( ( 600, 600 ), ( UI.xxlPadding, UI.h1 ) )
    in
    column [ UI.fillWidth, centerY, UI.xxlSpacing, paddingEach { top = 4 * 9, right = 0, bottom = 0, left = 0 } ]
        [ column [ UI.sSpacing, centerX ]
            [ -- el [ centerX ] <| dateHeading [ Font.color Color.yellow, htmlAttribute <| Html.Attributes.style "transform" "rotate(-10deg)" ] <| text "2. – 5. juli",
              image
                [ centerX
                , centerY
                , height <| px <| round <| logoSize / 1.5
                , width <| px logoSize
                , UI.class "shake"
                ]
                { src = "/images/logo-2020-mm-transparent.png", description = "Logo" }
            ]
        , column [ centerX, UI.mPadding, UI.xsSpacing ]
            [ el [ centerX ] <|
                column [ Font.center, centerX, UI.mSpacing, UI.lPadding, Background.color Color.lightYellow, Font.color Color.black, UI.sRoundedCorners ]
                    [ UI.p <| text "RønsenROCK 2021 er dessverre også avlyst på grunn av koronasituasjonen 💔"
                    ]
            , el [ centerX, Font.center, UI.lPadding ] <| UI.p <| text "Men! Vi håper vi sees på RønsenROCK 2022 om ca. …"
            ]
        , el [ centerX ] <| Countdown.view window time
        , el [ UI.fillWidth, height <| px dividerImageSize, Background.image "/images/tak-2019-tk.jpg" ] none
        , el
            (centerX
                :: (case deviceClass of
                        Phone ->
                            [ UI.sPadding ]

                        _ ->
                            []
                   )
            )
          <|
            el [ UI.mPadding ] <|
                column
                    (Font.center
                        :: UI.lSpacing
                        :: responsivePadding
                        :: UI.boxed
                    )
                    [ column [ UI.mSpacing ]
                        [ paragraph [ Font.center, UI.fillWidth ] [ UI.h3 [] <| text "Få oppdateringer på Facebook" ]
                        , paragraph [ Font.center ]
                            [ text "Ikke gå glipp av nyheter om neste års festival – lik Rønsenrock festivallag på Facebook." ]
                        ]
                    , UI.buttonLink [ UI.class "hoverable", centerX ] { label = row [ UI.mSpacing, UI.mPadding ] [ text "Til Facebook", text "▷" ], url = "https://www.facebook.com/RockogRull/" }
                    ]
        , el [] none

        -- , el
        --     (centerX
        --         :: (case deviceClass of
        --                 Phone ->
        --                     [ UI.sPadding ]
        --                 _ ->
        --                     []
        --            )
        --     )
        --   <|
        --     column
        --         (Font.center
        --             :: UI.lSpacing
        --             :: responsivePadding
        --             :: UI.boxed
        --         )
        --         [ column [ UI.mSpacing ]
        --             [ paragraph [ Font.center, UI.fillWidth ] [ UI.h3 [] <| text "Spille på RønsenROCK 2020?" ]
        --             , paragraph [ Font.center ]
        --                 [ text "Vi tar i mot henvendelser frem til mars." ]
        --             ]
        --         , UI.buttonLink [ UI.class "hoverable", centerX ] { label = row [ UI.mSpacing ] [ text "Meld interesse", text "▷" ], url = "mailto:booking@rønsenrock.no" }
        --         ]
        -- , el [ centerX, width <| px 200 ] <| UI.horisontalDivider
        -- , el [ centerX ] <|
        --     html <|
        --         Html.iframe
        --             [ Html.Attributes.src "https://open.spotify.com/embed/user/1113006308/playlist/6FfNqW0AcFkrhlUaDfqfpD?si=S36Q1tleRB6w5MYvFWtS2g"
        --             , Html.Attributes.style "border" "none"
        --             , Html.Attributes.style "height" "400px"
        --             , Html.Attributes.style "width" "600px"
        --             , Html.Attributes.style "max-width" "100%"
        --             , Html.Attributes.style "border-radius" "4px"
        --             ]
        --             []
        , el [ UI.fillWidth, height <| px dividerImageSize, Background.image "/images/chill-2018.jpg" ] none
        ]
