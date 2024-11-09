import 'package:sqflite/sqflite.dart';

import '../database/local_db.dart';
import '../model/clients_model.dart';

class LocalServices {
  final sqlDb = SqlDB.sqlDb;

  ///Add new client:
  Future<int> createClient({required Client client}) async {
    final Database? db = await sqlDb.db;
    db!.insert('CLIENTS', client.toJson()).then((value) {
      return value;
    }).catchError((onError) {
      print(onError.toString());
    });
    return 0;
  }

  ///get all Client:
  Future<List<Map<String, dynamic>>> getClients() async {
    print('\nget 01==>Local Services\n');
    final Database? db = await sqlDb.db;
    return await db!.query('CLIENTS');
  }

  ///update Client:
  Future<int> updateClient({required Client client}) async {
    final Database? db = await sqlDb.db;
    db!.update('CLIENTS', client.toJson(),
        where: "id = ?", whereArgs: [client.id]).then((value) => value);
    return 0;
  }

  ///delete Client:
  Future<int> deleteClient({required int id}) async {
    final Database? db = await sqlDb.db;
    db!
        .delete('CLIENTS', where: "id = ?", whereArgs: [id])
        .then((value) => value)
        .catchError((onError) {
          print(onError.toString());
        });
    return 0;
  }
}
