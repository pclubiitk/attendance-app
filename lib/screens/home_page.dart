import 'package:attendance_app/screens/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text("Home"),
      ),
      drawer: const Drawer(child: DrawerItems()),
      body: Scaffold(
        // appBar: ,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/register');
              }, 
              child: Text("Back to inital"))
          ],
        ),
        ),
    );
  }
}