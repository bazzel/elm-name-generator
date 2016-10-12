module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import List
import Maybe
import Random exposing (generate)
import Array


--MAIN


main : Program Never
main =
    Html.program
        { view = view
        , update = update
        , init = ( "", generateRandomName )
        , subscriptions = \_ -> Sub.none
        }



--MODEL


type alias Model =
    String



--MESSAGES


type Msg
    = Generate
    | OnResult String



--VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (model) ]
        , button [ onClick Generate ] [ text "Generate new name" ]
        ]



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Generate ->
            ( model, generateRandomName )

        OnResult newName ->
            ( newName, Cmd.none )


generateRandomName : Cmd Msg
generateRandomName =
    let
        generator : List String -> Random.Generator Int
        generator list =
            Random.int 0 (List.length list - 1)

        pickFragment : List String -> Int -> String
        pickFragment list i =
            list
                |> Array.fromList
                |> Array.get i
                |> Maybe.withDefault ""

        pickFragments : Int -> Int -> Int -> String
        pickFragments a b c =
            (pickFragment beginning a)
                ++ (pickFragment middle b)
                ++ (pickFragment last c)
    in
        generate OnResult
            (Random.map3 pickFragments
                (generator beginning)
                (generator middle)
                (generator last)
            )


beginning : List String
beginning =
    [ "A", "Be", "De", "El", "Fa", "Jo", "Ki", "La", "Ma", "Na", "O", "Pa", "Re", "Si", "Ta", "Va" ]


middle : List String
middle =
    [ "bar", "ched", "dell", "far" ]


last : List String
last =
    [ "a", "ac", "ai", "al", "am", "an", "ar", "ea", "el", "er", "ess", "elt", "ic", "id", "il", "in", "is", "of", "us" ]
