import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25 ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Privacy policy-rafiki.png',
                  width: 250,
                  height: 250,
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
                const SizedBox(
                  height: 30,
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
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 15
                              ),
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
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 15
                              ),
                              hintText: "Enter Password",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.key_outlined),
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
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Get.snackbar(
                          "Logged In", "Welcome Back {User}!",
                          duration: Duration(seconds: 1),
                          colorText: Colors.white,
                          backgroundColor: Colors.green
                          );
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text("Login")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
