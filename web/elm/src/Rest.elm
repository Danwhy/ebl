module Rest exposing (getInitialData, sendData, removeData)

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
    Decode.map6 Beer
        (Decode.field "name" Decode.string)
        (Decode.field "brand" Decode.string)
        (Decode.field "beerType" Decode.string)
        (Decode.field "rating" Decode.int)
        (Decode.field "had" Decode.bool)
        (Decode.maybe (Decode.field "id" Decode.int))


beerToSend : Beer -> Encode.Value
beerToSend newBeer =
    Encode.object
        [ ( "name", Encode.string newBeer.name )
        , ( "brand", Encode.string newBeer.brand )
        , ( "type", Encode.string newBeer.beerType )
        , ( "rating", Encode.int newBeer.rating )
        , ( "had", Encode.bool newBeer.had )
        ]


beerToDelete : Int -> Encode.Value
beerToDelete beer_id =
    Encode.object [ ( "id", Encode.int beer_id ) ]


sendData : Beer -> Cmd Msg
sendData newBeer =
    Http.post "/data/send" (Http.jsonBody (beerToSend newBeer)) decodeInitialData
        |> Http.send AddComplete


removeData : Beer -> Cmd Msg
removeData beer =
    case beer.id of
        Just id ->
            Http.post "/data/delete" (Http.jsonBody (beerToDelete id)) decodeInitialData
                |> Http.send AddComplete

        Nothing ->
            Cmd.none
