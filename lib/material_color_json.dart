// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';

import 'package:material_color_utilities/material_color_utilities.dart';

String generated = """// ignore_for_file: depend_on_referenced_packages
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
%lightColorScheme%);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
%darkColorScheme%);

extension Materail3Color on ColorScheme {
%extensionColorScheme%
%corePalette%
}""";

void generateColorScheme(String jsonFileName) {
  var jsonFile = File("${Directory.current.path}/$jsonFileName");
  if (jsonFile.existsSync()) {
    var jsonTheme = jsonDecode(jsonFile.readAsStringSync());

    String lightColorScheme = "";
    String darkColorScheme = "";
    String extensionColorScheme = "";
    String corePalette = "";

    var scheme = reflect(Scheme.light(0xFFFFFF));

    for (MapEntry color in jsonTheme["schemes"]["light"].entries) {
      var value = color.value.toString().replaceFirst("#", "0xFF");
      var valueDark = jsonTheme["schemes"]["dark"][color.key]
          .toString()
          .replaceFirst("#", "0xFF");

      // check flutter scheme support
      var find = scheme.type.declarations.entries
          .where((element) => element.key == Symbol(color.key));
      if (find.isEmpty) {
        extensionColorScheme += """  Color get ${color.key} =>
      Color(brightness == Brightness.dark ? $valueDark : $value);\n""";
      } else {
        var key = color.key;
        // Special Parsing on Flutter
        if (color.key == "inverseOnSurface") {
          key = "onInverseSurface";
        }

        lightColorScheme += "  $key: Color($value),\n";
        darkColorScheme += "  $key: Color($valueDark),\n";
      }
    }

    corePalette = """  CorePalette get palette => CorePalette.fromList(
      [\n""";
    for (MapEntry palette in jsonTheme["palettes"].entries) {
      for (MapEntry color in palette.value.entries) {
        var value = color.value.toString().replaceFirst("#", "0xFF");
        corePalette += "        $value,\n";
      }
    }
    corePalette += """        ],
      );""";

    generated = generated.replaceAll("%lightColorScheme%", lightColorScheme);
    generated = generated.replaceAll("%darkColorScheme%", darkColorScheme);
    generated =
        generated.replaceAll("%extensionColorScheme%", extensionColorScheme);
    generated = generated.replaceAll("%corePalette%", corePalette);

    var generatedFile =
        File("${Directory.current.path}/lib/color_schemes.g.dart");
    generatedFile.writeAsStringSync(generated);
  }
}
