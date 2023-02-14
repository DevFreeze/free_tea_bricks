import 'dart:convert';

import 'package:mason/mason.dart';

final dataTypes = [
  'String',
  'num',
  'int',
  'double',
  'bool',
  'List',
  'Map',
  'dynamic',
  'Set',
  'DateTime',
];

void run(HookContext context) {
  final logger = context.logger;
  final properties = <Map<String, dynamic>>[];

  if (logger.confirm(
    '? Do you want to add properties to your model?',
    defaultValue: true,
  )) {
    _addProperties(logger, properties);
  }

  context.vars = {
    ...context.vars.maybeUpdateModelName(),
    'properties': properties,
    'hasProperties': properties.isNotEmpty,
  };
}

void _addProperties(Logger logger, List<Map<String, dynamic>> properties) {
  logger.info(lightYellow.wrap('enter `e` to exit adding properties'));
  logger.info(lightYellow.wrap('Format: dataType propertyName, e.g.: String myProperty'));

  while (true) {
    final property = logger.prompt(':').replaceAll(RegExp('\\s+'), ' ').trim();
    if (property.toLowerCase() == 'e') {
      break;
    }

    if (!property.contains(' ')) {
      logger.alert('That was not a valid format -> dataType propertyName e.g, String myProperty');
      continue;
    }

    if ((property.contains('<') && !property.contains('>')) ||
        (property.contains('>') && !property.contains('<'))) {
      logger.alert('It seems you are missing a < or >, please retype this property');
      continue;
    }

    final splitProperty = property.split(' ');
    final propertyType = splitProperty[0];
    final propertyName = splitProperty[1];
    _addProperty(
      properties,
      Property(
        name: propertyName,
        type: propertyType,
        isNullable: propertyType.endsWith("?"),
      ),
    );
  }
}

void _addProperty(List<Map<String, dynamic>> properties, Property property) {
  final hasSpecial =
      property.type.toLowerCase().contains('<') || property.type.toLowerCase().contains('>');
  final listProperties = _getCustomListProperties(hasSpecial, property.type);
  final isCustomDataType = !dataTypes.contains(property.type.cleaned) && !hasSpecial;

  properties.add({
    'name': property.name,
    'type': property.type,
    'isNullable': property.isNullable,
    'hasSpecial': hasSpecial,
    'isCustomDataType': isCustomDataType,
    ...listProperties,
  });
}

Map<String, dynamic> _getCustomListProperties(
  bool hasSpecial,
  String propertyType,
) {
  if (!hasSpecial || !propertyType.contains('List')) {
    return {
      'isCustomList': false,
    };
  }
  final startIndex = propertyType.indexOf('<');
  final endIndex = propertyType.indexOf('>');
  final listType = propertyType.substring(startIndex + 1, endIndex).trim();
  if (dataTypes.contains(listType.cleaned)) {
    return {
      'isCustomList': false,
    };
  }
  return {
    'isCustomList': true,
    'customListType': listType,
  };
}

class Property {
  final String name;
  final String type;
  final bool isNullable;

  const Property({
    required this.name,
    required this.type,
    required this.isNullable,
  });

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      name: map['name'],
      type: map['type'],
      isNullable: (map['type'] as String).endsWith("?"),
    );
  }

  factory Property.fromJson(String source) => Property.fromMap(json.decode(source));
}

extension StringExtension on String {
  String get cleaned {
    if (endsWith("?")) {
      return substring(0, length - 1);
    }

    return this;
  }
}

extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> maybeUpdateModelName() {
    final modelName = this['model_name'] as String?;

    if (modelName == null) {
      return this;
    }

    if (modelName.endsWith('request')) {
      return this;
    }

    return this
      ..update(
        'model_name',
        (value) => '$modelName request',
      );
  }
}
