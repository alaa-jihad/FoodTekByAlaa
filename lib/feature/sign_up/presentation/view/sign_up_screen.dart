import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/presentation/widget/custom_textfield.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/core/validation/presentation/cubit/validation_cubit.dart';
import 'package:foodtek_app/feature/sign_in/presentation/view/signin_screen.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import '../../../../core/presentation/bottom_sheet/msg_bottom_sheet.dart';
import '../../../../core/presentation/button/custom_button.dart';
import '../cubit/signup_cubit.dart';
import '../state/signup_state.dart'; // Updated import to match naming

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(validationRepository: context.read()),
        ),
        BlocProvider<ValidationCubit>(
          create: (_) => ValidationCubit(validationRepository: context.read()),
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
                    child: BlocListener<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                        if (state is ErrorSignUpState) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildBottomSheet(
                              title: 'Signup Error',
                              msg: state.message,
                              imagePath: SVGs.wrong,
                            ),
                          );
                        } else if (state is GetSignUpByUserState) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildBottomSheet(
                              title: 'Success',
                              msg: 'Register Successful',
                              imagePath: SVGs.success,
                            ),
                          );
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(SVGs.arrowBack, height: 24.sp, width: 24.sp),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SigninScreen()),
                              );
                            },
                          ),
                          SizedBox(height: responsiveHeight(context, 16)),
                          Text(
                            'Sign up',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              height: 1.3,
                              letterSpacing: -0.02,
                              color: COLORs.blackmain,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account? ",
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
                                  text: "Login",
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
                                        MaterialPageRoute(builder: (context) => SigninScreen()),
                                      );
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              CustomTextField(
                                hintText: 'Lois Becket',
                                controller: fullNameController,
                                title: 'Fullname',
                                height: 932,
                                width: 430,
                                borderColor: COLORs.borderColor,
                                focusedBorderColor: COLORs.blue1,
                                errorBorderColor: COLORs.blue1,
                                fieldType: TextFieldType.text,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: 'rayabadoor@gmail.com',
                                controller: emailController,
                                title: 'Email',
                                height: 932,
                                width: 430,
                                borderColor: COLORs.borderColor,
                                focusedBorderColor: COLORs.blue1,
                                errorBorderColor: COLORs.blue1,
                                fieldType: TextFieldType.text,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: '18/02/2024',
                                controller: birthDateController,
                                title: 'Birth of date',
                                height: 932,
                                width: 430,
                                borderColor: COLORs.borderColor,
                                focusedBorderColor: COLORs.blue1,
                                errorBorderColor: COLORs.blue1,
                                fieldType: TextFieldType.date,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: '+962771234567', // Initial hint text, will be overridden by dynamic hint
                                controller: phoneNumberController,
                                title: 'Phone Number',
                                height: 932,
                                width: 430,
                                borderColor: COLORs.borderColor,
                                focusedBorderColor: COLORs.blue1,
                                errorBorderColor: COLORs.blue1,
                                fieldType: TextFieldType.phone,
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                hintText: '••••••••',
                                controller: passwordController,
                                title: 'Set Password',
                                height: 932,
                                width: 430,
                                borderColor: COLORs.borderColor,
                                focusedBorderColor: COLORs.blue1,
                                errorBorderColor: COLORs.blue1,
                                isPassword: true,
                                fieldType: TextFieldType.text,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          BlocBuilder<SignUpCubit, SignUpState>(
                            builder: (context, state) {
                              return CustomButton(
                                buttonName: state is LoadingSignUpState ? "Registering..." : "Register",
                                onTap: () {
                                  final fullName = fullNameController.text.trim();
                                  final email = emailController.text.trim();
                                  final birthDate = birthDateController.text.trim();
                                  final phoneNumber = phoneNumberController.text.trim();
                                  final password = passwordController.text.trim();
                                  final validationCubit = context.read<ValidationCubit>();
                                  final countryCode = phoneNumber.startsWith('+962') ? 'JO' : phoneNumber.startsWith('+970') ? 'PS' : '';

                                  // Check if any field is empty
                                  if (fullName.isEmpty &&
                                      email.isEmpty &&
                                      birthDate.isEmpty &&
                                      phoneNumber.isEmpty &&
                                      password.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'All fields are required, please fill them',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Individual empty field checks
                                  if (fullName.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Please enter your full name',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }
                                  if (email.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Please enter your email',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }
                                  if (birthDate.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Please select your date of birth',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }
                                  if (phoneNumber.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Please enter your phone number',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }
                                  if (password.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Please enter your password',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Validate inputs
                                  validationCubit.validateEmail(email: email);
                                  validationCubit.validatePhoneNumber(phoneNumber: phoneNumber);
                                  validationCubit.validatePassword(password: password);

                                  if (!validationCubit.isEmailValid) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Enter a valid email',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  if (!RegExp(phoneNumber.startsWith('+962')
                                      ? r'^\+962(77|78|79)\d{7}$'
                                      : r'^\+970(59|56|57)\d{7}$')
                                      .hasMatch(phoneNumber)) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Enter a valid phone number for ${phoneNumber.startsWith('+962') ? 'Jordan (+96277/78/79xxxxxxx)' : 'Palestine (+97059/56/57xxxxxxx)'}',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  if (!validationCubit.isPasswordValid) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Signup Error',
                                        msg: 'Please enter a strong password',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // If all validations pass, proceed with signup
                                  context.read<SignUpCubit>().signUpUser(
                                    fullName: fullName,
                                    email: email,
                                    birthDate: birthDate,
                                    phoneNumber: phoneNumber,
                                    password: password,
                                    countryCode: countryCode,
                                  );
                                },
                              );
                            },
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

  Widget _buildBottomSheet({required String title, required String msg, required String imagePath}) {
    return MsgBottomSheet(
      msg: msg,
      title: title,
      imagePath: imagePath,
      color: COLORs.blue1,
    );
  }
}