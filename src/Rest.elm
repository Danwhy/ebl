module Rest exposing (getInitialData)

import Types exposing (..)
import Http
import Json.Decode as Decode


getInitialData : Cmd Msg
getInitialData =
    Http.get "../data.json" decodeInitialData
        |> Http.send QueryComplete


decodeInitialData : Decode.Decoder (List Beer)
decodeInitialData =
    Decode.field "beers" (Decode.list beerDecoder)


beerDecoder : Decode.Decoder Beer
beerDecoder =
    Decode.map5 Beer
        (Decode.field "name" Decode.string)
        (Decode.field "brand" Decode.string)
        (Decode.field "beerType" Decode.string)
        (Decode.field "rating" Decode.int)
        (Decode.field "had" Decode.bool)
