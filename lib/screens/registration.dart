import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:attendance_app/screens/capturepic.dart';

// registration page starts

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var size, height, width;
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  TextEditingController _employeeIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      bool _error = false;

      // Access form values
      String name = _nameController.text.trim();
      String position = _positionController.text.trim();
      int employeeId = int.parse(_employeeIdController.text.trim());
      String password = _passwordController.text.trim();

      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/user/register'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'role': "USER",
            'employee_id': employeeId,
            'name': name,
            'position': position,
            'password': password
          }),
        );
        if (response.statusCode == 200) {
          Get.snackbar(
              "Profile Add successfully", "Please Provide Picture Next",
              colorText: Colors.white, backgroundColor: Colors.green);
        } else {
          final responseData = jsonDecode(response.body);
          Get.snackbar("Error", responseData["msg"],
              colorText: Colors.white, backgroundColor: Colors.red);
          _error = true;
        }
      } catch (e) {
        print(e);
        Get.snackbar("Error", "An error occurred, please try again",
            colorText: Colors.white, backgroundColor: Colors.red);
        _error = true;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
      if (_error) {
        return;
      }
      await Navigator.pushNamed(context, '/picture');

      /// TODO: upload the picture here next, need to implement the picture upload
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/Police car-rafiki.png",
                        height: height / 3,
                        width: double.infinity,
                      ),
                      const Text(
                        "Register Here!",
                        style: TextStyle(
                            fontFamily: "OpenSans-VariableFont_wdth,wght",
                            color: Color.fromARGB(221, 48, 124, 244),
                            fontSize: 32,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("Register Now for Our Facial Attendance App"),
                      SizedBox(
                        height: height / 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.grey[100],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Employee ID';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Employee ID must be a number';
                            }
                            return null;
                          },
                          controller: _employeeIdController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Employee ID',
                              contentPadding: EdgeInsets.all(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.grey[100],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Full Name',
                              contentPadding: EdgeInsets.all(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                  color: Colors.grey[100],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Text(
                                  'USER',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 228, 112, 112),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                  color: Colors.grey[100],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your position';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Position',
                                    contentPadding: EdgeInsets.all(10)),
                                controller: _positionController,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Password
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.grey[100],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Enter Password",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.key_outlined),
                                      contentPadding: EdgeInsets.all(10)),
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: _submit,
                          child: const Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                height: height,
                width: width,
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
