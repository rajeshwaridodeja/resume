import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume/resume_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db.dart';
import 'list.dart';

class Final_Resume extends StatefulWidget {
  Final_Resume({Key? key, required this.myTitle}) : super(key: key);

  final List myTitle;

  @override
  State<Final_Resume> createState() => _Final_ResumeState();
}

class _Final_ResumeState extends State<Final_Resume> {
  List<String> tasks = [
    "Name",
    "Email",
    "Mobile No.",
    "Experience",
    "Education",
    "Project",
  ];
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
    //item = await dbhelper.getTask();
    //setState(() {});
    //print("item list is ${item[0].name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              " Final Resume",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.myTitle.length,
                  itemBuilder: (context, index) {
                    print("list item is ${widget.myTitle[index]}");
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
                      child: Text(
                        widget.myTitle[index],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none),
                      ), /*Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.myTitle[index],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Text(
                                        item[index].name.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Email:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Text(
                                        item[index].email.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Mobile No.:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Text(
                                        item[index].moblie.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Experience:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Text(
                                        item[index].experience.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Education:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Text(
                                        item[index].education.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Project:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Text(
                                        item[index].project.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  width: 300,
                                  margin: const EdgeInsets.only(
                                    top: 12,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),*/
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
