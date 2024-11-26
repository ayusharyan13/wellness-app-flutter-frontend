import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultantSelection extends StatefulWidget {
  const ConsultantSelection({super.key});

  @override
  _ConsultantSelectionState createState() => _ConsultantSelectionState();
}

class _ConsultantSelectionState extends State<ConsultantSelection> {
  int? selectedConsultantId;
  String selectedDate = "2024-11-28"; // Default selected date
  List<Map<String, dynamic>> availableSlots = [];
  bool isLoadingSlots = false;
  double rating = 3.5;
  int starCount = 5;

  // Function to handle date selection
  void _handleDateSelection(DateTime selectedDate) {
    setState(() {
      this.selectedDate = selectedDate.toIso8601String().split('T')[0]; // Format the date
    });
    if (selectedConsultantId != null) {
      fetchAvailableSlots(selectedConsultantId!); // Fetch slots after selecting the date
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        consultantCard(
            "Rupa Murghai",
            "Expert in Wellness",
            1,
            'assets/images/rupa_murghai_mam.png',
            "English, Hindi",
            "10 Years."),
        const SizedBox(
          height: 10,
        ),
        consultantCard(
            "Pankaj Suneja",
            "Expert in Psychology",
            2,
            'assets/images/pankaj_suneja_sir.jpg',
            "English, Hindi",
            "7 Years."),
        const SizedBox(height: 20),
        if (selectedConsultantId != null) ...[
          const Text(
            'Available Slots',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          isLoadingSlots
              ? const CircularProgressIndicator()
              : availableSlots.isNotEmpty
              ? Wrap(
            spacing: 8.0,
            children: availableSlots.map((slot) {
              return ChoiceChip(
                label: Text(
                    '${slot['startTime']} - ${slot['endTime']} \n(${slot['fullyBooked'] ? "Fully Booked" : "Available"})'),
                selected: false,
                onSelected: (selected) {
                  print("Selected slot: ${slot['startTime']}");
                  // Handle slot selection
                },
              );
            }).toList(),
          )
              : const Text('No slots available for the selected date'),
        ]
      ],
    );
  }

  Widget consultantCard(
      String name,
      String expertise,
      int consultantId,
      String imagePath,
      String language,
      String experience,
      ) {
    bool isSelected = selectedConsultantId == consultantId;
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedConsultantId = consultantId;
          });
          fetchAvailableSlots(consultantId);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: isSelected
                  ? Colors.blue
                  : Colors.green, // Change border color
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(imagePath),
                            minRadius: 40,
                          ),
                        ),
                        StarRating(
                          size: 10.0,
                          rating: rating,
                          color: Colors.orange,
                          borderColor: Colors.grey,
                          allowHalfRating: true,
                          starCount: starCount,
                          onRatingChanged: (rating) => setState(() {
                            this.rating = rating;
                          }),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "1000+ Sessions",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.black26),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            expertise,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            language,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Exp: $experience",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 38.0),
                      child: Icon(
                          color: Colors.green,
                          size: 23,
                          Icons.verified_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: GestureDetector(
                        child: Container(
                          width: 56,
                          height: 20,
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.pink, width: 0.8),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chat",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  // Fetch available slots for the selected consultant
  Future<void> fetchAvailableSlots(int consultantId) async {
    setState(() {
      isLoadingSlots = true;
      availableSlots = []; // Clear previous slots
    });

    // Retrieve accessToken and tokenType from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final tokenType = prefs.getString('tokenType');

    if (accessToken == null || tokenType == null) {
      setState(() {
        availableSlots = [];
      });
      print('No access token found');
      return; // Exit if token is not available
    }

    final url =
        'https://5294-103-139-191-219.ngrok-free.app/slots/available?consultantId=$consultantId&date=$selectedDate';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': '$tokenType $accessToken', // Add the token here
          'Content-Type': 'application/json', // Set content type if needed
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> slots = json.decode(response.body);

        // Parse the slots to a structured list
        setState(() {
          availableSlots = slots.map((slot) {
            return {
              'id': slot['id'],
              'startTime': slot['startTime'],
              'endTime': slot['endTime'],
              'consultant1': slot['consultant1']['name'],
              'consultant2': slot['consultant2']['name'],
              'fullyBooked': slot['fullyBooked'],
            };
          }).toList();
        });
      } else {
        setState(() {
          availableSlots = [];
        });
        print('Failed to load slots: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        availableSlots = [];
      });
      print('Error fetching slots: $e');
    } finally {
      setState(() {
        isLoadingSlots = false;
      });
    }
  }
}