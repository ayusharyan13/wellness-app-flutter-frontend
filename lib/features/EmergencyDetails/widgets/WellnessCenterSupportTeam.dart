import 'package:flutter/material.dart';

class WellnessCenterSupportTeam extends StatefulWidget {
  const WellnessCenterSupportTeam({super.key});

  @override
  State<WellnessCenterSupportTeam> createState() => _WellnessCenterSupportTeamState();
}

class _WellnessCenterSupportTeamState extends State<WellnessCenterSupportTeam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.1,),
          borderRadius: BorderRadius.circular(15)
      ),
      child: const Column(
        children: [
          ListTile(
            title: Text("Dr Rupa Murghai"),
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/rupa_murghai_mam.png"),
            ),
            trailing: Text("9 am - 5 pm"),
            subtitle: Text("Councelor"),
          ),
          ListTile(
            title: Text("Pankaj Suneja"),
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/pankaj_suneja_sir.jpg"),
            ),
            trailing: Text("9 am - 5 pm"),
            subtitle: Text("Councelor"),
          ),
        ],
      ),
    );
  }
}
