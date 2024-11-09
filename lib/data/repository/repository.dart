import 'package:clients/data/model/clients_model.dart';
import '../local_services/services_db.dart';

class Repository {
  final LocalServices localDb = LocalServices();

  ///get
  Future<List<Client>> getAllClients() async {
    List<Client> clients = [];
    List<Map<String, dynamic>> value = await localDb.getClients();
    clients = value.map((e) => Client.fromJson(e)).toList();
    return clients;
  }

  ///insert
  Future<int> insertClient(Client client) =>
      localDb.createClient(client: client);

  ///update
  Future<int> updateClient(Client client) =>
      localDb.updateClient(client: client);

  ///delete
  Future<int> deleteById(int id) => localDb.deleteClient(id: id);
}
