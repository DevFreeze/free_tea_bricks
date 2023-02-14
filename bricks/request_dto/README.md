# Request DTO

A brick to create a request DTO with properties and the supporting methods create and toJson

## How to use

### Command Line

`mason make request_dto`

Then follow the prompt instructions and add information:

- Name of the request DTO (separate multiple words with whitespace, e.g.: "my first" will result in MyFirstRequest)
- Optional: Add properties (Format: dataType propertyName, e.g.: String myProperty)
- Entering 'e' will exit the adding properties prompt
- After generating the file, move the generated keys to the keys.dart file

## Outputs

```
mason make request_dto (with name: my first, and properties [String name, int? age])
└── my_first_request.dart
```

```dart
import '../../../core/utils/keys.dart';

class MyFirstRequest {
  final String name;
  final int? age;

  const MyFirstRequest._({
    required this.name,
    this.age,
  });

  factory MyFirstRequest.create({
    required String name,
    int? age,
  }) {
    return MyFirstRequest._(
      name: name,
      age: age,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      nameKey: name,
      ageKey: age,
    };
  }
}

// TODO(FreeTea): Add the value(s) for the generated key(s) and then move them into keys.dart
// (delete if key(s) already exist(s))

const nameKey = '';
const ageKey = '';

```
