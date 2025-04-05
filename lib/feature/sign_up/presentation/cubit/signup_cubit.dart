import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validation/domain/repositories/validation_repository.dart';
import '../state/signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final ValidationRepository validationRepository;

  SignUpCubit({required this.validationRepository}) : super(InitialSignUpState());

  Future<void> signUpUser({
    required String fullName,
    required String email,
    required String birthDate,
    required String phoneNumber,
    required String password,
    required String countryCode,
  }) async {
    emit(LoadingSignUpState());

    try {
      // Perform validation
      final validationModel = await validationRepository.validate(
        name: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        countryCode: countryCode,
      );

      if (validationModel.isNameValid &&
          validationModel.isEmailValid &&
          validationModel.isPhoneValid &&
          validationModel.isPasswordValid) {
        // Simulate a successful signup (replace with actual API call if needed)
        await Future.delayed(Duration(seconds: 1)); // Simulated delay
        emit(GetSignUpByUserState());
      } else {
        emit(ErrorSignUpState('Validation failed')); // This will be handled in the UI
      }
    } catch (e) {
      emit(ErrorSignUpState('Signup failed: ${e.toString()}'));
    }
  }
}