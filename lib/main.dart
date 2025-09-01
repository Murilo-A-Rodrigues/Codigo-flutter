import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Um modelo simples para representar uma tarefa
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Agora usamos uma lista de objetos Task
  final List<Task> _tasks = [
    Task(title: 'Estudar Flutter', isDone: true),
    Task(title: 'Ler documentação'),
    Task(title: 'Praticar layouts'),
  ];

  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _tasks.add(Task(title: text));
    });
    _controller.clear();
    FocusScope.of(context).unfocus(); // Esconde o teclado
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Flutter - Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Digite uma nova tarefa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // Usamos ListView.separated para adicionar um espaço entre os itens
              child: ListView.separated(
                itemCount: _tasks.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  // Dismissible permite deslizar para excluir
                  return Dismissible(
                    key: Key(task.title + index.toString()), // Chave única para o widget
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _removeTask(index);
                      // Mostra um feedback visual rápido
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${task.title} removida!')),
                      );
                    },
                    background: Container(
                      color: Colors.red[400],
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete_sweep, color: Colors.white),
                      // Usando o mesmo borderRadius do Card
                      // NOTA: Para um efeito visual melhor, o borderRadius deveria estar no Card/ListTile,
                      // mas para simplicidade, a cor de fundo já ajuda.
                    ),
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        // Checkbox para marcar como concluída
                        leading: Checkbox(
                          value: task.isDone,
                          onChanged: (bool? value) {
                            _toggleTaskStatus(index);
                          },
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: task.isDone ? Colors.grey : Colors.indigo[900],
                            // Adiciona um risco no texto se a tarefa estiver concluída
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}