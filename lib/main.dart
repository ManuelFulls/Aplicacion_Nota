import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nota/colors/colores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas App',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 250.0,
              child: Image.asset('assets/2Inicio.png'),
            ),
            const Text(
              "Inicia Creando tus Notas",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w900,
                color: primaryColor,
              ),
            ),
            const Text(
              "Personaliza tus notas, realiza recordatorios para eventos, citas y mucho más ¡Todo en un solo lugar!",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50.0),
            SizedBox(
              width: 166.0,
              height: 44.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EscribeYaScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text(
                  "¡EscribeYa!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text("Política de Privacidad"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text("Términos y condiciones"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Note {
  String title;
  String content;
  DateTime date;
  DateTime deliveryDate;

  Note({
    required this.title,
    required this.content,
    required this.date,
    required this.deliveryDate,
  });
}

class EscribeYaScreen extends StatefulWidget {
  const EscribeYaScreen({super.key});

  @override
  _EscribeYaScreenState createState() => _EscribeYaScreenState();
}

class _EscribeYaScreenState extends State<EscribeYaScreen> {
  final List<Note> notes = [];

  void _addNote(String title, String content, DateTime deliveryDate) {
    final newNote = Note(
      title: title,
      content: content,
      date: DateTime.now(),
      deliveryDate: deliveryDate,
    );
    setState(() {
      notes.add(newNote);
    });
  }

  void _editNote(
      int index, String newTitle, String newContent, DateTime newDeliveryDate) {
    setState(() {
      notes[index].title = newTitle;
      notes[index].content = newContent;
      notes[index].deliveryDate = newDeliveryDate;
    });
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _showAddNoteDialog() {
    String title = '';
    String content = '';
    DateTime deliveryDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nueva Nota"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Título"),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Contenido"),
                  onChanged: (value) {
                    content = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Fecha de entrega (dd/MM/yyyy)"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: deliveryDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        deliveryDate = pickedDate;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: DateFormat('dd/MM/yyyy').format(deliveryDate),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  _addNote(title, content, deliveryDate);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(int index) {
    String title = notes[index].title;
    String content = notes[index].content;
    DateTime deliveryDate = notes[index].deliveryDate;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Nota"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Título"),
                  controller: TextEditingController(text: title),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Contenido"),
                  controller: TextEditingController(text: content),
                  onChanged: (value) {
                    content = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Fecha de entrega (dd/MM/yyyy)"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: deliveryDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        deliveryDate = pickedDate;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: DateFormat('dd/MM/yyyy').format(deliveryDate),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                _editNote(index, title, content, deliveryDate);
                Navigator.of(context).pop();
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "¡EscribeYA!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0077B6),
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return GestureDetector(
                onTap: () => _showEditNoteDialog(index),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0077B6),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          const Divider(color: Colors.white),
                          Text(
                            "${note.date.day}/${note.date.month}/${note.date.year}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            note.content,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Entregar: ${DateFormat('dd/MM/yyyy').format(note.deliveryDate)}",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 5.0,
                        right: 5.0,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteNote(index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: _showAddNoteDialog,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
