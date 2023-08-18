# Material Color JSON

Material Color JSON is a Dart package that helps you generate Flutter color schemes from Material Color Builder JSON files.

## What is Material Color Builder?

Material Color Builder is a web tool that allows you to create custom color schemes for your Flutter app using the Material Design guidelines. You can choose from a variety of colors, adjust their shades, and preview how they look on different components. You can also export your color scheme as a JSON file that can be used by Material Color JSON.

You can access the Material Color Builder web page by clicking [here](https://m3.material.io/theme-builder). You can also learn more about the tool and its features by reading the [introduction blog post](https://material.io/blog/material-theme-builder).

## How to use Material Color JSON?

To use Material Color JSON, follow these steps:

1. Add the package as a dev dependency in your `pubspec.yaml` file:

```yaml
dev_dependencies:
  material_color_json: ^1.0.0
```

2. Run `flutter pub get` to install the package.
3. Create a JSON file using Material Color Builder and save it in the root of your project. For example, `theme.json`.
4. Run the following command in your terminal, replacing `json_file_name` with the name of your JSON file:

```bash
flutter pub run material_color_json json_file_name
```

For example, if your JSON file is named `theme.json`, run:

```bash
flutter pub run material_color_json theme.json
```

5. This will generate a file named `color_schemes.g.dart` in the `lib` directory of your project. This file contains the code for your color schemes as Flutter constants.
6. Import the `color_schemes.g.dart` file in your Flutter app and use the color schemes as you wish. For example:

```dart
import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: MyHomePage(),
    );
  }
}
```

## License

Material Color JSON is licensed under the MIT License. See the [LICENSE] file for more details.
