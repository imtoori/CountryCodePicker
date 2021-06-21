## 2.0.2

- added localization for no_country text in italian and english (please open a pr with other languages if you know them 🙏)
- added possibility to inject a custom list of countries using `CountryCodePicker.countryList`
- minor fixes

## 2.0.1

- Use `universal_platform` package

## 2.0.0

- support 70 languages
- use modal_bottom_sheet 2.0.0
- nullable integration
- switch to dialog on desktop app support
- added flagDecoration

## 1.7.0

- Update modal_bottom_sheet to 1.0.0+1
- Update zh.json
- Add background color to selection dialog
- Add option to show dropdown button for ease of selection for user

## 1.6.2

- Fix breaking change with modal_bottom_sheet: 1.0.0-dev
- Fix Myanmar name
- Center selection dialog to let user size it in Flutter web
- Add ZH localization support
- Optimize all flag images

## 1.6.1

- Update to modal_bottom_sheet: ^1.0.1-dev

## 1.6.0

- Added option to change close icon and search icon
- Fix bottom sheet overflow
- Make modal_bottom_sheet use dynamic versioning
- Add `barrierColor`, `backgroundColor` and `boxDecoration` properties

## 1.5.0

- Add ko.json translations
- Remove key in SimpleDialogOption
- Use bottom sheet dialog rather than SimpleDialog

## 1.4.0

- Move onInit to didUpdateWidget in order to have localized countries

## 1.3.15

- Add portugal and german translations

## 1.3.14

- Add `hideMainText` property

## 1.3.12+1

- Fix Cayman Islands code

## 1.3.12

- Allow to edit dialog textStyle 

## 1.3.11

- Fix initialization

## 1.3.9

- Add hideSearch property

- Add spanish support

## 1.3.8

- Expose state to let use a key to open the dialog

- Add dialog size config

- Remove customList and fix countryFilter

- Fix filtering with localization

## 1.3.7

- Add `customList` property

- Add exit button in dialog

## 1.3.6

- Add `comparator` property

## 1.3.4

- Add `showFlagDialog` and  `showFlagMain`

## 1.3.3

- Fix a bug in localization

## 1.3.2

- Add `enable` property in order to use the disable the button

- Add `textOverflow` property

## 1.3.1

- Add `flagWidth` property

## 1.3.0

- Fixed selection dialog length

- Added i18n with `CountryLocalizations`

## 1.2.4

Fixed a bug that was making impossible to update initial selection

## 1.2.3

Update country code of Republica Dominicana.

## 1.2.2

Fix code list.

## 1.2.0

Added Ability to render custom Widget instead of package one's.

Bug fix.

## 1.1.7

Flag is now optional. Fix bug on initState.

## 1.1.5

OnlyCountrymode now also displays only the country on Textwidget when closed.

## 1.1.4

Add possibility to show only country name

## 1.1.1

Update allowed dart version and modify description

## 1.1.0

Changed CElement with CountryCode and fix error on favorite null

## 1.0.4

Update country name with translated version

## 1.0.3

Update flags dimension to reduce application size

## 1.0.2

Update framework compatiblity

## 1.0.1

Correct README and update screenshots

## 1.0.0

Use png flags instead of a font

## 0.2.2

Added textStyle and padding as widget parameters

## 0.2.1

Added some documentation

## 0.2.0

Now onChanged has a full CElement as argument and not only a string. (issue #4)

## 0.1.3

Favorite and initial selection can be one of code or dial code

## 0.1.2

Favorite and initial selection can be one of code or dial code

## 0.1.1

Tested with dart 2

## 0.1.0

Removed flags in iOS because they show up weirdly.

## 0.0.2

Add favorite countries option.

## 0.0.1

Initial release
