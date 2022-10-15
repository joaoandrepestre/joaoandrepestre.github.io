module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Url
import Url.Parser as P

-- MAIN

main : Program () Model Msg
main =
  Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL


type Model 
  = Home
  | Arts
  | Systems

init : () -> ( Model, Cmd Msg)
init flags = 
  ( Home, Cmd.none )

modelToString : Model -> String
modelToString model =
  case model of
    Home -> "Who am I?"
    Arts -> "Art Projects"
    Systems -> "Distributed Systems Projects"

-- UPDATE

type Msg 
  = TabClicked Model


update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
  case msg of
    TabClicked newModel ->
      (newModel, Cmd.none)
    
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

-- VIEW

view : Model -> Document Msg
view model = 
  { title = "Portfolio - João André Pestre"
  , body =
      [ viewTabHeader model
      , case model of 
          Home ->
            viewTabContent "Home" viewHomeTab
          Arts ->
            viewTabContent "Arts" viewArtsTab
          Systems ->
            viewTabContent "Systems" viewSystemsTab
      ]
      }

viewTabHeader : Model -> Html Msg
viewTabHeader model =
  div [ class "tab"]
    [ viewTabButton Home model
    , viewTabButton Arts model
    , viewTabButton Systems model
    ]

viewTabButton : Model -> Model -> Html Msg
viewTabButton tab model = 
  button [ class "tablinks"
         , ( if tab == model then 
                style "background-color" "#ccc"
              else
                style "background-color" "inherit"
            )
         , onClick ( TabClicked tab ) ] 
    [ text (modelToString tab) ]

viewTabContent : String -> Html Msg -> Html Msg
viewTabContent name innerHtml =
  div [ id name, class "tabcontent" ] [ innerHtml ]

viewHomeTab : Html Msg
viewHomeTab =
  embed [ src "statics/JoãoAndréPestre_CV.pdf", style "width" "100%", style "height" "100%" ] [ ]

viewArtsTab : Html Msg
viewArtsTab =
  div []
    [ h3 [] [ text "Tech projects related to art" ]
    , p [] [ text "Coming soon..."]
    ]

viewSystemsTab : Html Msg
viewSystemsTab =
  div []
    [ h3 [] [ text "Tech projects related to distributed systems" ]
    , p [] [ text "Coming soon..."]
    ]
