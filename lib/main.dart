import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume/resume_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db.dart';
import 'list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Testing',
      home: Todo_Page(),
    );
  }
}

class Todo_Page extends StatefulWidget {
  const Todo_Page({Key? key}) : super(key: key);

  @override
  State<Todo_Page> createState() => _Todo_PageState();
}

class _Todo_PageState extends State<Todo_Page> {
  var dbhelper = Databasehelper.instance;
  List<Item> item = [];

  SharedPreferences? sp;
  @override
  void initState() {
    super.initState();
    asynctask();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        sp = value;
      });
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> asynctask() async {
    item = await dbhelper.getTask();
    setState(() {});
    print("item list is ${item[0].name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => resume_page()),
              ).then((value) {
                if (value) {
                  asynctask();
                }
              });
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: item.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    print("list item is ${item[index].name}");
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  resume_page(item: item[index]),
                            )).then((value) {
                          asynctask();
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 6,
                                  ),
                                  child: Text(
                                    item[index].name.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    item[index].email.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    item[index].moblie.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    item[index].experience.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    item[index].education.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    item[index].project.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 300,
                                  margin: const EdgeInsets.only(
                                    top: 12,
                                    right: 30,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                ),
                              ],
                            )),
                            InkWell(
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                await dbhelper.deleteList(item[index].id!);
                                asynctask();
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        margin:
                            const EdgeInsets.only(top: 4, right: 15, left: 15),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
