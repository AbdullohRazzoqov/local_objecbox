import 'package:local/service/user_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:local/objectbox.g.dart';

class ObjectBox {
  late final Store store;
  
  ObjectBox._create(this.store) {
    final userBox = store.box<User>();
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "User"));
    return ObjectBox._create(store);
  }
}