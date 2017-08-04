module Types exposing (..)

import Http


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
    , response : List Beer
    }


type Msg
    = Add Beer
    | Name String
    | Brand String
    | Type String
    | Rating Int
    | Had Bool
    | Reset
    | ErrorMessage String
    | Delete Int
    | QueryComplete (Result Http.Error (List Beer))
    | GetData
