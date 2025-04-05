import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/presentation/widget/socail_media_widget.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/feature/forget_password/presentation/view/forget_password_screen.dart';
import 'package:foodtek_app/feature/main_screen/main_screen.dart';
import 'package:foodtek_app/feature/sign_up/presentation/view/sign_up_screen.dart';
import 'package:foodtek_app/core/validation/presentation/cubit/validation_cubit.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import 'package:foodtek_app/core/presentation/widget/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/presentation/bottom_sheet/msg_bottom_sheet.dart';
import '../../../../core/presentation/button/custom_button.dart';
import '../cubit/signin_cubit.dart';
import '../state/signin_state.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(
          create: (_) => SignInCubit(),
        ),
        BlocProvider<ValidationCubit>(
          create: (_) => ValidationCubit(validationRepository: context.read()), // Ensure ValidationRepository is provided
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: responsiveWidth(context, 430),
              height: responsiveHeight(context, 932),
              child: Image.asset(
                PNGs.backgroundImage,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: responsiveHeight(context, 74)),
                  Image.asset(
                    PNGs.foodtecLogoPng,
                    width: responsiveWidth(context, 307),
                    height: responsiveHeight(context, 85),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 55),
                    padding: const EdgeInsets.all(24),
                    width: responsiveWidth(context, 343),
                    decoration: BoxDecoration(
                      color: COLORs.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BlocListener<SignInCubit, SignInState>(
                      listener: (context, state) {
                        if (state is ErrorSignInState) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildBottomSheet(
                              title: 'Login Error',
                              msg: state.message,
                                imagePath: SVGs.wrong
                            ),
                          );
                        } else if (state is GetSignInByUserState) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildBottomSheet(
                                title: 'Success',
                                msg: "Login Succesfully",
                                imagePath: SVGs.success
                            )
                          ).then((_) {
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MainScreen(selectedIndex: 0,),));
                          });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                height: 1.3,
                                letterSpacing: -0.02,
                                color: COLORs.blackmain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don’t have an account? ",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      height: 1.4,
                                      letterSpacing: -0.01,
                                      color: COLORs.darkgray,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 1.4,
                                      letterSpacing: -0.01,
                                      color: COLORs.blue1,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                hintText: 'losekbet@gmail.com',
                                isPassword: false,
                                controller: emailController,
                                title: 'Email',
                                height: 932,
                                width: 430,
                                borderColor: COLORs.borderColor,
                                focusedBorderColor: COLORs.blue1,
                                errorBorderColor: COLORs.blue1,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: '••••••••',
                                isPassword: true,
                                controller: passwordController,
                                title: 'Password',
                                height: 932,
                                width: 430,
                                borderColor: COLORs.borderColor,
                                focusedBorderColor: COLORs.blue1,
                                errorBorderColor: COLORs.blue1,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 19,
                                    height: 19,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: COLORs.darkgray, width: 1.5),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      height: 1.5,
                                      letterSpacing: -0.01,
                                      color: COLORs.darkgray,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                                  );
                                },
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    height: 1.4,
                                    letterSpacing: -0.01,
                                    color: COLORs.blue1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<SignInCubit, SignInState>(
                            builder: (context, state) {
                              return CustomButton(
                                buttonName: state is LoadingSignInState ? "Logging In..." : "Log In",
                                onTap: (){
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();
                                  final validationCubit = context.read<ValidationCubit>();

                                  // Validate inputs
                                  validationCubit.validateEmail(email: email);
                                  validationCubit.validatePassword(password: password);

                                  if (email.isEmpty && password.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Login Error',
                                        msg: 'The email and password are required',
                                          imagePath: SVGs.wrong
                                      ),
                                    );
                                    return;
                                  }
                                  if (email.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Login Error',
                                        msg: 'Please enter your email',
                                          imagePath: SVGs.wrong
                                      ),
                                    );
                                    return;
                                  }
                                  if (!validationCubit.isEmailValid) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Login Error',
                                        msg: 'Your email is not valid',
                                          imagePath: SVGs.wrong
                                      ),
                                    );
                                    return;
                                  }
                                  if (password.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Login Error',
                                        msg: 'Please enter your password',
                                        imagePath: SVGs.wrong
                                      ),
                                    );
                                    return;
                                  }
                                  if (!validationCubit.isPasswordValid) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Login Error',
                                        msg: 'Enter a strong password',
                                        imagePath:SVGs.wrong
                                      ),
                                    );
                                    return;
                                  }

                                  // If all validations pass, proceed with sign-in
                                  context.read<SignInCubit>().signInUser(
                                    email: email,
                                    password: password,
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: const Color(0xFFEDF1F3),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    height: 1.5,
                                    letterSpacing: -0.01,
                                    color: COLORs.darkgray,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: const Color(0xFFEDF1F3),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              SocailMediaWidget(
                                title: "Continue with Google",
                                svgIcon: SVGs.google,
                                onTap: () => _launchUrl(url: "https://www.google.com/"),
                              ),
                              const SizedBox(height: 15),
                              SocailMediaWidget(
                                title: "Continue with Facebook",
                                svgIcon: SVGs.facebook,
                                onTap: () => _launchUrl(url: "https://www.facebook.com/?locale=ar_AR"),
                              ),
                              const SizedBox(height: 15),
                              SocailMediaWidget(
                                title: "Continue with Apple",
                                svgIcon: SVGs.apple,
                                onTap: () => _launchUrl(url: "https://www.apple.com/jo-ar/app-store/"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 20)),
                  Container(
                    width: responsiveWidth(context, 428.1),
                    height: responsiveHeight(context, 38.81),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: responsiveWidth(context, 148),
                      height: responsiveHeight(context, 5),
                      margin: const EdgeInsets.only(bottom: 7.81), // Fix this typo if needed
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet({required String title, required String msg,required String imagePath}) {
    return MsgBottomSheet(
        msg: msg,
        title: title,
        imagePath: imagePath,
      color: COLORs.blue1,
    );
  }

  Future<void> _launchUrl({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}