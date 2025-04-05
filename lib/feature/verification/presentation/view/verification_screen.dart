import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:foodtek_app/core/constants/svg.dart';
import 'package:foodtek_app/core/utils/responsive.dart';
import 'package:foodtek_app/feature/reset_password/presentation/view/reset_password_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:foodtek_app/core/constants/png.dart';
import '../../../../core/presentation/bottom_sheet/msg_bottom_sheet.dart';
import '../../../../core/presentation/button/custom_button.dart';
import '../cubit/verification_cubit.dart';
import '../state/verification_state.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController enterVerifyNumber = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(validationRepository: context.read()),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: responsiveWidth(context, 430),
              height: responsiveHeight(context, 932),
              child: Image.asset(
                PNGs.verificationBackground,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: responsiveWidth(context, 430),
              height: responsiveHeight(context, 932),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: responsiveHeight(context, 150)),
                  Container(
                    margin: const EdgeInsets.only(top: 150),
                    padding: const EdgeInsets.all(24),
                    width: responsiveWidth(context, 343),
                    decoration: BoxDecoration(
                      color: COLORs.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BlocListener<VerificationCubit, VerificationState>(
                      listener: (context, state) {
                        if (state is ErrorVerificationState) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => _buildBottomSheet(
                              title: 'Verification Error',
                              msg: state.message,
                              imagePath: SVGs.wrong,
                            ),
                          );
                        } else if (state is GetVerificationState) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                          );
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            PNGs.verification,
                            width: responsiveWidth(context, 150),
                            height: responsiveHeight(context, 150),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'A 4-digit code has been sent to your email.\nPlease enter it to verify.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 1.4,
                              letterSpacing: -0.01,
                              color: COLORs.darkgray,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: responsiveWidth(context, 382),
                            child: PinCodeTextField(
                              controller: enterVerifyNumber,
                              focusNode: pinFocusNode,
                              appContext: context,
                              length: 4,
                              keyboardType: TextInputType.number,
                              textStyle: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.w800,
                                fontSize: responsiveWidth(context, 32),
                                height: 1.3,
                                color: COLORs.blue1,
                              ),
                              onChanged: (value) {
                                // Optionally handle real-time validation here if needed
                              },
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: responsiveHeight(context, 46),
                                fieldWidth: responsiveWidth(context, 50.50),
                                fieldOuterPadding: EdgeInsets.symmetric(
                                  horizontal: responsiveWidth(context, 34 / 3),
                                ),
                                inactiveColor: COLORs.whitef4,
                                activeColor: COLORs.blue1,
                                selectedColor: COLORs.blue1,
                                inactiveFillColor: COLORs.whitef4,
                                activeFillColor: COLORs.whitef4,
                                selectedFillColor: COLORs.grey,
                                borderWidth: 1.5,
                              ),
                              enableActiveFill: true,
                            ),
                          ),
                          const SizedBox(height: 24),
                          BlocBuilder<VerificationCubit, VerificationState>(
                            builder: (context, state) {
                              return CustomButton(
                                buttonName: state is LoadingVerificationState ? "Verifying..." : "Verify",
                                onTap: () {
                                  final code = enterVerifyNumber.text.trim();

                                  // Check if code is empty or less than 4 digits
                                  if (code.isEmpty || code.length < 4) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => _buildBottomSheet(
                                        title: 'Verification Error',
                                        msg: 'Please enter the OTP code',
                                        imagePath: SVGs.wrong,
                                      ),
                                    );
                                    return;
                                  }

                                  // If code is 4 digits, proceed with verification
                                  context.read<VerificationCubit>().verifyCode(code: code);
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