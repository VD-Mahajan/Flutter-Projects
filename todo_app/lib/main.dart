import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});
  @override
  State createState() => _MyclassState();
}

class NewTask {
  String? title;
  String? description;
  String? date;
  NewTask({this.title, this.description, this.date});
}

class _MyclassState extends State {
  List<Color> colors = [
    const Color(0xFFFAE8E8),
    const Color(0xFFE8EDFA),
    const Color(0xFFFAF9E8),
    const Color(0xFFFAE8FA),
  ];

  List list = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  Color color = const Color(0xFF02A7B1);

  void submit(bool doEdit, [NewTask? obj]) {
    if (doEdit) {
      setState(() {
        obj!.title = _titleController.text;
        obj.description = _descriptionController.text;
        obj.date = _dateController.text;
      });
    } else {
      setState(() {
        list.add(
          NewTask(
            title: _titleController.text,
            description: _descriptionController.text,
            date: _dateController.text,
          ),
        );
      });
    }
    Navigator.pop(context);
    clearControllers();
  }

  void editTask(NewTask obj) {
    setState(() {
      _titleController.text = obj.title!;
      _descriptionController.text = obj.description!;
      _dateController.text = obj.date!;
    });
    myBottomSheet(true, obj);
  }

  void clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    String formattedDate = DateFormat.yMMMd().format(pickedDate!);

    setState(() {
      _dateController.text = formattedDate;
    });
  }

  myBottomSheet(bool doEdit, [NewTask? obj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Create Task',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title',
                                style: TextStyle(color: color),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: color,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                  left: 10,
                                ),
                                child: TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(color: color),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: color,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                  left: 10,
                                ),
                                child: TextField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Date',
                                style: TextStyle(color: color),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: color,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                  left: 10,
                                ),
                                child: TextField(
                                  controller: _dateController,
                                  readOnly: true,
                                  onTap: () => pickDate(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        pickDate();
                                      },
                                      icon:
                                          const Icon(Icons.date_range_outlined),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_titleController.text
                                              .trim()
                                              .isNotEmpty &&
                                          _descriptionController.text
                                              .trim()
                                              .isNotEmpty &&
                                          _dateController.text
                                              .trim()
                                              .isNotEmpty) {
                                        if (doEdit) {
                                          submit(doEdit, obj);
                                        } else {
                                          submit(doEdit);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: color,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: color,
      ),
      body: ListView.builder(
        physics: (list.length > 4)
            ? const BouncingScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              margin: const EdgeInsets.only(top: 30),
              elevation: 10,
              shadowColor: colors[(index % colors.length)],
              child: Container(
                height: 150,
                width: 370,
                decoration: BoxDecoration(
                  color: colors[(index % colors.length)],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            right: 10,
                          ),
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(52),
                            color: Colors.white,
                            image: const DecorationImage(
                                image: AssetImage('assets/logo2.png')),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Text(
                            list[index].date,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 260,
                          child: Text(
                            list[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          width: 260,
                          child: Text(
                            list[index].description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const SizedBox(
                              width: 210,
                            ),
                            GestureDetector(
                              onTap: () {
                                editTask(list[index]);
                              },
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 20,
                                color: Color(0xFF008B94),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  list.removeAt(index);
                                });
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: Color(0xFF008B94),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        shape: const CircleBorder(),
        onPressed: () {
          clearControllers();
          myBottomSheet(false);
        },
        tooltip: 'Add new task',
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
