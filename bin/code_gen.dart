import 'dart:convert';
import 'dart:io';

import 'package:code_gen/code_gen.dart';

void main() {
  EntityGenerator entityGenerator = EntityGenerator();

  final file = File('bin/main.json');

  String jsonString = file.readAsStringSync();

  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  entityGenerator.generateFiles(jsonMap);
}
