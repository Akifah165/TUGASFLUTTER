import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List Interaktif")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input teks
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Ketik tugas baru...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                Provider.of<TodoProvider>(context, listen: false)
                    .addTodo(controller.text);
                controller.clear();
              },
              icon: const Icon(Icons.add),
              label: const Text("Tambah Tugas"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // List tugas
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, provider, child) {
                  final todos = provider.todos;
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text(
                        "Belum ada tugas.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final item = todos[index];
                      return GestureDetector(
                        onTap: () => provider.toggleDone(index),
                        child: Card(
                          elevation: 3,
                          color: item["done"]
                              ? Colors.green[100]
                              : Colors.white,
                          child: ListTile(
                            title: Text(
                              item["task"],
                              style: TextStyle(
                                decoration: item["done"]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: item["done"]
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            trailing: Icon(
                              item["done"]
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: item["done"]
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
