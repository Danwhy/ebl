module Listtest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, list, int, string)
import Test exposing (..)
import Itemlist exposing (..)


emptyModel : Model
emptyModel =
    Model [] { name = "", brand = "", beerType = "", rating = 0, had = False } ""


oneItemModel : Model
oneItemModel =
    Model
        [ (Beer "Test" "TestBrand" "TestType" 0 False) ]
        { name = "", brand = "", beerType = "", rating = 0, had = False }
        ""


suite : Test
suite =
    describe "List functions"
        [ describe "Validation tests"
            [ test "empty record is not valid" <|
                \_ ->
                    let
                        testBeer =
                            Beer "" "" "" 0 False
                    in
                        Expect.equal (validate testBeer) False
            , test "record with one value is valid" <|
                \_ ->
                    let
                        testBeer =
                            Beer "Testing" "" "" 0 False
                    in
                        Expect.equal (validate testBeer) True
            ]
        , describe "Add item to list"
            [ test "add item" <|
                \_ ->
                    let
                        testBeer =
                            Beer "Test" "TestBrand" "TestType" 0 False
                    in
                        Expect.equal
                            (update (Add testBeer) emptyModel)
                            ( oneItemModel, Cmd.none )
            ]
        , describe "Remove item from list"
            [ test "remove item" <|
                \_ ->
                    let
                        testIndex =
                            0
                    in
                        Expect.equal
                            (update (Delete testIndex) oneItemModel)
                            ( emptyModel, Cmd.none )
            ]
        ]