import 'dart:io';

import 'core/string_helper.dart';

class ModelGen {
  static void generateModel(
      String moduleName, Map<String, dynamic> modelsData) {
    print('Gerando Model...');
    modelsData.forEach(
      (modelName, fieldsModel) {
        try {
          print(modelName);
          if (fieldsModel is Map<String, dynamic>) {
            Map<String, dynamic> fiels = fieldsModel;
            fiels.remove('options');

            String classContent = _createModel(modelName, fiels);
            String filePath =
                'lib/modules/$moduleName/infra/models/${StringHelper.formatCreateName(modelName)}_model.dart';
            Directory('lib/modules/$moduleName/infra/models/')
                .createSync(recursive: true);
            File(filePath).writeAsStringSync(classContent);

            print('model Gerando: $filePath');

            print('Gerando Model');
          }
        } catch (e) {
          print('Erro ao gerar arquivo: $e');
        }
      },
    );
  }

  static String _createModel(String className, Map<String, dynamic> fields) {
    StringBuffer classBuffer = StringBuffer();
    classBuffer.writeln('import \'package:equatable/equatable.dart\';');

    fields.forEach((_, propertyType) {
      if (propertyType.contains('*')) {
        classBuffer.writeln(
            'import \'${StringHelper.formatCreateName(propertyType.substring(0, propertyType.length - 1))}_model.dart\';');
      }
    });
    classBuffer.writeln('');

    classBuffer.writeln(
        'class ${StringHelper.capitalizeFirstLetter(className)}Model extends Equatable {');

    fields.forEach((propertyName, propertyType) {
      String type = propertyType.contains('*')
          ? propertyType.substring(0, propertyType.length - 1) + 'Model'
          : propertyType;
      classBuffer.writeln(' final $type $propertyName;');
    });
    classBuffer.writeln('');

    classBuffer.writeln(
        ' const ${StringHelper.capitalizeFirstLetter(className)}Model ({');

    fields.forEach((propertyName, propertyType) {
      if (propertyType.contains('?')) {
        classBuffer.writeln('   this.$propertyName,');
      } else {
        classBuffer.writeln('   required this.$propertyName,');
      }
    });
    classBuffer.writeln(' });');

    classBuffer.writeln('');
    classBuffer.writeln(' @override');
    classBuffer.writeln(' List<Object?> get props => [');
    fields.forEach((propertyName, propertyType) {
      classBuffer.writeln('   $propertyName,');
    });
    classBuffer.writeln(' ];');
    classBuffer.writeln('}');

    return classBuffer.toString();
  }
}
