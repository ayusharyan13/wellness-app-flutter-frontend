import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness/constants/urlApi.dart';

class ConsultantSelection extends StatefulWidget {
  const ConsultantSelection({super.key});

  @override
  _ConsultantSelectionState createState() => _ConsultantSelectionState();
}

class _ConsultantSelectionState extends State<ConsultantSelection> {
  int? selectedConsultantId;
  List<Map<String, dynamic>> availableSlots = [];
  bool isLoadingSlots = false;
  double rating = 3.5;
  int starCount = 5;

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
    return Column(
      children: [
        SizedBox(
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
                          if (selectedConsultantId != null) {
                            fetchAvailableSlots(selectedConsultantId!, date);
                          }
                        });
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
        // Consultant cards
        consultantCard(
          "Rupa Murghai",
          "Expert in Wellness",
          1,
          'assets/images/rupa_murghai_mam.png',
          "English, Hindi",
          "10 Years.",
        ),
        const SizedBox(height: 10),
        consultantCard(
          "Pankaj Suneja",
          "Expert in Psychology",
          2,
          'assets/images/pankaj_suneja_sir.jpg',
          "English, Hindi",
          "7 Years.",
        ),
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
          fetchAvailableSlots(consultantId, selectedDate);
        });
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
      )
    );
  }

  // Widget consultantCard(
  //     String name,
  //     String expertise,
  //     int consultantId,
  //     String imagePath,
  //     String language,
  //     String experience,
  //     ) {
  //   bool isSelected = selectedConsultantId == consultantId;
  //   return GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           selectedConsultantId = consultantId;
  //         });
  //         fetchAvailableSlots(consultantId);
  //       },
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(13),
  //           border: Border.all(
  //             color: isSelected
  //                 ? Colors.blue
  //                 : Colors.green, // Change border color
  //             width: isSelected ? 2 : 1,
  //           ),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 8.0, right: 12),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Row(
  //                 children: [
  //                   Column(
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 40,
  //                         child: CircleAvatar(
  //                           backgroundImage: AssetImage(imagePath),
  //                           minRadius: 40,
  //                         ),
  //                       ),
  //                       StarRating(
  //                         size: 10.0,
  //                         rating: rating,
  //                         color: Colors.orange,
  //                         borderColor: Colors.grey,
  //                         allowHalfRating: true,
  //                         starCount: starCount,
  //                         onRatingChanged: (rating) => setState(() {
  //                           this.rating = rating;
  //                         }),
  //                       ),
  //                       const SizedBox(
  //                         height: 5,
  //                       ),
  //                       const Text(
  //                         "1000+ Sessions",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 13,
  //                             color: Colors.black26),
  //                       )
  //                     ],
  //                   ),
  //                   const SizedBox(
  //                     width: 15,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 36.0),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           name,
  //                           style: const TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.indigo,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         const SizedBox(
  //                           height: 3,
  //                         ),
  //                         Text(
  //                           expertise,
  //                           style: const TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.black45,
  //                               fontWeight: FontWeight.w500),
  //                         ),
  //                         const SizedBox(
  //                           height: 3,
  //                         ),
  //                         Text(
  //                           language,
  //                           style: const TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.black45,
  //                               fontWeight: FontWeight.w500),
  //                         ),
  //                         const SizedBox(
  //                           height: 3,
  //                         ),
  //                         Text(
  //                           "Exp: $experience",
  //                           style: const TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.black45,
  //                               fontWeight: FontWeight.w500),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 width: 20,
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   const Padding(
  //                     padding: EdgeInsets.only(bottom: 38.0),
  //                     child: Icon(
  //                         color: Colors.green,
  //                         size: 23,
  //                         Icons.verified_outlined),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 18.0),
  //                     child: GestureDetector(
  //                       child: Container(
  //                         width: 56,
  //                         height: 20,
  //                         decoration: BoxDecoration(
  //                             border:
  //                             Border.all(color: Colors.pink, width: 0.8),
  //                             borderRadius:
  //                             const BorderRadius.all(Radius.circular(12))),
  //                         child: const Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               "Chat",
  //                               style: TextStyle(
  //                                   color: Colors.pink,
  //                                   fontSize: 10,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ));
  // }

  Future<void> fetchAvailableSlots(int consultantId, DateTime date) async {
    setState(() {
      isLoadingSlots = true;
      availableSlots = [];
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final tokenType = prefs.getString('tokenType');

    if (accessToken == null || tokenType == null) {
      setState(() {
        availableSlots = [];
      });
      print('No access token found');
      return;
    }

    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final url = '${UrlApi.getAvailableSlots}?consultantId=$consultantId&date=$formattedDate';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': '$tokenType $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> slots = json.decode(response.body);
        setState(() {
          availableSlots = slots.map((slot) {
            return {
              'id': slot['id'],
              'startTime': slot['startTime'],
              'endTime': slot['endTime'],
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
