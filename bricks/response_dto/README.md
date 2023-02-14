# Response DTO

A brick to create a response DTO with properties and the supporting method fromJson

## How to use

### Command Line

`mason make response_dto`

Then follow the prompt instructions and add information:

- Name of the response DTO (separate multiple words with whitespace, e.g.: "my first" will result in MyFirstResponse)
- Optional: Add properties (Format: dataType propertyName, e.g.: String myProperty)
- Entering 'e' will exit the adding properties prompt
- After generating the file, move the generated keys to the keys.dart file

## Outputs

```
mason make response_dto (with name: my first, and properties [String name, int? age])
└── my_first_response.dart
```

```dart
import '../../../core/utils/keys.dart';

class MyFirstResponse {
  final String name;
  final int? age;

  const MyFirstResponse._({
    required this.name,
    this.age,
  });

  factory MyFirstResponse.fromJson(Map<String, dynamic> json) {
    return MyFirstResponse._(
      name: json[nameKey] as String,
      age: json[ageKey] as int?,
    );
  }
}

// TODO(FreeTea): Add the value(s) for the generated key(s) and then move them into keys.dart
// (delete if key(s) already exist(s))

const nameKey = '';
const ageKey = '';

```
