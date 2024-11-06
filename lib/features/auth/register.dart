import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_final/controllers/registerController.dart';
import 'package:sleep_final/features/auth/login.dart';
import 'package:sleep_final/features/blog/BlogPage.dart';
import '../../controllers/formController.dart';
import '../../widgets/resuable_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomTextFormField(
                      labelText: 'Enter Email',
                      hintText: 'ayusharyan1309@gmail.com',
                      icon: Icons.email_outlined,
                      controller: registerController.emailController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      labelText: 'Password',
                      hintText: 'Minimum 7 chars',
                      icon: Icons.password_outlined,
                      controller:
                      registerController.passwordController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      labelText: 'Confirm Password',
                      hintText: 'Enter minimum 5 chars',
                      icon: Icons.password_rounded,
                      controller: registerController.confirmPasswordController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(
                        () => CustomTextFormField(
                      labelText: 'Full Name',
                      hintText: 'Ayush Aryan',
                      icon: Icons.drive_file_rename_outline,
                      controller: registerController.fullNameController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      labelText: 'Username',
                      hintText: 'Enter username',
                      icon: Icons.supervised_user_circle_sharp,
                      controller:
                      registerController.userNameController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: registerController.isLoading.value
                          ? null
                          : registerController.registerButton,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.disabled)) {
                              return Colors.grey; // Color when button is disabled
                            }
                            return const Color.fromRGBO(
                                71, 107, 21, 100); // Color when button is enabled
                          },
                        ),
                      ),
                      child: registerController.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.blueAccent)
                          : const Text(
                              'Register',
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
        
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account ? ", style: TextStyle(
                         color:  Colors.indigo
        
                      ),),
                      const SizedBox(width: 20,),
                      GestureDetector(child: const Text("Sign in", style: TextStyle(
                          color:  Colors.indigo)),
                        onTap: () {
                        Get.to(const LoginScreen());
                        },
                      )
                    ],
                  ),
        
                  // Row(
                  //   children: [
                  //     GestureDetector(child: const Text("Go to BlogScreen," , style: TextStyle(
                  //         color:  Colors.indigo)),
                  //     onTap: () {
                  //       Get.to(BlogListScreen());
                  //     },)
                  //   ],
                  // )


                ])),
          ],
        ),
      ),
    );
  }
}
