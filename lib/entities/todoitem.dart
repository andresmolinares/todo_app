class ToDoItem {
  
  final String description;
  final bool isActive;

  ToDoItem({this.description = "", this.isActive = false});

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      description: json["description"],
      isActive: json["isActive"]
    );
  }

}