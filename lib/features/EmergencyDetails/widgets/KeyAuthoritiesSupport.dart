import 'package:flutter/material.dart';

import 'ContactCard.dart';
class KeyAuthoritiesSupport extends StatefulWidget {
  const KeyAuthoritiesSupport({super.key});
  @override
  State<KeyAuthoritiesSupport> createState() => _KeyAuthoritiesSupportState();
}

class _KeyAuthoritiesSupportState extends State<KeyAuthoritiesSupport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.2,),
          borderRadius: BorderRadius.circular(19)
      ),
      child: const Column(
        children: [
          ContactCard(name: "Dean Student Welfare", title: "Contact for academic and personal issues", icon: Icon(Icons.home_outlined) ,),
          ContactCard(name: "Security Office", title: "Contact for security concerns",icon: Icon(Icons.privacy_tip_outlined)),
          ContactCard(name: "Wellness Centre", title: "Contact for health and wellness support", icon: Icon(Icons.medical_services) ),
        ],
      ),
    );
  }
}
