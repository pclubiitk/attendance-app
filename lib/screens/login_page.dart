import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const test1 = Key('Test1');
const test2 = Key('Test2');
const test3 = Key('Test3');
const test4 = Key('Test4');

class _LoginPageState extends State<LoginPage> {
  var size, height, width;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Privacy policy-rafiki.png',
                  width: double.infinity,
                  height: height / 3,
                ),
                // const SizedBox(
                //   height: 25,
                // ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 32, 146, 238)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Login to your account!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 20,
                ),
                Container(
                  // height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          key: test1,
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              
                              hintText: "Enter User ID",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.perm_identity_rounded),
                            ),
                            controller: userIdController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Container(
                  // height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          key: test2,
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              hintText: "Enter Password",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.key_outlined),
                            ),
                            controller: passwordController,
                             obscureText: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: height / 20,
                ),
                SizedBox(
                  key: test3,
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                     //onPressed:_loginUser,
                      onPressed:(){
                        Get.snackbar("Logged In", "Welcome Back {User}!",
                            duration: const Duration(seconds: 1),
                            colorText: Colors.white,
                            backgroundColor: Colors.green);
                        Navigator.pushNamed(context, '/userDashboard');
                      },
                      child: const Text("Login")),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  key: test4,
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.blueAccent[100],
                          // foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text("New User ? Register")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// Function to handle the login process
  void _loginUser() async {
    String userId = userIdController.text;
    String password = passwordController.text;

    if (userId.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter both User ID and Password",
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }

    try {
      // Replace with your actual API endpoint
      final response = await http.post(
        Uri.parse('http://localhost:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'employee_id': userId,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {  
        final responseData = jsonDecode(response.body);
        String token = responseData['token'];

        // Decode token and navigate based on role
        _navigateBasedOnRole(token);
      } else {
        Get.snackbar("Error", "Invalid login credentials",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred during login",
          colorText: Colors.white, backgroundColor: Color.fromARGB(255, 244, 130, 54));
    }
  }

  // Function to navigate based on user role
  void _navigateBasedOnRole(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String role = decodedToken['user']['role'];

    if (role == 'ADMIN') {
      Get.toNamed('/adminDashboard');
    } else if (role == 'USER') {
      Get.toNamed('/userDashboard');
    } else {
      Get.snackbar("Error", "Unknown user role",
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
}