import 'entity_gen.dart';

class EntityGenerator {
  EntityGen entityGen = EntityGen();
  void generateFiles(Map<String, dynamic> jsonMap) {
    jsonMap.forEach((_, module) {
      module.forEach((moduleName, modules) {
        Map<String, dynamic> entitys = modules['entity'];
        EntityGen.generateEntity(moduleName, entitys);
      });
    });
  }
}
