import 'dart:io';

import 'core/string_helper.dart';

class MapperGen {
  static void generateMapper(
      String moduleName, Map<String, dynamic> mapperData) {
    print('Gerando Mapper...');

    mapperData.forEach(
      (mapperName, fieldsMapper) {
        try {
          print(mapperName);

          if (fieldsMapper is Map<String, dynamic>) {
            Map<String, dynamic> fiels = fieldsMapper;
            fiels.remove('options');

            String classContent = _createMapper(mapperName, fiels);
            String filePath =
                'lib/modules/$moduleName/external/mappers/${StringHelper.formatCreateName(mapperName)}_model_mapper.dart';
            Directory('lib/modules/$moduleName/external/mappers/')
                .createSync(recursive: true);
            File(filePath).writeAsStringSync(classContent);

            print('Mapper Gerando: $filePath');
          }
        } catch (e) {
          print('Erro ao gerar arquivo: $e');
        }
      },
    );
  }

  static String _createMapper(String className, Map<String, dynamic> fields) {
    StringBuffer classBuffer = StringBuffer();
    int importCount = 0;
    fields.values.where((element) => element.contains('*')).map((e) {
      importCount++;
    }).toList();

    classBuffer.writeln(
        'import \'../../infra/models/${StringHelper.formatCreateName(className)}_model.dart\';');

    fields.forEach((_, propertyType) {
      if (propertyType.contains('*')) {
        classBuffer.writeln(
            'import \'${StringHelper.formatCreateName(propertyType.substring(0, propertyType.length - 1))}_model_mapper.dart\';');
      }
    });

    classBuffer.writeln('');

    classBuffer.writeln(
        'class ${StringHelper.capitalizeFirstLetter(className)}ModelMapper {');

    if (importCount > 0) {
      fields.forEach((_, propertyType) {
        if (propertyType.contains('*')) {
          String propertyName =
              propertyType.substring(0, propertyType.length - 1);
          classBuffer.writeln(
              'final ${StringHelper.capitalizeFirstLetter(propertyName)}ModelMapper _${propertyName.toLowerCase()}ModelMapper;');
        }
      });

      classBuffer.writeln('');
      classBuffer.writeln(
          ' const ${StringHelper.capitalizeFirstLetter(className)}ModelMapper ({');

      fields.forEach(
        (_, propertyType) {
          if (propertyType.contains('*')) {
            classBuffer.writeln(
                '     required ${StringHelper.capitalizeFirstLetter(propertyType.substring(0, propertyType.length - 1))}ModelMapper ${propertyType.substring(0, propertyType.length - 1).toLowerCase()}ModelMapper,');
          }
        },
      );

      classBuffer.writeln(' })  : ');

      int count = 0;
      fields.forEach((propertyName, propertyType) {
        if (propertyType.contains('*')) {
          count++;
          classBuffer.write(
              '     _${propertyType.substring(0, propertyType.length - 1).toLowerCase()}ModelMapper = ${propertyType.substring(0, propertyType.length - 1).toLowerCase()}ModelMapper');
          if (count < importCount) {
            classBuffer.writeln(',');
          } else {
            classBuffer.writeln(';');
          }
        }
      });
    }

    classBuffer
        .writeln(' ${StringHelper.capitalizeFirstLetter(className)}Model ({');

    classBuffer.writeln(' required Map<String, dynamic> map, ');

    classBuffer.writeln('}) {');
    classBuffer.writeln(
        ' return ${StringHelper.capitalizeFirstLetter(className)}Model (');
    fields.forEach((propertyName, propertyType) {
      if (propertyType.contains('List<')) {
        String type = propertyType.substring(5, propertyType.length - 1);
        classBuffer.writeln(
            '   $propertyName: map[\'$propertyName\'] == null ? null : (map[\'$propertyName\'] as List).map((map) {');
        classBuffer.writeln(
            '     return _${type.toLowerCase()}ModelMapper.fromMap(map: map);');
        classBuffer.writeln('   }).toList(),');
      }
      if (propertyType.contains('*')) {}
      classBuffer.writeln('$propertyName: map[\'$propertyName\'],');
    });

    classBuffer.writeln('}');

    return classBuffer.toString();
  }
}
