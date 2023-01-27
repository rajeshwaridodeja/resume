import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume/final_Resume.dart';

class Change_List extends StatefulWidget {
  const Change_List({Key? key, required this.data}) : super(key: key);

  final List data;

  @override
  State<Change_List> createState() => _Change_ListState();
}

class _Change_ListState extends State<Change_List> {
  List<Widget> myTilest = [
    Padding(
      key: ValueKey("Name"),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: ListTile(
          title: Text("Name".toString()),
        ),
      ),
    ),
    Padding(
      key: ValueKey("Email"),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: ListTile(
          title: Text("Email".toString()),
        ),
      ),
    ),
    Padding(
      key: ValueKey("Mobile No."),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: ListTile(
          title: Text("Mobile No.".toString()),
        ),
      ),
    ),
    Padding(
      key: ValueKey("Experience"),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: ListTile(
          title: Text("Experience".toString()),
        ),
      ),
    ),
    Padding(
      key: ValueKey("Education"),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: ListTile(
          title: Text("Education ".toString()),
        ),
      ),
    ),
    Padding(
      key: ValueKey("Project"),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: ListTile(
          title: Text("Project".toString()),
        ),
      ),
    ),
  ];

  List myTiles = [
    "Name",
    "Email",
    "Mobile",
    "Experience",
    "Education",
    "Project",
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      myTiles = widget.data;
    });
  }

  // reorder method
  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      // this adjustment is needed when moving down the list
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      // get the tile we are moving
      final String tile = myTiles.removeAt(oldIndex);
      // place the tile in new position
      myTiles.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              print("clicked: $myTiles");

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Final_Resume(
                      myTitle: myTiles,
                    ),
                  ));
            },
          )
        ],
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(10),
        children: [
          for (final tile in myTiles)
            Padding(
              key: ValueKey(tile),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(tile.toString()),
                ),
              ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          updateMyTiles(oldIndex, newIndex);
        },
      ),
    );
  }
}
