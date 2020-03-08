[![Pub](https://img.shields.io/pub/v/country_code_picker.svg)](https://pub.dartlang.org/packages/country_code_picker)

# country_code_picker

A flutter package for showing a country code selector.

It supports i18n.

<img src="https://raw.githubusercontent.com/Salvatore-Giordano/CountryCodePicker/master/screenshots/screen1.png" width="240"/>
<img src="https://raw.githubusercontent.com/Salvatore-Giordano/CountryCodePicker/master/screenshots/screen2.png" width="240"/>

## Usage

Just put the component in your application setting the onChanged callback.

```dart

@override
 Widget build(BuildContext context) => new Scaffold(
     body: Center(
       child: CountryCodePicker(
         onChanged: print,
         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
         initialSelection: 'IT',
         favorite: ['+39','FR'],
         // optional. Shows only country name and flag
         showCountryOnly: false,
         // optional. Shows only country name and flag when popup is closed.
         showOnlyCountryWhenClosed: false,
         // optional. aligns the flag and the Text left
         alignLeft: false,
       ),
     ),
 );

```

Example:

```dart

void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
  }

```

### i18n

Just add the `CountryLocalizations.delegate` in the list of your app delegates

```dart
 return new MaterialApp(
      supportedLocales: [
        Locale('en'),
        Locale('it'),
        Locale('en'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
```

## Contributions

Contributions of any kind are more than welcome! Feel free to fork and improve country_code_picker in any way you want, make a pull request, or open an issue.
