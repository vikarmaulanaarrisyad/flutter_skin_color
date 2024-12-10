import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            Text('Username',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('email@example.com', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text('Edit Profile')),
            ElevatedButton(
              onPressed: () {
                // Logika logout di sini
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
