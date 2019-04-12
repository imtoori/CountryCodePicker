import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
                      favorite: ['+39', 'FR']),
                  SizedBox(
                    width: 400,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountryCodePicker(
                        onChanged: print,
                        initialSelection: 'TF',
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        alignLeft: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountryCodePicker(
                          onChanged: print,
                          initialSelection: 'TF',
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          favorite: ['+39', 'FR']),
                    ),
                  ),
                ],
              ),
            )));
  }
}
