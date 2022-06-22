class ToDoItem {
  
  final String id;
  final String description;
  final bool isActive;

  ToDoItem({this.description = "", this.isActive = false, this.id = ""});

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      id: json["id"],
      description: json["description"],
      isActive: json["isActive"]
    );
  }

}