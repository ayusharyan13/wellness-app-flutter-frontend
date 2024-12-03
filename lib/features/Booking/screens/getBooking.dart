import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellness/features/Booking/screens/prevBookings.dart';
import 'package:wellness/features/Booking/screens/upComingBooking.dart';

class Bookings extends StatelessWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings" , style: TextStyle(
          fontSize: 13,
        ),),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Upcoming Bookings" , style: TextStyle(color: Colors.black45),),
              const SizedBox(height: 10,),
            ],
          ),
          const SizedBox(
            height: 500,
              child: UpcomingConfirmedBooking()),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            Get.to(const PreviousBookingsScreen());
          }, child: const Text("Previous Booking"))
        ],
      ),
    );
  }
}
