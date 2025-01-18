import 'dart:math'; // Import the math library
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookAVisitForm extends StatefulWidget {
  final User user;

  const BookAVisitForm({Key? key, required this.user}) : super(key: key);

  @override
  _BookAVisitFormState createState() => _BookAVisitFormState();
}

class _BookAVisitFormState extends State<BookAVisitForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _visitDateController = TextEditingController();
  final TextEditingController _visitTimeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedDuration;
  String _status = 'PENDING';

  // Function to pick a date
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _visitDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;

        // Convert TimeOfDay to a DateTime to use with DateFormat
        final now = DateTime.now();
        final time = DateTime(
          now.year,
          now.month,
          now.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Explicitly format the time as hh:mm a
        _visitTimeController.text = DateFormat('hh:mm a').format(time);
      });
    }
  }
  // Function to submit the form
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select both date and time for the visit.'),
          ),
        );
        return;
      }

      // Generate a random room number between 10 and 25
      final randomRoomNumber = Random().nextInt(16) + 10;

      final visitData = {
        'userId': widget.user.id,
        'inmateId': widget.user.inmateId,
        'visitDate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
        'visitTime': DateFormat('hh:mm a').format(
          DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            _selectedTime!.hour,
            _selectedTime!.minute,
          ),
        ),
        'duration': _selectedDuration,
        'room': randomRoomNumber,
        'status': _status,
      };
      try {
        print(dotenv.env['API_URL']);
        final response = await http.post(
          Uri.parse(dotenv.env['API_URL']! + '/visits'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(visitData),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Visit successfully booked! Room number: $randomRoomNumber'),
            ),
          );

          _formKey.currentState!.reset();
          setState(() {
            _selectedDate = null;
            _selectedTime = null;
            _visitDateController.clear();
            _visitTimeController.clear();
            _selectedDuration = null;
            _status = 'PENDING';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to book visit: ${response.body}'),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred: $error'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Visit',
          style: TextStyle(fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Display inmate ID at the top
                  Text(
                    'Visit Inmate #${widget.user.id}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(height: 30, thickness: 1.5, color: Colors.black),
                  const SizedBox(height: 75),

                  // Date Picker
                  TextFormField(
                    controller: _visitDateController,
                    decoration: InputDecoration(
                      labelText: 'Visit Date',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today, color: Colors.black),
                    ),
                    readOnly: true,
                    onTap: _pickDate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a visit date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  // Time Picker
                  TextFormField(
                    controller: _visitTimeController,
                    decoration: InputDecoration(
                      labelText: 'Visit Time',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      suffixIcon: const Icon(Icons.access_time, color: Colors.black),
                    ),
                    readOnly: true,
                    onTap: _pickTime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a visit time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  // Duration Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedDuration,
                    decoration: InputDecoration(
                      labelText: 'Duration (min)',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    items: <String>['15', '30', '45', '60'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDuration = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select the duration';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 75),

                  // Submit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centers the content horizontally
                    children: [
                      // First column: SizedBox
                      SizedBox(
                        width: 50.0, // Adjust the width as needed
                      ),

                      // Second column: ElevatedButton
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          elevation: 10, // Set elevation for the shadow
                          shadowColor: Colors.grey.withOpacity(0.8), // Customize the shadow color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                        ),
                        child: const Text(
                          'Book Visit',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Third column: SizedBox
                      SizedBox(
                        width: 50.0, // Adjust the width as needed
                      ),
                    ],
                  )

                ],  //ListView children
              ),
            ),
          ),
        ),
      ),
    );
  }
}
