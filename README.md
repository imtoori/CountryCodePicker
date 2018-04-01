![Pub](https://img.shields.io/badge/pub-0.0.2-orange.svg)

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
          initialSelection: 'IT',
          favorites: ['IT','FR'],
        ),
      ));

 ```

## Known issues

- On iOS the icons are not showed
