import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light, // luminosità
    visualDensity: VisualDensity.comfortable, // densità visuale
    primarySwatch:
        MaterialColor(0xFFc6dbf0, swatchColorsLight), // campione primario
    primaryColor: Color(0xFFc6dbf0), // colore primario
    primaryColorBrightness: Brightness.light, // luminosità colore primario
    primaryColorLight: Color(0xFFcfe8ef), // colore primario chiaro
    primaryColorDark: Color(0xFFa0c4e2), // colore primario scuro
    canvasColor: Colors.grey.shade800, // colore della tela
    shadowColor: Colors.black, // colore dell'ombra
    scaffoldBackgroundColor: Colors.grey.shade800, // colore di sfondo scaffold
    bottomAppBarColor: Color(0xFFc6dbf0), // colore appbar in basso
    cardColor: Color(0xFF85c7de), // colore card widget
    dividerColor: Colors.black, // colore widget divider
    focusColor: Color(0xFFf4989c), // colore messa a fuoco
    hoverColor: Color(0xFFf4989c), // colore al passaggio del mouse
    highlightColor: Color(0xFFacd8aa), // colore in evidenza
    splashColor: Color(0xFFf4989c), // colore schizzi
    selectedRowColor: Colors.grey, // colore riga selezionata
    unselectedWidgetColor: Colors.white, // colore widget non selezionato
    disabledColor: Colors.grey.shade100, // colore elemento disabilitato
    buttonTheme: ButtonThemeData(), // tema dei pulsanti
    toggleButtonsTheme:
        ToggleButtonsThemeData(), // tema dei pulsanti disattivabili/attivabili
    secondaryHeaderColor: Color(0xFFe78f8e), // colore intestazione secondario
  );

  static final Map<int, Color> swatchColorsLight = {
    50: Color(0xFFc6dbf0),
    100: Color(0xFFc6dbf0),
    200: Color(0xFFc6dbf0),
    300: Color(0xFFc6dbf0),
    400: Color(0xFFc6dbf0),
    500: Color(0xFFc6dbf0),
    600: Color(0xFFc6dbf0),
    700: Color(0xFFc6dbf0),
    800: Color(0xFFc6dbf0),
    900: Color(0xFFc6dbf0),
  };

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.comfortable,
    primarySwatch: MaterialColor(0xFF569D87, swatchColorsDark),
  );

  static final Map<int, Color> swatchColorsDark = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
}
