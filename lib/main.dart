import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB29470),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const ToDoHome(),
    );
  }
}

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  final TextEditingController _taskController = TextEditingController();
  final List<Map<String, dynamic>> _tasks = []; // Menyimpan daftar tugas

  // Menyimpan teks yang diketik (onChanged)
  String _typedTask = '';

  void _addTask() {
    if (_typedTask.isEmpty) return;

    setState(() {
      _tasks.add({
        'title': _typedTask,
        'isDone': false,
      });
      _typedTask = '';
      _taskController.clear();
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB29470),
        title: const Text(
          'Mini To-Do List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Input area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    onChanged: (value) => setState(() => _typedTask = value),
                    decoration: InputDecoration(
                      hintText: 'Masukkan tugas...',
                      filled: true,
                      fillColor: const Color(0xFFFFF5E4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB29470),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),

          // Daftar tugas dinamis
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada tugas',
                      style: TextStyle(
                        color: Color(0xFF8B7355),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return GestureDetector(
                        onTap: () => _toggleTaskStatus(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: task['isDone']
                                ? const Color(0xFFE2D5C0)
                                : const Color(0xFFFFF5E4),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  task['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: task['isDone']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: task['isDone']
                                        ? Colors.grey
                                        : const Color(0xFF5C4033),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _deleteTask(index),
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Color(0xFFB29470),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
