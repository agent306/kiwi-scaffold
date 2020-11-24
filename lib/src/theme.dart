import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData buildThemeData(BuildContext context, {
      Color primaryColor,
      Color primaryColorLight,
      Color primaryColorDark,
      Color accentColor,
      Color accentColorLight,
      Color backgroundColor,
      Color backgroundColorLight,
      Color scaffoldColor,
      Brightness brightness = Brightness.light,
    }) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: brightness ?? Brightness.light,
      statusBarIconBrightness: brightness ?? Brightness.light,
    ));
    
    return ThemeData(
      brightness: brightness,
      primaryColor: brightness == Brightness.light ? (primaryColorLight ?? null) : (primaryColor ?? null),
      primaryColorDark: primaryColor ?? null,
      accentColor: brightness == Brightness.light ? (accentColorLight ?? null) : (accentColor ?? null),
      backgroundColor: brightness == Brightness.light ? (backgroundColorLight ?? null) : (backgroundColor ?? null),
      scaffoldBackgroundColor: scaffoldColor ?? null,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: brightness == Brightness.light ? Colors.black : Colors.white),
        actionsIconTheme: IconThemeData(color: brightness == Brightness.light ? Colors.black : Colors.white)
      ),
      cardTheme: CardTheme(
        elevation: 8.0,
        margin: EdgeInsets.all(16.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.light ? Colors.grey[200] : Colors.grey[700],
        contentPadding: EdgeInsets.all(14.0),
        prefixStyle: TextStyle(color: Colors.grey),
        suffixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      )
    );
  }
}
