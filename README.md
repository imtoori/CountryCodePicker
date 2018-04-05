[![Pub](https://img.shields.io/badge/Pub-0.1.1-orange.svg)](https://pub.dartlang.org/packages/country_code_picker)

# country_code_picker

A flutter package for showing a country code selector.

<img src="screenshots/screen1.png" width="240"/>
<img src="screenshots/screen2.png" width="240"/>
<img src="screenshots/screen3.png" width="240"/>

## Usage

Just put the component in your application setting the onChanged callback.

 ```dart

 @override
  Widget build(BuildContext context) => new Scaffold(
      body: new Center(
        child: new CountryCodePicker(
          onChanged: print,
          // Initial selection can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'IT',
          favorite: ['IT','FR'],
        ),
      ));

 ```

## Known issues

- On iOS the icons are not showed
