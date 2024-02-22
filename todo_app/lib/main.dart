import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDo(),
    );
  }
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});
  @override
  State createState() => _MyclassState();
}

class NewTask {
  final String title;
  final String description;
  final String date;
  const NewTask(this.title, this.description, this.date);
}

class _MyclassState extends State {
  List<Color> colors = [
    const Color(0xFFFAE8E8),
    const Color(0xFFE8EDFA),
    const Color(0xFFFAF9E8),
    const Color(0xFFFAE8FA),
  ];

  List list = [];

  Color color = const Color(0xFF02A7B1);
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _dateController = TextEditingController();
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
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              height: 112,
              width: 330,
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
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.image),
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
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        // margin: EdgeInsets.symmetric(vertical: 5),
                        width: 243,
                        height: 15,
                        child: Text(
                          list[index].title,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 243,
                        height: 44,
                        child: Text(
                          list[index].description,
                          maxLines: 4,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 200,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 18,
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
                              size: 18,
                              color: Color(0xFF008B94),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListView(
                  children: [
                    SizedBox(
                      height: 400,
                      width: 410,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Create Task',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: SizedBox(
                              width: 330,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
                                    style: TextStyle(color: color),
                                  ),
                                  Container(
                                    height: 40,
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
                                    height: 72,
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
                                      keyboardType: TextInputType.text,
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
                                    height: 40,
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
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.date_range_outlined),
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
                                          if (_titleController
                                                  .text.isNotEmpty &&
                                              _descriptionController
                                                  .text.isNotEmpty &&
                                              _dateController.text.isNotEmpty &&
                                              _dateController.text.length <=
                                                  10) {
                                            setState(() {
                                              list.add(
                                                NewTask(
                                                    _titleController.text,
                                                    _descriptionController.text,
                                                    _dateController.text),
                                              );
                                            });
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        tooltip: 'Add new task',
      ),
    );
  }
}
