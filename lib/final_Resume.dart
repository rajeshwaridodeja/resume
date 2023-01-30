import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume/resume_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db.dart';
import 'list.dart';
import 'main.dart';

class Final_Resume extends StatefulWidget {
  /// finanl data lane ke liye
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
            padding: EdgeInsets.only(top: 30),
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
                                builder: (context) => Todo_Page()));
                      },
                      child: Text(
                        widget.myTitle[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none),
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
