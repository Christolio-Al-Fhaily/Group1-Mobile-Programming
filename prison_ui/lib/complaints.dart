import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'models/user.dart';

class ComplaintsForm extends StatefulWidget {
  final User user;

  const ComplaintsForm({super.key, required this.user});

  @override
  State<ComplaintsForm> createState() => _ComplaintsFormState();
}

class _ComplaintsFormState extends State<ComplaintsForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _visitDateController = TextEditingController();
  DateTime? _selectedDate;
  String? _incidentType;

  final List<String> _incidentTypes = [
    'Harassment',
    'Mistreatment',
    'Corruption',
    'Other'
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Prepare the data for submission
      final Map<String, dynamic> complaintData = {
        "userId": widget.user.id,
        "incidentDate": _selectedDate?.toIso8601String(),
        "complaintType": _incidentType,
        "description": _descriptionController.text,
      };

      try {
        // Send the POST request
        final response = await http.post(
          Uri.parse('${dotenv.env['API_URL']!}/complaints'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(complaintData),
        ).timeout(const Duration(seconds: 10));

        if (response.statusCode == 201) {
          // Show success message
          showMessageDialog(
              "Complaint Submitted", "Thank you for your feedback.");

          // Clear form fields
          _descriptionController.clear();
          _visitDateController.clear();
          setState(() {
            _selectedDate = null;
            _incidentType = null;
          });
        } else {
          // Show error message
          showMessageDialog("Failed to submit complaint", response.body);
        }
      } on TimeoutException {
        showMessageDialog("Failed to submit complaint", "Request timed out.");
      } catch (e) {
        // Show error message
        showMessageDialog("Failed to submit complaint", e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _visitDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prison Complaints Form',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Text(
                'File Your Complaint',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              // Date Picker
              TextFormField(
                decoration: InputDecoration(
                  labelText: _selectedDate == null
                      ? 'Incident Date'
                      : 'Date: ${_selectedDate?.toLocal().toString().split(' ')[0]}',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _pickDate,
                controller: _visitDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an incident date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Incident Type Dropdown
              DropdownButtonFormField<String>(
                value: _incidentType,
                decoration: const InputDecoration(labelText: 'Incident Type'),
                items: _incidentTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toUpperCase(),
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _incidentType = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an incident type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange, // Spinner color
                  ),
                )
            ],
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
