import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../core/models/exceptions/api_exception.dart';
import '../../core/utils/helpers/exception_handler.dart';
import '../../services.dart';

class {{service_name.pascalCase()}} {
    final _apiClient = services<ApiClient>();

}