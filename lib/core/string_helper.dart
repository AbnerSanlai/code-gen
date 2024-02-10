class StringHelper {
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.replaceFirst(input[0], input[0].toUpperCase());
  }

  static String formatCreateName(String entityName) {
    List<String> result = [];

    for (int i = 0; i < entityName.length; i++) {
      String currentChar = entityName[i];

      if (currentChar == currentChar.toUpperCase()) {
        if (i > 0) {
          result.add('_');
        }
        result.add(currentChar.toLowerCase());
      } else {
        result.add(currentChar);
      }
    }

    return result.join();
  }
}
