module View exposing (..)

import Types exposing (..)
import State exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, onCheck)


view : Model -> Html Msg
view model =
    div []
        ((List.indexedMap
            (\i b -> renderBeer b i)
            (model.beers)
         )
            ++ [ div [] [ text model.errorMessage ]
               , input [ type_ "text", placeholder "Name", value model.beerToAdd.name, onInput Name ] []
               , input [ type_ "text", placeholder "Brand", value model.beerToAdd.brand, onInput Brand ] []
               , input [ type_ "text", placeholder "Type", value model.beerToAdd.beerType, onInput Type ] []
               , fieldset []
                    (List.map (\r -> ratingButton r) (List.range 1 5))
               , label []
                    [ input [ type_ "checkbox", onCheck Had ] []
                    , text "Had"
                    ]
               , button
                    [ onClick
                        (case validate model.beerToAdd of
                            True ->
                                Add model.beerToAdd

                            False ->
                                ErrorMessage "Please fill in all details"
                        )
                    ]
                    [ text "Add" ]
               ]
        )


renderBeer : Beer -> Int -> Html Msg
renderBeer beer index =
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
        , button [ onClick (Delete index) ] [ text "Delete" ]
        ]


ratingButton : Int -> Html Msg
ratingButton rating =
    label []
        [ input [ type_ "radio", name "rating", onClick (Rating rating) ] []
        , text (toString rating)
        ]


validate : Beer -> Bool
validate beer =
    let
        { name, brand, beerType } =
            beer
    in
        if String.length name == 0 || String.length brand == 0 || String.length beerType == 0 then
            False
        else
            True
