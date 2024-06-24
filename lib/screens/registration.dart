import 'package:flutter/material.dart';

// registration page starts

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();

  void _nextPage() {
    if (_formKey.currentState?.validate() ?? false) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _submit() {
    // submission logic here
    // upload the data and the captured picture
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _employeeIdController,
                    decoration: const InputDecoration(labelText: 'Employee ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Employee ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Age';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _positionController,
                    decoration: const InputDecoration(labelText: 'Position'),
                  ),
                  TextFormField(
                    controller: _bloodGroupController,
                    decoration: const InputDecoration(labelText: 'Blood Group'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _nextPage,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Capture Your Picture',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Capture Picture'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// registration page ends