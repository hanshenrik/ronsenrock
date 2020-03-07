port module Ports exposing (toggleBodyNoScroll)

import Json.Encode as Encode


port toggleBodyNoScroll : Encode.Value -> Cmd msg
