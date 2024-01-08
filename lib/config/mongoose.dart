import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../app/error/server_exception.dart';

/// [Mongoose] is a class that connects to the database.
/// it also provides a static [db] variable that can be used to access the
/// database.
class Mongoose {
  Mongoose._();
  static mongo.Db? _db;

  /// init() connects to the database and sets the db variable.
  static Future<void> open(String uri) async {
    final db = mongo.Db(uri);
    await db.open();
    _db = db;
  }

  static mongo.Db? get db {
    if (_db == null) {
      throw ServerException('Make sure you are connected to the database.');
    }
    return _db;
  }
}
