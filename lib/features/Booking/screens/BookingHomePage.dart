import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/BookingFormController.dart';
import '../Widgets/ConsultantsAvailable.dart';
import '../Widgets/DatePicker.dart';
import '../Widgets/ReusableDropDown.dart';

class BookingHomePage extends StatefulWidget {
  const BookingHomePage({super.key});

  @override
  State<BookingHomePage> createState() => _BookingHomePageState();
}

class _BookingHomePageState extends State<BookingHomePage> {
  final BookingFormController formController1 = Get.put(BookingFormController());
  final _formKey = GlobalKey<FormState>();
  int? selectedConsultantId;

  // Function to handle date selection
  void _handleDateSelection(DateTime selectedDate) {
    // Add your logic to handle the selected date here
    print("Selected date: $selectedDate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Book Your Service"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // Passing the required onDateSelected parameter
              DatePickerButton(onDateSelected: _handleDateSelection),
              const SizedBox(
                height: 4,
              ),
              const ConsultantSelection(),
            ],
          ),
        ),
      ),
    );
  }
}

