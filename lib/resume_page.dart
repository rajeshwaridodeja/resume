import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'db.dart';
import 'list.dart';

class resume_page extends StatefulWidget {
  resume_page({Key? key, this.item}) : super(key: key);

  final Item? item;

  @override
  State<resume_page> createState() => _resume_pageState();
}

class _resume_pageState extends State<resume_page> {
  final TextEditingController NameText = TextEditingController();
  final TextEditingController EmailText = TextEditingController();
  final TextEditingController MobileNoText = TextEditingController();
  var mobile = MaskTextInputFormatter(
      mask: '+91 ##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final TextEditingController Experience = TextEditingController();
  final TextEditingController Education = TextEditingController();
  final TextEditingController Project = TextEditingController();

  var dbhelper = Databasehelper.instance;
  @override
  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      NameText.text = widget.item!.name.toString();
    }
    if (widget.item != null) {
      EmailText.text = widget.item!.email.toString();
    }
    if (widget.item != null) {
      MobileNoText.text = widget.item!.moblie.toString();
    }
    if (widget.item != null) {
      Experience.text = widget.item!.experience.toString();
    }
    if (widget.item != null) {
      Education.text = widget.item!.education.toString();
    }
    if (widget.item != null) {
      Project.text = widget.item!.project.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Resume',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ),
              menuItem("Name", "Name", NameText),
              menuItem("Email", "Email", EmailText),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Center(
                  child: TextField(
                    controller: MobileNoText,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent)),
                      labelText: "Mobile No.",
                      hintText: "Mobile No.",

                      // hintText: text,
                    ),
                    inputFormatters: [mobile],
                  ),
                ),
              ),
              menuItem("Experience", "Experience", Experience),
              menuItem("Education", "Education", Education),
              menuItem("Project", "Project", Project),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 30),
                    child: Container(
                      height: 50,
                      width: 120,
                      margin: const EdgeInsets.only(
                        left: 30,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                        color: Colors.teal,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          var name = NameText.text.toString();
                          var email = EmailText.text.toString();
                          var mobile = MobileNoText.text.toString();
                          var experience = Experience.text.toString();
                          var education = Education.text.toString();
                          var project = Project.text.toString();

                          if (name.isNotEmpty &&
                              email.isNotEmpty &&
                              mobile.isNotEmpty &&
                              experience.isNotEmpty &&
                              education.isNotEmpty &&
                              project.isNotEmpty) {
                            if (widget.item == null) {
                              Map<String, dynamic> row = {
                                Databasehelper.columnName: name,
                                Databasehelper.columnEmail: email,
                                Databasehelper.columnMobile: mobile,
                                Databasehelper.columnExperience: experience,
                                Databasehelper.columnEducation: education,
                                Databasehelper.columnProject: project,
                              };
                              try {
                                final id = await dbhelper.insert(row);
                              } catch (e) {
                                print("error in db $e");
                              }
                            } else {
                              final list = await dbhelper.update(
                                  widget.item!.id!,
                                  name,
                                  email,
                                  mobile,
                                  experience,
                                  education,
                                  project);
                            }
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Center(
                            child: Text(
                              'Submit Button',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Container(
                      height: 50,
                      width: 120,
                      margin: const EdgeInsets.only(
                        left: 40,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                        color: Colors.teal,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Center(
                            child: Text(
                              'Cancel Button',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  menuItem(
    String title,
    String text,
    TextEditingController,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Center(
            child: TextField(
              controller: TextEditingController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent)),
                labelText: title,
                hintText: text,

                // hintText: text,
              ),
            ),
          ),
        )
      ],
    );
  }
}
