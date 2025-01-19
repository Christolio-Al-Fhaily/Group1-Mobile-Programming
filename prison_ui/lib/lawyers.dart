import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/lawyer.dart';

final random = Random();

class LawyersPage extends StatefulWidget {
  const LawyersPage({super.key});

  @override
  State<LawyersPage> createState() => _LawyersPageState();
}

class _LawyersPageState extends State<LawyersPage> {
  List<Map<String, String>> lawyers = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('${dotenv.env["API_URL"]!}/lawyers'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        // Map JSON response to Lawyer objects
        List<Lawyer> lawyersInfo =
            jsonList.map((json) => Lawyer.fromMap(json)).toList();

        // Update state with the mapped data
        setState(() {
          lawyers = List.generate(
            lawyersInfo.length,
            (index) => {
              "imageUrl":
                  "https://randomuser.me/api/portraits/men/${random.nextInt(80) + 1}.jpg",
              "firstName": lawyersInfo[index].firstName,
              "lastName": lawyersInfo[index].lastName,
              "firmName": "Firm ${lawyersInfo[index].firm}",
              "phoneNumber": lawyersInfo[index].phoneNumber,
              "email": lawyersInfo[index].email,
            },
          );
          isLoading = false;
        });
      } else {
        throw Exception("Failed to fetch lawyers: ${response.statusCode}");
      }
    } on TimeoutException {
      showErrorDialog("Request timed out please refresh.");
    } catch (error) {
      showErrorDialog(error.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyers'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData, // Trigger fetchData when the user refreshes
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: lawyers.length,
                itemBuilder: (context, index) {
                  final lawyer = lawyers[index];
                  return GestureDetector(
                    onTap: () => showInfoDialog(lawyer),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(lawyer['imageUrl']!,
                              height: 100, width: 100),
                          const SizedBox(height: 10),
                          Text(
                            "${lawyer['firstName']} ${lawyer['lastName']}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void showInfoDialog(Map<String, String> lawyer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(lawyer['imageUrl']!, width: 100, height: 100),
              const SizedBox(height: 10),
              Text(
                "${lawyer['firstName']} ${lawyer['lastName']}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Firm: ${lawyer['firmName']}"),
              Text("Phone: ${lawyer['phoneNumber']}"),
              Text("Email: ${lawyer['email']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
