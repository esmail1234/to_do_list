import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/colors.dart';
import 'package:to_do_list/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final onToDoChanged;
  final onDeleteItem;
  final ToDO todo;

  const ToDoItem({
    super.key,
    required this.todo,
    required this.onDeleteItem,
    required this.onToDoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) {
            onToDoChanged(todo);
          },
          activeColor: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id!);
            },
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
