import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/urlApi.dart';
import '../Widgets/FilterButton.dart';
import '../model/Booking.dart';
import 'createBooking.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Future<List<Booking>> bookingsFuture;
  String filter = 'Upcoming';

  @override
  void initState() {
    super.initState();
    bookingsFuture = fetchBookings();
  }

  Future<List<Booking>> fetchBookings() async {
    late String baseUrl;

    switch (filter) {
      case 'Confirmed':
        baseUrl = UrlApi.getConfirmedBooking;
        break;
      case 'Pending':
        baseUrl = UrlApi.getPendingBooking;
        break;
      case 'Previous':
        baseUrl = UrlApi.getPreviousBooking;
        break;
      default:
        baseUrl = UrlApi.getUpComingBooking;
    }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');
      if (accessToken == null) throw Exception("User is not logged in.");

      final int? userId = prefs.getInt('userId');
      if (userId == null) throw Exception("User ID not found.");

      final String url = "$baseUrl/$userId";

      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load bookings: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error fetching bookings: $e");
    }
  }

  void onFilterChanged(String selectedFilter) {
    setState(() {
      filter = selectedFilter;
      bookingsFuture = fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
        backgroundColor: Colors.deepOrange,
        actions: [
          FilterButton(
            onTap: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(100, 80, 0, 0),
                items: [
                  const PopupMenuItem(
                    value: 'Upcoming',
                    child: Text("Upcoming Bookings"),
                  ),
                  const PopupMenuItem(
                    value: 'Confirmed',
                    child: Text("Confirmed"),
                  ),
                  const PopupMenuItem(
                    value: 'Pending',
                    child: Text("Pending"),
                  ),
                  const PopupMenuItem(
                    value: 'Previous',
                    child: Text("Previous Bookings"),
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  onFilterChanged(value);
                }
              });
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Get.to(CreateBooking());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Booking>>(
          future: bookingsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No bookings found."),
              );
            } else {
              final bookings = snapshot.data!;
              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final book = bookings[index];
                  final consultantName = book.consultantId == 1
                      ? "Rupa Murghai"
                      : "Pankaj Suneja";
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.orange[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Appointment ID: ${book.appointmentId}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Divider(),
                          Text(
                            "Phone: ${book.phoneNumber}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Service: ${book.serviceType}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Start: ${book.slotStartTime}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "End: ${book.slotEndTime}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Status: ${book.status}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "Consultant: $consultantName",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
