import "package:flutter/material.dart";

class SleepDetectionGoogleApi extends StatefulWidget {
  const SleepDetectionGoogleApi({super.key});

  @override
  State<SleepDetectionGoogleApi> createState() => _SleepDetectionGoogleApiState();
}

class _SleepDetectionGoogleApiState extends State<SleepDetectionGoogleApi> {
  @override
  //
  // void hitSleepApi() {
  //   val task = ActivityRecognition.getClient(context)
  //       .requestSleepSegmentUpdates(
  //       pendingIntent,
  //       SleepSegmentRequest.getDefaultSleepSegmentRequest())
  //       .addOnSuccessListener {
  //     viewModel.updateSubscribedToSleepData(true)
  //     Log.d(TAG, "Successfully subscribed to sleep data.")
  //   }
  //       .addOnFailureListener { exception ->
  //   Log.d(TAG, "Exception when subscribing to sleep data: $exception")
  //   }
  // }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
    );
  }
}
