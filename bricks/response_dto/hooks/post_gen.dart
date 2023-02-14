import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final directory = Directory.current.path;
  List<String> folders;

  if (Platform.isWindows) {
    folders = directory.split(r'\').toList();
  } else {
    folders = directory.split('/').toList();
  }
  final libIndex = folders.indexWhere((folder) => folder == 'lib');

  final root = folders.sublist(0, libIndex).join('/').toString();
  final formatCodeProcess = await Process.start(
    'dart',
    ['format', 'lib', '--line-length', '100'],
    runInShell: true,
    workingDirectory: root,
  );
  await stdout.addStream(formatCodeProcess.stdout);
  await stderr.addStream(formatCodeProcess.stderr);
}
