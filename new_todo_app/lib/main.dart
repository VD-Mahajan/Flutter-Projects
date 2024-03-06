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
      home: ToDoNew(),
    );
  }
}

class ToDoNew extends StatefulWidget {
  const ToDoNew({super.key});
  @override
  State createState() => _ToDoNewState();
}

class ToDoTask {
  final String title;
  final String description;
  final String date;
  const ToDoTask(
      {required this.title, required this.description, required this.date});
}

class _ToDoNewState extends State {
  List toDoList = [
    const ToDoTask(
      title: "This is my first title",
      description: "This is my first description",
      date: "10 july 2024",
    ),
    const ToDoTask(
      title: "This is my second title",
      description: "This is my second description",
      date: "10 july 2025",
    ),
    const ToDoTask(
      title: "This is my first title",
      description: "This is my first description",
      date: "10 july 2024",
    ),
    const ToDoTask(
      title: "This is my second title",
      description: "This is my second description",
      date: "10 july 2025",
    ),
    const ToDoTask(
      title: "This is my first title",
      description: "This is my first description",
      date: "10 july 2024",
    ),
    const ToDoTask(
      title: "This is my second title",
      description: "This is my second description",
      date: "10 july 2025",
    ),
  ];

  //VARIABLES
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  void datePicker() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6F51FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 45,
              horizontal: 29,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Vishal Mahajan",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color(0xffD9D9D9),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "CREATE TO DO LIST",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: ListView.builder(
                          itemCount: toDoList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 7,
                              ),
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Color(0xffD9D9D9),
                                    offset: Offset(10, 10),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 30,
                                        ),
                                        child: Container(
                                          height: 62,
                                          width: 62,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(62),
                                            color: const Color(0xffD9D9D9),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Image.asset(
                                              'assets/image.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 110,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                ),
                                                child: Text(
                                                  toDoList[index].title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                toDoList[index].description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(toDoList[index].date),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Icon(
                                          Icons.task_alt,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6F51FF),
        shape: const CircleBorder(),
        onPressed: () {
          clearControllers();
          displayBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }

  displayBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            // padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text('Create To-Do'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Title'),
                      TextFormField(
                        controller: _titleController,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff6F51FF)),
                          ),
                          // enabled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xff6F51FF),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please add Title";
                          } else {
                            null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Description'),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff6F51FF)),
                          ),
                          // enabled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xff6F51FF),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please add Description";
                          } else {
                            null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Date'),
                      GestureDetector(
                        child: TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () {
                            datePicker();
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xff6F51FF)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xff6F51FF),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                datePicker();
                              },
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please select Date";
                            } else {
                              null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    bool taskUpdated = _formKey.currentState!.validate();
                    if (taskUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Task updated"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6F51FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(300, 50),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
