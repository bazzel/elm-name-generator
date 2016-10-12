module Main exposing (..)

import Html exposing (text, Html)
import List
import Maybe


main : Html msg
main =
    text (randomString beginning ++ randomString middle ++ randomString last)


randomString : List String -> String
randomString list =
    let
        y =
            List.head list
    in
        case y of
            Just string ->
                string

            Nothing ->
                ""


beginning : List String
beginning =
    [ "A", "Be", "De", "El", "Fa", "Jo", "Ki", "La", "Ma", "Na", "O", "Pa", "Re", "Si", "Ta", "Va" ]


middle : List String
middle =
    [ "bar", "ched", "dell", "far" ]


last : List String
last =
    [ "a", "ac", "ai", "al", "am", "an", "ar", "ea", "el", "er", "ess", "elt", "ic", "id", "il", "in", "is", "of", "us" ]
