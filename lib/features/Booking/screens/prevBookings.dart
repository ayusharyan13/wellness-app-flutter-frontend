import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants/urlApi.dart';
import '../model/Booking.dart';

class PreviousBookingsScreen extends StatefulWidget {
  const PreviousBookingsScreen({super.key});

  @override
  State<PreviousBookingsScreen> createState() => _PreviousBookingsScreenState();
}

class _PreviousBookingsScreenState extends State<PreviousBookingsScreen> {
  late Future<List<Booking>> previousBookingsFuture;

  @override
  void initState() {
    super.initState();
    previousBookingsFuture = fetchPreviousBookings();
  }

  Future<List<Booking>> fetchPreviousBookings() async {
    String baseUrl = UrlApi.getPendingBooking;

    try {
      // Retrieve the user ID and access token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        throw Exception("User is not logged in.");
      }

      final int? userId = prefs.getInt('userId'); // Assuming userId is stored
      if (userId == null) {
        throw Exception("User ID not found.");
      }

      // Construct the URL with the user ID
      final String url = "$baseUrl/$userId";

      // Make the API request
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        // Parse the JSON data
        return jsonData.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load previous bookings: ${response.reasonPhrase}");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Error fetching previous bookings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Bookings"),
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilder<List<Booking>>(
        future: previousBookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No previous bookings found."),
            );
          } else {
            final bookings = snapshot.data!;

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                final consultantName =
                booking.consultantId == 1 ? "Rupa Murghai" : "Pankaj Suneja";

                return Card(
                  elevation: 4,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Appointment ID: ${booking.appointmentId}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Phone Number: ${booking.phoneNumber}"),
                        const SizedBox(height: 8),
                        Text("Service Type: ${booking.serviceType}"),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Start Time: ${booking.slotStartTime}"),
                            ),
                            Expanded(
                              child: Text("End Time: ${booking.slotEndTime}"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Status: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              booking.status,
                              style: TextStyle(
                                color: booking.status == "Completed"
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text("Consultant: $consultantName"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
