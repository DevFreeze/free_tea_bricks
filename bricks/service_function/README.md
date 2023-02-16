# Service function

A brick to update a service class with an additional function

## How to use

**Note: this brick only works when a service class was created before hand**

### Command Line

`mason make service_function --on-conflict append`

Then follow the prompt instructions and add information:

- Name of the service class which should be extended by a new function (give the exact service class file name, e.g.: "my_first_service.dart")
- Give the name of the function which will be added (separate multiple words with whitespace, e.g.: "my new function" will result in MyNewFunction)
- Give the name of the existing request DTO which will be passed to the function (give the exact class name, e.g.: "MyFirstRequest)
- Give the name of the existing response DTO which will be passed to the function (give the exact class name, e.g.: "MyFirstResponse)
- Select the HTTP method that the new function should use (GET, POST, PUT or DELETE)
- Give the name of the endpoint that should be called (e.g.: "api/some-endpoint")

After the file has bee modified:

- [ ] Import the library for the request DTO
- [ ] Import the library for the response DTO
- [ ] Move the endpoint to the file api_endpoints.dart
- [ ] Add a meaningful error message for an ApiException

## Outputs

```
mason make service_function --on-conflict append
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

  Future<MyFirstResponse> myNewFunction(
      MyFirstRequest request,
      ) async {
    try {
      final response = await _apiClient.get(
        endpoint: 'api/some-endpoint', // TODO(FreeTea): Move the endpoint to api_endpoints.dart
      );

      return MyFirstResponse.fromJson(response);
    } on ApiException catch (apiException) {
      await handleApiException(
        apiException: apiException,
        message: '', // TODO(FreeTea): Show meaningful error message to the user
      );
      return MyFirstResponse.empty();
    } catch (exception, stacktrace) {
      await handleException(exception, stacktrace);
      return MyFirstResponse.empty();
    }
  }
}

```
