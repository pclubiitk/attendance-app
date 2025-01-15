import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:forui/forui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _employeeId = 'SI-1998-9456UP';
  String _fullName = 'RAM KRISHNA';
  String _age = '45';
  String _position = 'SUB INSPECTOR';
  String _profileImageUrl = 'assets/profileimg.png';

  void _editProfile() async {
    final result = await showDialog(
      context: context,
      builder: (context) => EditProfileDialog(
        employeeId: _employeeId,
        fullName: _fullName,
        age: _age,
        position: _position,
        profileImageUrl: _profileImageUrl,
      ),
    );

    if (result != null) {
      setState(() {
        _employeeId = result['employeeId'];
        _fullName = result['fullName'];
        _age = result['age'];
        _position = result['position'];
        _profileImageUrl = result['profileImageUrl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var bannerHeight = height / 4 - height / 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("PROFILE"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF407BFE),
                Color.fromARGB(255, 123, 160, 253),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: BackgroundWaveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.3, 0.98],
                    colors: [
                      Color(0xFF407BFE),
                      Color.fromARGB(255, 123, 160, 253),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: .1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(137, 117, 117, 117),
                      spreadRadius: 1,
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: bannerHeight / 2.5),
                    Positioned(
                      top: bannerHeight * 0.8,
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 7, 114, 254),
                        radius: bannerHeight / 2.5 + 3,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: bannerHeight / 2.5,
                          backgroundImage: AssetImage(_profileImageUrl),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 38,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Employee ID",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _employeeId,
                                  hintStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Full Name",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _fullName,
                                  hintStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Age",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: TextField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: _age,
                                            hintStyle: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Position",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: TextField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: _position,
                                            hintStyle: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class EditProfileDialog extends StatefulWidget {
  final String employeeId;
  final String fullName;
  final String age;
  final String position;
  final String profileImageUrl;

  const EditProfileDialog({
    required this.employeeId,
    required this.fullName,
    required this.age,
    required this.position,
    required this.profileImageUrl,
    super.key,
  });

  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _employeeIdController;
  late TextEditingController _fullNameController;
  late TextEditingController _ageController;
  late TextEditingController _positionController;
  String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _employeeIdController = TextEditingController(text: widget.employeeId);
    _fullNameController = TextEditingController(text: widget.fullName);
    _ageController = TextEditingController(text: widget.age);
    _positionController = TextEditingController(text: widget.position);
    _profileImageUrl = widget.profileImageUrl;
  }

  void _uploadImage() async {
    // Implement image upload logic here
    // For now, we'll just set a dummy image URL
    setState(() {
      _profileImageUrl = 'assets/profile2.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Customize the dialog theme
        colorScheme: ColorScheme.light(
          primary: Colors.black, // Primary color
          onPrimary: Colors.white, // Text color on primary
          surface: Colors.white, // Background color
          onSurface: Colors.black, // Text color
          secondary: Colors.black.withOpacity(0.5), // Secondary color
          background: Colors.white, // Background color
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, // Button text color
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // Dialog background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rounded input fields
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
          labelStyle: const TextStyle(color: Colors.black), // Label text color
        ),
      ),
      child: AlertDialog(
        title: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(_profileImageUrl),
              ),
              TextButton(
                onPressed: _uploadImage,
                child: const Text('Upload Image', style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _employeeIdController,
                decoration: const InputDecoration(labelText: 'Employee ID'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                'employeeId': _employeeIdController.text,
                'fullName': _fullNameController.text,
                'age': _ageController.text,
                'position': _positionController.text,
                'profileImageUrl': _profileImageUrl,
              });
            },
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final p0 = size.height * 0.75;
    path.lineTo(0.0, p0);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, size.height / 2);
    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}