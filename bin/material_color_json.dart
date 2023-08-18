import 'package:material_color_json/material_color_json.dart'
    as material_color_json;

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Error : Add json theme file path");
    return;
  }
  material_color_json.generateColorScheme(arguments[0]);
}
