import 'package:flutter/material.dart';
import 'package:to_do_list/constants/colors.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/widget/to_do_item_list.dart';

class Home extends StatefulWidget {
  Home({super.key});

  final List<ToDO> todoList = ToDO.todoList();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDO> _foundToDO = [];
  final TextEditingController _toDoController = TextEditingController();

  @override
  void initState() {
    _foundToDO = widget.todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                _boxSearch(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50, bottom: 25),
                        child: const Text(
                          "All To Do",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      for (ToDO todoo in _foundToDO)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _handleDeleteItem,
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 20,
                                  right: 20,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextField(
                                  controller: _toDoController,
                                  decoration: const InputDecoration(
                                    hintText: "Add a new todo item",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                right: 20,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addToDoItem(_toDoController.text);
                                  _toDoController.clear();
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(60, 60),
                                  elevation: 10,
                                ),
                                child: const Text(
                                  '+',
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDO todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteItem(String id) {
    setState(() {
      widget.todoList.removeWhere((item) => item.id == id);
    });
    _runFilter("");
  }

  void _addToDoItem(String todo) {
    if (todo.trim().isEmpty) return;

    setState(() {
      widget.todoList.add(
        ToDO(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
        ),
      );
    });

    _runFilter("");
  }

  void _runFilter(String enteredKeyword) {
    List<ToDO> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.todoList;
    } else {
      results = widget.todoList
          .where((item) =>
          item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDO = results;
    });
  }

  Widget _boxSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 30,
            maxWidth: 25,
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: tdGrey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: tdBlack, size: 30),
          Container(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('images/esmail.jpg', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
