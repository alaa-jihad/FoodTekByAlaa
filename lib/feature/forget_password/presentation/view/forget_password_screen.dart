import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/presentation/widget/custom_textfield.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/core/validation/presentation/cubit/validation_cubit.dart';
import 'package:foodtek_app/feature/sign_in/presentation/view/signin_screen.dart';
import 'package:foodtek_app/feature/verification/presentation/view/verification_screen.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import '../../../../core/presentation/bottom_sheet/msg_bottom_sheet.dart';
import '../../../../core/presentation/button/custom_button.dart';
import '../cubit/forget_password-cubit.dart';
import '../state/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ForgetPasswordCubit>(
          create: (_) => ForgetPasswordCubit(validationRepository: context.read()),
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
                    margin: const EdgeInsets.only(top: 150),
                    padding: const EdgeInsets.all(24),
                    width: responsiveWidth(context, 343),
                    decoration: BoxDecoration(
                      color: COLORs.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
                      listener: (context, state) {
                        if (state is ErrorForgetPasswordState) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildBottomSheet(
                              title: 'Reset Error',
                              msg: state.message,
                              imagePath: SVGs.wrong,
                            ),
                          );
                        } else if (state is GetForgetPasswordState) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => VerificationScreen()),
                          );
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              SizedBox(width: responsiveWidth(context, 5)),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Back to ",
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
                                      text: "Login ",
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
                                    TextSpan(
                                      text: "page?",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        height: 1.4,
                                        letterSpacing: -0.01,
                                        color: COLORs.darkgray,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: responsiveHeight(context, 16)),
                          Center(
                            child: Text(
                              'Reset Password',
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
                          SizedBox(height: responsiveHeight(context, 12)),
                          Center(
                            child: Text(
                              "Enter your E-mail or phone and we'll\n send you a link to get back into\n your account",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.4,
                                letterSpacing: -0.01,
                                color: COLORs.darkgray,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: 'losekbet@gmail.com',
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
                          BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                            builder: (context, state) {
                              return CustomButton(
                                buttonName: state is LoadingForgetPasswordState ? "Sending..." : "Send",
                                onTap: () {
                                  final email = emailController.text.trim();
                                  final validationCubit = context.read<ValidationCubit>();

                                  // Check if email is empty
                                  if (email.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'Please enter your email',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Validate email
                                  validationCubit.validateEmail(email: email);
                                  if (!validationCubit.isEmailValid) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'Enter a valid email',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // If email is valid, proceed with sending reset link
                                  context.read<ForgetPasswordCubit>().sendResetLink(email: email);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 15),
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