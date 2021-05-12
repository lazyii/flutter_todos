import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';

import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;

import '../database.dart';

Database constructDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dataDir.path, 'db.sqlite3'));
      return VmDatabase(dbFile, logStatements: logStatements);
    });
    return Database(executor);
  } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    final executor = LazyDatabase(() async {
      final dbFile = File('db.sqlite3');
      return VmDatabase(dbFile, logStatements: logStatements);
    });
    return Database(executor);
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite3 here, into the documents folder
    // for your app.
    final dbFolder = await paths.getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite3'));
    return VmDatabase(file);
  });
}
