module State exposing (init, update, subscriptions)

import Types exposing (..)
import Rest exposing (..)


init : ( Model, Cmd Msg )
init =
    update GetData (Model [] { name = "", brand = "", beerType = "", rating = 0, had = False } "" [])



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add newBeer ->
            update Reset { model | beers = newBeer :: model.beers }

        Name name ->
            ( { model | beerToAdd = setName name model.beerToAdd }, Cmd.none )

        Brand brand ->
            ( { model | beerToAdd = setBrand brand model.beerToAdd }, Cmd.none )

        Type beerType ->
            ( { model | beerToAdd = setType beerType model.beerToAdd }, Cmd.none )

        Rating rating ->
            ( { model | beerToAdd = setRating rating model.beerToAdd }, Cmd.none )

        Had had ->
            ( { model | beerToAdd = setHad had model.beerToAdd }, Cmd.none )

        Reset ->
            ( { model | beerToAdd = { name = "", brand = "", beerType = "", rating = 0, had = False }, errorMessage = "" }, Cmd.none )

        ErrorMessage error ->
            ( { model | errorMessage = error }, Cmd.none )

        Delete index ->
            ( { model | beers = removeItem index model.beers }, Cmd.none )

        QueryComplete response ->
            case response of
                Ok result ->
                    ( { model | beers = result }, Cmd.none )

                Err error ->
                    update (ErrorMessage (toString error)) model

        GetData ->
            ( model, getInitialData )


setName : String -> Beer -> Beer
setName name beer =
    { beer | name = name }


setBrand : String -> Beer -> Beer
setBrand brand beer =
    { beer | brand = brand }


setType : String -> Beer -> Beer
setType beerType beer =
    { beer | beerType = beerType }


setRating : Int -> Beer -> Beer
setRating rating beer =
    { beer | rating = rating }


setHad : Bool -> Beer -> Beer
setHad had beer =
    { beer | had = had }


removeItem : Int -> List Beer -> List Beer
removeItem index beerList =
    List.take index beerList ++ List.drop (index + 1) beerList



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
