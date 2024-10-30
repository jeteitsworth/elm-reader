module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, option, select)
import Html.Attributes exposing (style, value, class)
import Html.Events exposing (onClick, onInput)

-- MODEL

type alias Model = 
    { fontSize : Int
    , fontFamily : String
    , darkMode : Bool 
    }


init : Model
init =
    { fontSize = 16
    , fontFamily = "serif"
    , darkMode = False }


-- MESSAGES 

type Msg
    = IncreaseFont
    | DecreaseFont
    | ChangeFont String
    | ToggleDarkMode

-- UPDATE

update : Msg -> Model -> Model
update msg model =
    case msg of
        IncreaseFont ->
            { model | fontSize = model.fontSize + 2 }

        DecreaseFont ->
            { model | fontSize = model.fontSize - 2 }

        ChangeFont newFontFamily ->
            { model | fontFamily = newFontFamily }
        
        ToggleDarkMode ->
            { model | darkMode = not model.darkMode }

-- VIEW

view : Model -> Html Msg
view model =
    let themeClass =
            if model.darkMode then
                "dark-mode"
                else
                    "light-mode"
    in
    div [class themeClass]
        [ div []
            [ button [ onClick IncreaseFont ] [ text "+" ]
            , button [ onClick DecreaseFont ] [ text "-" ]
            , button [ onClick ToggleDarkMode ]
                [ text (if model.darkMode then "Switch to light" else "Switch to Dark") ]
            ]
        , div [] 
            [ text "Choose a font: "
            , select [ onInput ChangeFont ]
                [ option [value "serif" ] [ text "Serif" ]
                , option [value "sans-serif"] [ text "Sans-Serif" ]
                , option [value "monospace" ] [text "Monospace" ]
                ]
            ]
        , div [ style "font-size" (String.fromInt model.fontSize ++ "px")
        , style "font-family" model.fontFamily 
        ]
        [ text "This is the content of the story." ]
    ]

-- MAIN

main : Program() Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }

