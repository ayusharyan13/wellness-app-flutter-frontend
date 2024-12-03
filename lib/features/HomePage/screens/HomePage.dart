import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Booking/screens/ShowBookings.dart';
import '../../Booking/screens/getBooking.dart';
import '../../Profile/screens/ProfileScreen.dart';
import '../../blog/BlogPage.dart';
import '../../EmergencyDetails/screens/emergency_help.dart';
import '../../blog/createBlog.dart';
import '../../blog/quillAddBlog.dart';
import '../../sleep_prediction/sleepPredictForm.dart';
import '../../NavigationBars/BottomNavBar.dart';
import '../widgets/CarouselSlider.dart';
import '../widgets/blogsGrids.dart';
import '../widgets/meetup_meditation.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Here you can add navigation logic if needed, like changing screens
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const BlogListScreen()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const BookingScreen()),
      );
    }
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const ProfilePage()),
      );
    }

}

  // List of image URLs for the carousel
  final List<String> imageUrls = [
    'assets/images/anxiety_image.jpeg',
    'https://via.placeholder.com/600/771796',
    'https://via.placeholder.com/600/24f355',
    'https://via.placeholder.com/600/d32776',
    'https://via.placeholder.com/600/f66b97',
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffFAE3EE),
      appBar: AppBar(
        backgroundColor: const Color(0xffF783BF),
        leading: IconButton(
          color: const Color(0xFF193238),

            onPressed: () {
              Get.to(const Homepage());
            },
            icon: const Icon(Icons.menu_outlined)),
        title: const Center(child: Text("Somnify" ,style: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
        ),)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Get.to(const EmergencyHelp());
                }, icon: const Icon(Icons.add_alert_rounded)),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(
            children: [
              CustomCarousel(imageUrls: imageUrls),
              const SizedBox(height: 10,),

              GestureDetector(
                  onTap: () {
                    Get.to(const SleepPredictForm());
                  },
                  child: const SleepPredictionButton()),

              const SizedBox(height: 7,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Blog Categories" , style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              BlogGrid(),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child:  Column(
                  children: [
                    MeetupMeditation(
                      containerColor: const Color(0xFFFCDDEC),
                      imageAsset: 'assets/icons/meetup_icon.png',
                      titleText: 'Peer Group Meetup',
                      titleTextColor: Colors.black,
                      descriptionText: "Let’s open up to the thing that\nmatters among the people",
                      descriptionTextColor: Colors.black,
                      buttonText: 'Join Now',
                      buttonTextColor: const Color(0xFFEF5DA8),
                      buttonIcon: Icons.play_circle_filled_outlined,
                      buttonIconColor: const Color(0xFFEF5DA8),
                      onButtonPressed: () {
                        // Define the button action here
                      },
                    ),
                    const SizedBox(height: 15,),
                    MeetupMeditation(
                      containerColor: const Color(0xFFF09E54).withOpacity(0.3),
                      imageAsset: 'assets/icons/meditation_icon.png',
                      titleText: 'Meditation',
                      titleTextColor: Colors.black,
                      descriptionText: "Aura is the most important thing\nthat matters to you.join us on ",
                      descriptionTextColor: Colors.black,
                      buttonText: '6.00 Pm ',
                      buttonIcon: Icons.watch_later_sharp,
                      buttonTextColor: const Color(0xFFF09E54),
                      buttonIconColor: const Color(0xFFF09E54),
                      onButtonPressed: () {
                        // Define the button action here

                      },
                    ),

                    ElevatedButton(onPressed: () {
                      Get.to(CreateBlog());
                    }
                        , child: Text("Create Post")),
                  ],
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class SleepPredictionButton extends StatelessWidget{
  const SleepPredictionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0 , right: 25),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xffEF5DA8),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color with transparency
              offset: const Offset(0, 4), // X and Y offsets of the shadow
              blurRadius: 10, // Blur radius
              spreadRadius: 3, // Spread radius
            ),
          ],
        ),

        child: const Center(
          child: Text( "Predict Sleep" ,
            style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}