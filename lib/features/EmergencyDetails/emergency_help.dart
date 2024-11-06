import 'package:flutter/material.dart';
import 'package:sleep_final/widgets/EmergencyButton.dart';
import '../../widgets/HelpText.dart';
import '../../widgets/KeyAuthoritiesSupport.dart';
import '../../widgets/WellnessCenterSupportTeam.dart';

class EmergencyHelp extends StatelessWidget {
  const EmergencyHelp({super.key});

  @override
  Widget build(BuildContext context) {
     const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 18.0, right: 15),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Immediate Help",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),),
                HelpText(),
                Text("Wellness Centre",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),),
                WellnessCenterSupportTeam(),
                Text("Key Authorities",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),),

                KeyAuthoritiesSupport(),

                Text("Hostel Wardens",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),),
                EmergencyButton(icon: warning, text: "Emergency Contacts"),
              ],
            )

          ],
        ),
      ),
    );
  }
}
