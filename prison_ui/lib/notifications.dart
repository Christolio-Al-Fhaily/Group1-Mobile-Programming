import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prison_ui/models/notification.dart';

import 'models/user.dart';

class NotificationPage extends StatefulWidget {
  final User user;

  const NotificationPage({super.key, required this.user});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Notif> _notifications = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http
          .get(
            Uri.parse(
                '${dotenv.env['API_URL']!}/notifications/${widget.user.id}'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> notificationsAssoc = jsonDecode(response.body);
        List<Notif> notifications =
            notificationsAssoc.map((json) => Notif.fromMap(json)).toList();
        setState(() {
          _notifications.clear();
          _notifications.addAll(notifications);
        });
      } else {
        showMessageDialog("Failed to fetch notifications", response.body);
      }
    } on TimeoutException {
      showMessageDialog("Failed to fetch notifications", "Request timed out");
    } catch (error) {
      showMessageDialog("Failed to fetch notifications", error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _fetchNotifications,
                child: _notifications.isEmpty
                    ? ListView(
                        // Add ListView to allow RefreshIndicator to work
                        children: const [
                          Center(
                            child: Text(
                              'No notifications available.',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final notification = _notifications[index];
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(
                                notification.notificationType,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(notification.notificationMessage),
                            ),
                          );
                        },
                      ),
              ),
      ),
    );
  }

  showMessageDialog(String title, String message) {
    // Show failure dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
