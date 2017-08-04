module Rest exposing (getInitialData, sendData)

import Types exposing (..)
import Http
import Json.Decode as Decode
import Json.Encode as Encode


getInitialData : Cmd Msg
getInitialData =
    Http.get "/data/get" decodeInitialData
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


beerToSend : Beer -> Encode.Value
beerToSend newBeer =
    Encode.object
        [ ( "name", Encode.string newBeer.name )
        , ( "brand", Encode.string newBeer.brand )
        , ( "type", Encode.string newBeer.beerType )
        , ( "rating", Encode.int newBeer.rating )
        , ( "had", Encode.bool newBeer.had )
        ]


sendData : Beer -> Cmd Msg
sendData newBeer =
    Http.post "/data/send" (Http.jsonBody (beerToSend newBeer)) (Decode.succeed "1")
        |> Http.send AddComplete
