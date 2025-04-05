import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/presentation/widget/custom_textfield.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/core/validation/presentation/cubit/validation_cubit.dart';
import 'package:foodtek_app/feature/reset_password/presentation/view/update_password_screen.dart';
import 'package:foodtek_app/feature/sign_in/presentation/view/signin_screen.dart';
import 'package:foodtek_app/core/constants/png.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import '../../../../core/presentation/bottom_sheet/msg_bottom_sheet.dart';
import '../../../../core/presentation/button/custom_button.dart';
import '../cubit/reset_password_cubit.dart';
import '../state/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ResetPasswordCubit>(
          create: (_) => ResetPasswordCubit(validationRepository: context.read()),
        ),
        BlocProvider<ValidationCubit>(
          create: (_) => ValidationCubit(validationRepository: context.read()),
        ),
      ],
      child: Material(
        child: Stack(
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
                  SizedBox(height: responsiveHeight(context, 55)),
                  Image.asset(
                    PNGs.foodtecLogoPng,
                    width: responsiveWidth(context, 307),
                    height: responsiveHeight(context, 85),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 75),
                    padding: const EdgeInsets.all(24),
                    width: responsiveWidth(context, 343),
                    decoration: BoxDecoration(
                      color: COLORs.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
                      listener: (context, state) {
                        if (state is ErrorResetPasswordState) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildBottomSheet(
                              title: 'Reset Error',
                              msg: state.message,
                              imagePath: SVGs.wrong,
                            ),
                          );
                        } else if (state is GetResetPasswordState) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const UpdatePasswordScreen()),
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
                          SizedBox(height: responsiveHeight(context, 12)),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Want to try with my current password? ",
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
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: '••••••••',
                            isPassword: true,
                            controller: newPasswordController,
                            title: 'New Password',
                            height: 932,
                            width: 430,
                            borderColor: COLORs.borderColor,
                            focusedBorderColor: COLORs.blue1,
                            errorBorderColor: COLORs.blue1,
                            fieldType: TextFieldType.text,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            hintText: '••••••••',
                            isPassword: true,
                            controller: confirmPasswordController,
                            title: 'Confirm New Password',
                            height: 932,
                            width: 430,
                            borderColor: COLORs.borderColor,
                            focusedBorderColor: COLORs.blue1,
                            errorBorderColor: COLORs.blue1,
                            fieldType: TextFieldType.text,
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                            builder: (context, state) {
                              return CustomButton(
                                buttonName: state is LoadingResetPasswordState ? "Updating..." : "Update Password",
                                onTap: () {
                                  final newPassword = newPasswordController.text.trim();
                                  final confirmPassword = confirmPasswordController.text.trim();
                                  final validationCubit = context.read<ValidationCubit>();

                                  // Check if both fields are empty
                                  if (newPassword.isEmpty && confirmPassword.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'Please enter the new password and the confirm password',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Check if new password is empty
                                  if (newPassword.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'Please enter the new password',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Check if confirm password is empty
                                  if (confirmPassword.isEmpty) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'Please enter the confirm password',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Validate passwords
                                  validationCubit.validatePassword(password: newPassword);
                                  validationCubit.validatePassword(password: confirmPassword); // Validate confirm password too

                                  // Check if new password is valid
                                  if (!validationCubit.isPasswordValid) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'Please enter a strong new password',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Check if confirm password is valid (redundant since same regex, but included for clarity)
                                  if (!validationCubit.isPasswordValid) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'Please enter a strong confirm password',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // Check if passwords match
                                  if (newPassword != confirmPassword) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Reset Error',
                                        msg: 'The passwords don\'t match',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // If all validations pass, proceed with resetting password
                                  context.read<ResetPasswordCubit>().resetPassword(
                                    newPassword: newPassword,
                                    confirmPassword: confirmPassword,
                                  );
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
                      margin: const EdgeInsets.only(bottom: 7.81),
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