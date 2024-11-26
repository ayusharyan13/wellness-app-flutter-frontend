import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerButton extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Function to notify parent widget of date selection

  const DatePickerButton({super.key, required this.onDateSelected});

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime selectedDate = DateTime.now();
  DateTime firstSelectableDate = DateTime.now();
  List<DateTime> availableDates = [];
  final int daysToShow = 6;

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  // Initialize selectable dates
  void _initializeDates() {
    DateTime now = DateTime.now();
    // Show today's date if it's before 2 PM, otherwise start from tomorrow
    if (now.hour >= 14) {
      firstSelectableDate = now.add(const Duration(days: 1));
    } else {
      firstSelectableDate = now;
    }
    availableDates = _generateAvailableDates(firstSelectableDate, daysToShow);
  }

  // Generate available dates excluding Sundays
  List<DateTime> _generateAvailableDates(DateTime startDate, int days) {
    List<DateTime> dates = [];
    DateTime current = startDate;

    while (dates.length < days) {
      if (current.weekday != DateTime.sunday) {
        dates.add(current);
      }
      current = current.add(const Duration(days: 1));
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Selected Date: ${DateFormat.yMMMMd().format(selectedDate)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 114,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableDates.length,
                itemBuilder: (context, index) {
                  DateTime date = availableDates[index];
                  bool isSelected = date == selectedDate;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                      widget.onDateSelected(date); // Notify parent widget
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.all(12.0),
                      width: 100,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                        border: isSelected
                            ? Border.all(color: Colors.blue, width: 2)
                            : Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.E().format(date),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat.d().format(date),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat.MMM().format(date),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//   child: ElevatedButton(
//     onPressed: () {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//               "Confirmed Date: ${DateFormat.yMMMMd().format(selectedDate)}"),
//         ),
//       );
//     },
//     style: ElevatedButton.styleFrom(
//       padding: const EdgeInsets.symmetric(vertical: 15.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//     ),
//     child: const Text(
//       "Confirm",
//       style: TextStyle(fontSize: 16),
//     ),
//   ),
// ),
// const SizedBox(height: 20),