import 'package:local/service/user_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:local/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<User> userBox;

  static Future<ObjectBox> create() async {
    // final docsDir = await getApplicationDocumentsDirectory();
    // final store = await openStore(directory: p.join(docsDir.path, "User"));
    final store = await openStore();
    return ObjectBox._create(store);
  }

  ObjectBox._create(this.store) {
    //  userBox = store.box<User>();
    userBox = Box<User>(store);
  }

  open() async {
    store = await openStore();
  }

  close() {
    store.close();
  }

  void addUser(User user) {
    userBox.put(user);
  }
}
