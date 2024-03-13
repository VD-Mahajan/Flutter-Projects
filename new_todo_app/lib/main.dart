import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'todotask.dart';

dynamic database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), 'ToDoTask.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE TASK(taskId INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,date TEXT,taskDone INT)''',
      );
    },
  );
  runApp(const MainApp());
  // print('App started');
  // await dropDatabase();
}

// dropDatabase() async {
//   String path = join(await getDatabasesPath(), 'ToDoTask.db');
//   bool exist = await databaseExists(path);

//   if (exist) {
//     await deleteDatabase(path);
//     print("database dropped successfully");
//   } else {
//     print("Database not exist");
//   }
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoNew(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future insertData(ToDoTask taskObj) async {
  final localDB = await database;
  await localDB.insert(
    "TASK",
    taskObj.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<ToDoTask>> getTaskData() async {
  final localDB = await database;
  List taskList = await localDB.query("TASK");

  return List.generate(
    taskList.length,
    (index) {
      return ToDoTask.fromDB(
        taskId: taskList[index]['taskId'],
        title: taskList[index]['title'],
        description: taskList[index]['description'],
        date: taskList[index]['date'],
        taskDone: taskList[index]['taskDone'],
      );
    },
  );
}

void deleteTask(ToDoTask todoTaskObj) async {
  final localDB = await database;

  await localDB.delete(
    "TASK",
    where: "taskId=?",
    whereArgs: [todoTaskObj.taskId],
  );
}

Future updateTask(ToDoTask obj, [int? taskDone]) async {
  final localDB = await database;
  if (taskDone != null) {
    await localDB.update(
      'TASK',
      obj.toMap(),
      where: "taskId=?",
      whereArgs: [obj.taskId],
    );
  } else {
    await localDB.update(
      'TASK',
      obj.toMap(),
      where: "taskId=?",
      whereArgs: [obj.taskId],
    );
  }
}

class ToDoNew extends StatefulWidget {
  const ToDoNew({super.key});
  @override
  State createState() => _ToDoNewState();
}

class _ToDoNewState extends State {
  //CONTROLLERS
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  //LIST
  List toDoList = [];

  //KEYS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //METHODS
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List newToDoList = await getTaskData();
    setState(() {
      toDoList = newToDoList;
    });
  }

  void clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  void datePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    String formattedDate = DateFormat.yMMMd().format(pickedDate!);

    setState(() {
      _dateController.text = formattedDate;
    });
  }

  void editTask(ToDoTask obj) {
    displayBottomSheet(obj);
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
                            return Slidable(
                              direction: Axis.horizontal,
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                extentRatio: 0.2,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            editTask(toDoList[index]);
                                            fetchData();
                                          },
                                          icon: Icons.edit_outlined,
                                          foregroundColor:
                                              const Color(0xff6F51FF),
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            deleteTask(toDoList[index]);
                                            fetchData();
                                          },
                                          icon: Icons.delete_outline,
                                          foregroundColor:
                                              const Color(0xff6F51FF),
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                      color: Color(0xffD9D9D9),
                                      // offset: Offset(0, 10),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              padding:
                                                  const EdgeInsets.all(15.0),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5.0,
                                                  ),
                                                  child: Text(
                                                    toDoList[index].title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  toDoList[index].description,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                              ),
                                              child: Text(toDoList[index].date),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: IconButton(
                                            onPressed: () async {
                                              if (toDoList[index].taskDone ==
                                                  0) {
                                                setState(() {
                                                  toDoList[index].taskDone = 1;
                                                });
                                              } else {
                                                setState(() {
                                                  toDoList[index].taskDone = 0;
                                                });
                                              }
                                              await updateTask(
                                                  toDoList[index], 0);
                                            },
                                            icon:
                                                (toDoList[index].taskDone == 0)
                                                    ? const Icon(
                                                        Icons
                                                            .check_circle_outline_outlined,
                                                        color: Colors.grey,
                                                      )
                                                    : const Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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

  displayBottomSheet([ToDoTask? obj]) {
    int? taskId;
    if (obj != null) {
      setState(() {
        taskId = obj.taskId;
        _titleController.text = obj.title;
        _descriptionController.text = obj.description;
        _dateController.text = obj.date;
      });
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: this.context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    'Create To-Do',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
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
                            return null;
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
                            return null;
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
                              return null;
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
                  onPressed: () async {
                    bool taskUpdated = _formKey.currentState!.validate();
                    if (taskUpdated) {
                      if (obj == null) {
                        await insertData(
                          ToDoTask(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: _dateController.text,
                            taskDone: 0,
                          ),
                        );
                      } else {
                        await updateTask(
                          ToDoTask.fromDB(
                            taskId: taskId,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: _dateController.text,
                            taskDone: obj.taskDone,
                          ),
                          taskId!,
                        );
                      }
                      fetchData();

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
