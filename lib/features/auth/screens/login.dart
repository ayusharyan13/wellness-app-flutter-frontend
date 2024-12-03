import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellness/features/auth/screens/register.dart';
import '../../../controllers/loginController.dart';
import '../../HomePage/screens/HomePage.dart';
import '../../blog/createBlog.dart';
import '../widgets/resuable_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupState();
}

class _SignupState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: (Column(
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
                    labelText: 'Email or Username',
                    hintText: 'ayusharyan1309@gmail.com',
                    icon: Icons.email_outlined,
                    controller: loginController.emailOrUserNameController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      return null;
                    },
                  ),
                ),

                // regex to handle better password mechanism
                Obx(
                  () => CustomTextFormField(
                    labelText: 'Password',
                    hintText: 'Minimum 7 chars',
                    icon: Icons.password_outlined,
                    controller:
                        loginController.passwordController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Please enter minimum of 7 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Obx(
                  () => ElevatedButton(
                    onPressed: loginController.isLoading.value
                        ? null
                        : loginController.logInButton,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey;
                          }
                          return const Color.fromRGBO(
                              71, 107, 21, 100);
                        },
                      ),
                    ),
                    child: loginController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.blueAccent)
                        : const Text(
                            'Login',
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
                    const Text("Don't have an Account ? "),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      child: const Text("Register Now"),
                      onTap: () {
                        Get.to(const RegisterScreen());
                      },
                    )
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () {
                  Get.to(const CreateBlog());
                }, child: const Text("Add Blog")),
                ElevatedButton(onPressed: () {
                  Get.to(const Homepage());
                }, child: const Text("HomePage"))
              ])),
        ],
      )),
    );
  }
}
