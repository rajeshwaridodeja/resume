class Item {
  int? id;
  String? name;
  String? email;
  String? moblie;
  String? experience;
  String? education;
  String? project;

  Item({
    required this.id,
    required this.name,
    required this.email,
    required this.moblie,
    required this.experience,
    required this.education,
    required this.project,
  });

  Item.fromJson(Map<String, dynamic> row) {
    id = row["id"];
    name = row["name"];
    email = row["email"];
    moblie = row["moblie"];
    experience = row["experience"];
    education = row["education"];
    project = row["project"];
  }
}
