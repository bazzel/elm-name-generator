module Main exposing (..)

import Html exposing (text, Html)
import Html.App as Html
import List
import Maybe


main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }


view model =
    text (randomString beginning ++ randomString middle ++ randomString last)


update model =
    model


init =
    ( "", Cmd.none )


subscriptions model =
    Sub.none


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
