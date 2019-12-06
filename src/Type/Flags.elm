module Type.Flags exposing (Flags, decode)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Decode
import Time exposing (Posix, Zone)
import Type.Window as Window exposing (Window)


type alias Flags =
    { window : Window
    , time : Posix
    }


posix : Decoder Posix
posix =
    Decode.map Time.millisToPosix Decode.int


zone : Decoder Zone
zone =
    Decode.map (\offset -> Time.customZone offset []) Decode.int


type alias MaybeFlags =
    { window : Maybe Window
    , time : Maybe Posix
    }


decoder : Decoder MaybeFlags
decoder =
    Decode.succeed MaybeFlags
        |> Decode.required "window" (Decode.maybe Window.decoder)
        |> Decode.required "time" (Decode.maybe posix)


decode : Decode.Value -> Flags
decode json =
    let
        default =
            { window = Window 1600 1200
            , time = Time.millisToPosix 1541679590000
            }

        unpack name defaultValue maybeValue =
            case maybeValue of
                Nothing ->
                    defaultValue

                Just value ->
                    value
    in
    case Decode.decodeValue decoder json of
        Result.Ok maybeFlags ->
            { window = unpack "window" default.window maybeFlags.window
            , time = unpack "time" default.time maybeFlags.time
            }

        Result.Err e ->
            default
