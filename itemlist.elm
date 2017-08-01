module Itemlist exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, onCheck)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Beer =
    { name : String
    , brand : String
    , beerType : String
    , rating : Int
    , had : Bool
    }


type alias Model =
    { beers : List Beer
    , beerToAdd : Beer
    , errorMessage : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model [] { name = "", brand = "", beerType = "", rating = 0, had = False } ""
    , Cmd.none
    )



-- UPDATE


type Msg
    = Add Beer
    | Name String
    | Brand String
    | Type String
    | Rating Int
    | Had Bool
    | Reset
    | ErrorMessage String


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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        ((List.map
            (\b -> renderBeer b)
            (model.beers)
         )
            ++ [ div [] [ text model.errorMessage ] ]
            ++ [ input [ type_ "text", placeholder "Name", value model.beerToAdd.name, onInput Name ] [] ]
            ++ [ input [ type_ "text", placeholder "Brand", value model.beerToAdd.brand, onInput Brand ] [] ]
            ++ [ input [ type_ "text", placeholder "Type", value model.beerToAdd.beerType, onInput Type ] [] ]
            ++ [ fieldset []
                    (List.map (\r -> ratingButton r) (List.range 1 5))
               ]
            ++ [ label []
                    [ input [ type_ "checkbox", onCheck Had ] []
                    , text "Had"
                    ]
               ]
            ++ [ button [ onClick (validate model.beerToAdd) ] [ text "Add" ] ]
        )


renderBeer : Beer -> Html Msg
renderBeer beer =
    div []
        [ h3 [] [ text beer.name ]
        , h4 [] [ text beer.brand ]
        , h5 [] [ text beer.beerType ]
        , span []
            [ case beer.rating of
                0 ->
                    text ""

                _ ->
                    text ((toString beer.rating) ++ "/5")
            ]
        , span []
            [ case beer.had of
                True ->
                    text "had"

                False ->
                    text "not had"
            ]
        ]


ratingButton : Int -> Html Msg
ratingButton rating =
    label []
        [ input [ type_ "radio", name "rating", onClick (Rating rating) ] []
        , text (toString rating)
        ]


validate : Beer -> Msg
validate beer =
    let
        { name, brand, beerType } =
            beer
    in
        if String.length name == 0 && String.length brand == 0 && String.length beerType == 0 then
            ErrorMessage "Please fill in at least one detail"
        else
            Add beer
