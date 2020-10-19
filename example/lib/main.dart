import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: [
        Locale('en'),
        Locale('it'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('pt'),
        Locale('ko'),
        Locale('ar'),
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        return locale;
      },
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('CountryPicker Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CountryCodePicker(
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'IT',
                favorite: ['+39', 'FR', "EG"],
                showFlagDialog: false,
                comparator: (a, b) => b.name.compareTo(a.name),
                //Get the country information relevant to the initial selection
                onInit: (code) => print("on init ${code.name} ${code.dialCode} ${code.name}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
