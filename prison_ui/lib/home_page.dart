import 'package:flutter/material.dart';
import 'package:prison_ui/book_a_visit.dart';
import 'package:prison_ui/complaints.dart';
import 'package:prison_ui/lawyers.dart';
import 'package:prison_ui/notifications.dart';

import 'models/user.dart';

class HomePage extends StatelessWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.orangeAccent,
                elevation: 10,
                minimumSize: const Size(300,
                    50), // Set width and height (e.g., 300px wide and 50px tall)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LawyersPage()),
                );
              },
              child: const Text(
                "Lawyers",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.orangeAccent,
                elevation: 10,
                minimumSize: const Size(300,
                    50), // Set width and height (e.g., 300px wide and 50px tall)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookAVisitForm(
                            user: user,
                          )),
                );
              },
              child: const Text(
                "Book A Visit",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.orangeAccent,
                elevation: 10,
                minimumSize: const Size(300,
                    50), // Set width and height (e.g., 300px wide and 50px tall)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationPage(user: user)),
                );
              },
              child: const Text(
                "Notifications",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                backgroundColor: Colors.orangeAccent,
                elevation: 10,
                minimumSize: const Size(300,
                    50), // Set width and height (e.g., 300px wide and 50px tall)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComplaintsForm(user: user)),
                );
              },
              child: const Text(
                "Complaints",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
