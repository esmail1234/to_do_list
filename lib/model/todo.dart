class ToDO {
  String? id;

  String? todoText;

  bool isDone;

  ToDO({required this.id, required this.todoText, this.isDone = false});

  static List<ToDO> todoList() {
    return [
      ToDO(id: '1', todoText: "Go to gym"),
      ToDO(id: '2', todoText: "Buy bread"),
      ToDO(id: '3', todoText: "Buy meat"),
      ToDO(id: '4', todoText: "visit museum"),
      ToDO(id: '5', todoText: "study lesson"),

    ];
  }
}
