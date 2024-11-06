import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_final/screens/DataSafety.dart';
import 'package:sleep_final/features/sleep_prediction/predictionMetrics.dart';
import 'package:sleep_final/features/sleep_prediction/SleepPredictionScreen.dart';
import 'package:sleep_final/screens/userGuideScreen.dart';
import '../../controllers/formController.dart';
import '../../widgets/resuable_form.dart';

class SleepPredictForm extends StatefulWidget {
  const SleepPredictForm({super.key});

  @override
  State<SleepPredictForm> createState() => _HomePageState();
}

class _HomePageState extends State<SleepPredictForm> {

  final SleepFormController formController = Get.put(SleepFormController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            // height: 100,
            color: const Color.fromRGBO(71, 107, 21,100),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 120.0),
                  child: Text(
                    'Somnofy',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),

              ],
            ),
          ),
        ),
        drawer: Drawer(
          width: 250,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 45,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(71, 107, 21,100),
                ),
                child: const Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context); // close the drawer
                  // Navigate to Home screen or perform other actions
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context); // close the drawer
                  // Navigate to Profile screen or perform other actions
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Data Safety'),
                onTap: () {
                  Get.to(()=> const DataSafetyScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('User Guide'),
                onTap: () {
                  Navigator.pop(context); // close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserGuideScreen(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.equalizer),
                title: const Text('Evaluation Metrics'),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const PredictionInfoScreen());
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context); // close the drawer
                  Get.snackbar('Logout', 'You have been logged out.');
                },
              ),
            ],
          ),
        ),


        body: Container(
          decoration:  const BoxDecoration(
            color: Color.fromRGBO(192, 214, 169,100),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(children: [
                      const SizedBox(height: 20,),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Hours Slept',
                          hintText: 'Enter numeric value',
                          icon: Icons.access_time,
                          controller: formController.hoursSleptController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your sleep hours';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Conversation Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.chat_bubble_outline,
                          controller:
                              formController.conversationDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your conversation duration';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Dark Duration Hours',
                          hintText: 'Enter numeric value',
                          icon: Icons.nightlight_round,
                          controller: formController.darkDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your time spent in dark';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Noise Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.volume_up,
                          controller:
                              formController.noiseDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Silence Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.volume_off,
                          controller:
                              formController.silenceDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Voice Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.record_voice_over,
                          controller:
                              formController.voiceDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Lock Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.lock,
                          controller: formController.lockDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Charge Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.battery_charging_full,
                          controller:
                              formController.chargeDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Running Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.directions_run,
                          controller:
                              formController.runningDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Stationary Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.accessibility_new,
                          controller:
                              formController.stationaryDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => CustomTextFormField(
                          labelText: 'Walking Duration',
                          hintText: 'Enter numeric value',
                          icon: Icons.directions_walk,
                          controller:
                              formController.walkingDurationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your value';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Obx( () =>
                         ElevatedButton(
                          onPressed: formController.isLoading.value ? null : formController.submitForm,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey; // Color when button is disabled
                                }
                                return const Color.fromRGBO(71, 107, 21,100); // Color when button is enabled
                              },
                            ),
                          ),

                          child: formController.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.blueAccent)
                              : const Text('Predict',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30,),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
