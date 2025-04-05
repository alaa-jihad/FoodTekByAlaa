import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/validation/domain/repositories/validation_repository.dart';

import '../state/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ValidationRepository validationRepository;

  ResetPasswordCubit({required this.validationRepository}) : super(InitialResetPasswordState());

  Future<void> resetPassword({required String newPassword, required String confirmPassword}) async {
    emit(LoadingResetPasswordState());

    try {
      // Simulate resetting the password (replace with actual API call if needed)
      await Future.delayed(Duration(seconds: 1)); // Simulated delay
      emit(GetResetPasswordState());
    } catch (e) {
      emit(ErrorResetPasswordState('Failed to reset password: ${e.toString()}'));
    }
  }
}