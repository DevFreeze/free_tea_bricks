import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart';

void run(HookContext context) {
  final fileName = context.vars['service_class'] as String;
  final filePath = join(Directory.current.path, fileName);

  final file = File(filePath);

  final lines = file.readAsLinesSync();
  print(lines.last);

  file.writeAsString('');

  lines.removeLast();
  final linesAsString = lines.fold('', (previousValue, element) => '$previousValue\n$element');

  file.writeAsString(linesAsString);

  final httpMethod = context.vars['http_method'] as String;

  final useGet = httpMethod == 'GET';
  final usePost = httpMethod == 'POST';
  final usePut = httpMethod == 'PUT';
  final useDelete = httpMethod == 'DELETE';

  print(context.vars['endpoint']);

  context.vars = {
    ...context.vars,
    'use_get': useGet,
    'use_post': usePost,
    'use_put': usePut,
    'use_delete': useDelete,
  };
}
