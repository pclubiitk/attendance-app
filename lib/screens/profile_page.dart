import 'package:flutter/material.dart';

// profile profile page starts

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resource Manager',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ProfileImage(),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: ProfileDetails(),
                  ),
                ],
              ),
            );
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileImage(),
                    SizedBox(height: 24),
                    ProfileDetails(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width * 0.25,
      backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileField(title: 'Name', value: 'Ram Krishna'),
        const ProfileField(title: 'Age', value: '48'),
        const ProfileField(title: 'Position', value: 'Sub Inspector'),
        const ProfileField(title: 'Blood Group', value: 'O+'),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Mark Attendance'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Provide Location'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileField extends StatelessWidget {
  final String title;
  final String value;

  const ProfileField({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

// profile profile page ends
