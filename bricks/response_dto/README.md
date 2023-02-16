# Response DTO

A brick to create a response DTO with properties and the supporting method fromJson

## How to use

### Command Line

`mason make response_dto`

Then follow the prompt instructions and add information:

- Name of the response DTO (separate multiple words with whitespace, e.g.: "my first" will result in MyFirstResponse)
- Optional: Add properties (Format: dataType propertyName, e.g.: String myProperty)
- Entering 'e' will exit the adding properties prompt

After the file has been generated:

- [ ] Move the generated keys to the keys.dart file

## Outputs

```
mason make response_dto (with name: my first, and properties [String name, int? age])
└── my_first_response.dart
```

```dart
import '../../../core/utils/keys.dart';

class MyFirstResponse {
  final String? name;
  final int? age;

  const MyFirstResponse._({
    this.name,
    this.age,
  });

  factory MyFirstResponse.empty() {
    return const MyFirstResponse._();
  }

  factory MyFirstResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return MyFirstResponse._(
        name: json[nameKey] as String?,
        age: json[ageKey] as int?,
      );
    }

    return MyFirstResponse.empty();
  }
}

// TODO(FreeTea): Add the value(s) for the generated key(s) and then move them into keys.dart
// (delete if key(s) already exist(s))

const nameKey = '';
const ageKey = '';

```
