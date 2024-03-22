import 'package:flutter/material.dart';
import 'package:new_todo_app/main.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Username & Password Map
  Map<String, String> uNamePassMap = {"Vishal": "Mahajan"};

  //KEYS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //CONTROLLERS
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //METHODS
  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {});
    _passwordController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
          style: GoogleFonts.quicksand(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff6F51FF),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset('assets/image.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(
                      'Username',
                      style: GoogleFonts.quicksand(),
                    ),
                    hintText: 'Enter username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text(
                      'Password',
                      style: GoogleFonts.quicksand(),
                    ),
                    hintText: 'Enter password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool validated = _formKey.currentState!.validate();
                      if (validated) {
                        if (_passwordController.text ==
                            uNamePassMap[_usernameController.text]) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ToDoNew();
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Successful'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid credentials'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('invalid Data'),
                              backgroundColor: Colors.red),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff6F51FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.quicksand(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
