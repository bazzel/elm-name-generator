module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import List
import Maybe
import Random exposing (generate)
import Array


main : Program Never
main =
    Html.program
        { view = view
        , update = update
        , init = ( { name = "" }, generateRandomName )
        , subscriptions = subscriptions
        }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (model.name) ]
        , button [ onClick Generate ] [ text "Generate new name" ]
        ]


type Msg
    = Generate
    | OnResult String


type alias Model =
    { name : String }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Generate ->
            ( model, generateRandomName )

        OnResult str ->
            ( { model | name = str }, Cmd.none )


generateRandomName : Cmd Msg
generateRandomName =
    let
        generator list =
            Random.int 0 (List.length list - 1)

        pickFragment list i =
            list
                |> Array.fromList
                |> Array.get i
                |> Maybe.withDefault ""

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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


beginning : List String
beginning =
    [ "A", "Be", "De", "El", "Fa", "Jo", "Ki", "La", "Ma", "Na", "O", "Pa", "Re", "Si", "Ta", "Va" ]


middle : List String
middle =
    [ "bar", "ched", "dell", "far" ]


last : List String
last =
    [ "a", "ac", "ai", "al", "am", "an", "ar", "ea", "el", "er", "ess", "elt", "ic", "id", "il", "in", "is", "of", "us" ]
