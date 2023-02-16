# Service class

A brick to create a service class

## How to use

### Command Line

`mason make service_class`

Then follow the prompt instructions and add information:

- Name of the service class (separate multiple words with whitespace, e.g.: "my first" will result in MyFirstService)

## Outputs

```
mason make service_class (with name: my first)
└── my_first_service.dart
```

```dart
import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../core/models/exceptions/api_exception.dart';
import '../../core/utils/helpers/exception_handler.dart';
import '../../services.dart';

class MyFirstService {
  final _apiClient = services<ApiClient>();
}

```
