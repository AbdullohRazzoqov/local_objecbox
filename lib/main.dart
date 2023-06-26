import 'package:flutter/material.dart';
import 'package:local/objectbox.g.dart';
import 'package:local/service/user_service.dart';

import 'service/objectbox.dart';

late ObjectBox objectbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> user = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  void initState() {
    user = objectbox.store.box<User>().getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("ObjectBox"),
      ),
      body: user.isEmpty
          ? const Center(
              child: Text(
                "Malumot yo'q",
                style: TextStyle(fontSize: 24, color: Colors.cyan),
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Card(
                    child: ListTile(
                      title: Text(user[index].name),
                      subtitle: Text('${user[index].age} yosh'),
                    ),
                  ),
                );
              },
              itemCount: user.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  content: SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Ism'),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: ageController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'Yosh'),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        if (nameController.text.isNotEmpty &&
                            ageController.text.isNotEmpty) {
                          objectbox.addUser(User(
                              name: nameController.text,
                              age: int.parse(ageController.text)));
                          nameController.clear();
                          ageController.clear();
                          user = objectbox.store.box<User>().getAll();
                          setState(() {});
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Malumotlar bo\'sh')));
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.cyan),
                          width: 100,
                          height: 40,
                          child: const Center(
                              child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ))),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
