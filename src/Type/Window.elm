module Type.Window exposing (Window, decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Decode


type alias Window =
    { width : Int
    , height : Int
    }


decoder : Decoder Window
decoder =
    Decode.succeed Window
        |> Decode.required "width" Decode.int
        |> Decode.required "height" Decode.int
