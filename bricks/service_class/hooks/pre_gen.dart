import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars..updateServiceAndFunctionsName();
}

extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> updateServiceAndFunctionsName() {
    String? serviceName = this['service_name'];

    if (serviceName == null) {
      return this;
    }

    if (serviceName.toLowerCase().endsWith('service')) {
      if (serviceName.contains(' ')) {
        final serviceNameElements = serviceName.split(' ')..removeLast();

        serviceName = serviceNameElements.fold(
          '',
          (previousValue, element) => previousValue + ' ' + element,
        );
      } else {
        serviceName = serviceName.toLowerCase().split('service').first;
      }
    }

    return this
      ..update(
        'service_name',
        (value) => '$serviceName service',
      );
  }
}
