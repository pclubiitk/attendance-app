import 'package:attendance_app/services/store.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({
    super.key,
  });
  final TokenService _tokenService = TokenService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _tokenService.getDecodedToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text("Failed to load profile"));
        }
        final decodedToken = snapshot.data!;
        final String name = decodedToken['user']['name'] ?? 'Unknown';
        final String role = decodedToken['user']['position'] ?? 'User';
        final String imageUrl = decodedToken['user']['imageUrl'] ?? '';

        return SizedBox(
          // width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8.0),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : const AssetImage('assets/profileimg.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[800],
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
