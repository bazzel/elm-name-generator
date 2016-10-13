module Main exposing (..)

import Fragments
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
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
        [ div [] [ h3 [] [ text (model) ] ]
        , button [ class "btn", onClick Generate ] [ span [] [ text "Generate new name" ] ]
        ]



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Generate ->
            ( model, generateRandomName )

        OnResult newName ->
            newName ! []


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
            (pickFragment Fragments.beginning a)
                ++ (pickFragment Fragments.middle b)
                ++ (pickFragment Fragments.last c)
    in
        generate OnResult
            (Random.map3 pickFragments
                (generator Fragments.beginning)
                (generator Fragments.middle)
                (generator Fragments.last)
            )
