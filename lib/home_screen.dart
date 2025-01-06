import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
      ),
      body: SingleChildScrollView(
        child: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todoProvider.tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        todoProvider.tasks[index].title,
                      ),
                      leading: Checkbox(
                        value: todoProvider.tasks[index].isCompleted,
                        onChanged: (_) {
                          todoProvider
                              .isTaskCompleted(todoProvider.tasks[index].id);
                        },
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          todoProvider.deleteTodo(todoProvider.tasks[index].id);
                        },
                        child: Icon(Icons.delete),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: todoProvider.newTaskTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Add Todo task",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        todoProvider.addTodo(todoProvider.newTaskTitle.text);
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
