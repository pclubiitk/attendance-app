import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:attendance_app/services/store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var size, height, width;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  final TokenService _tokenService = TokenService();

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
        child: Stack(children: [
          SingleChildScrollView(
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
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 15),
                                hintText: "Enter Employee Id",
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
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
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
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: _loginUser,
                        child: const Text("Login")),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
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
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ]),
      ),
    );
  }

// Function to handle the login process
  void _loginUser() async {
    setState(() {
      _isLoading = true;
    });

    int userId = int.parse(userIdController.text);
    String password = passwordController.text;

    if (userId == null || password.isEmpty || userId.isLowerThan(1)) {
      Get.snackbar("Error", "Please enter valid Employee Id and Password",
          colorText: Colors.white, backgroundColor: Colors.red);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Make API call to login user
    try {
      // Replace with your actual API endpoint
      final response = await http.post(
        Uri.parse('http://localhost:3000/user/login'),
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
      } else if (response.statusCode == 404) {
        Get.snackbar("Error: No user found", "Please Check Employee Id",
            colorText: Colors.white, backgroundColor: Colors.red);
      } else if (response.statusCode == 400) {
        Get.snackbar("Error: Invalid Password", "Please try again",
            colorText: Colors.white, backgroundColor: Colors.red);
      } else if (response.statusCode == 500) {
        Get.snackbar("Sorry!", "Server Error, Please Try Again Later",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Something went wrong", "Please Try Again Later",
          colorText: Colors.white, backgroundColor: Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to navigate based on user role
  void _navigateBasedOnRole(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String role = decodedToken['user']['role'];
    _tokenService.saveToken(token);
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
