import 'dart:io';

import 'core/string_helper.dart';
import 'mapper_gen.dart';
import 'model_gen.dart';

class EntityGen {
  static void generateEntity(
      String moduleName, Map<String, dynamic> entitysData) {
    bool createInputModel = false;
    bool createMappers = false;
    bool createAdapter = false;
    bool createModel = false;

    entitysData.forEach(
      (entityName, fieldsEntity) {
        try {
          print(entityName);
          if (fieldsEntity is Map<String, dynamic>) {
            Map<String, dynamic>? options = fieldsEntity['options'];
            Map<String, dynamic> fiels = fieldsEntity;
            fiels.remove('options');

            String classContent = _createEntity(entityName, fiels);
            String filePath =
                'lib/modules/$moduleName/domain/entities/${StringHelper.formatCreateName(entityName)}_entity.dart';
            Directory('lib/modules/$moduleName/domain/entities/')
                .createSync(recursive: true);
            File(filePath).writeAsStringSync(classContent);

            print('Entidade Geranda  gerado: $filePath');

            if (options != null) {
              createModel = options['createModel'] ?? false;
              createMappers = options['createMappers'] ?? false;
              print('Gerando Model');
              if (createModel) {
                ModelGen.generateModel(moduleName, entitysData);
              }
              if (createMappers) {
                print('Gerando Mapper');
                MapperGen.generateMapper(moduleName, entitysData);
              }
            }
          }
        } catch (e) {
          print('Erro ao gerar arquivo: $e');
        } finally {
          if (fieldsEntity.containsKey('options') &&
              fieldsEntity['options']['create'] == true) {
            fieldsEntity['options']['create'] = true;
          }
        }
      },
    );
  }

  static String _createEntity(String className, Map<String, dynamic> fields) {
    StringBuffer classBuffer = StringBuffer();
    classBuffer.writeln('import \'package:equatable/equatable.dart\';');

    fields.forEach((_, propertyType) {
      if (propertyType.contains('*')) {
        classBuffer.writeln(
            'import \'${StringHelper.formatCreateName(propertyType.substring(0, propertyType.length - 1))}_entity.dart\';');
      }
    });
    classBuffer.writeln('');

    classBuffer.writeln(
        'class ${StringHelper.capitalizeFirstLetter(className)}Entity extends Equatable {');

    fields.forEach((propertyName, propertyType) {
      String type = propertyType.contains('*')
          ? propertyType.substring(0, propertyType.length - 1) + 'Entity'
          : propertyType;
      classBuffer.writeln(' final $type $propertyName;');
    });
    classBuffer.writeln('');

    classBuffer.writeln(
        ' const ${StringHelper.capitalizeFirstLetter(className)}Entity ({');

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
