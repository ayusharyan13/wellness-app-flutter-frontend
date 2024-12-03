import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/BookingFormController.dart';
import '../Widgets/ConsultantsAvailable.dart';
import '../Widgets/DatePicker.dart';

class CreateBooking extends StatefulWidget {
  const CreateBooking({super.key});

  @override
  State<CreateBooking> createState() => _CreateBookingState();
}

class _CreateBookingState extends State<CreateBooking> {
  final BookingFormController formController1 = Get.put(BookingFormController());
  int? selectedConsultantId;


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
              // DatePickerButton(onDateSelected: _handleDateSelection),
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

