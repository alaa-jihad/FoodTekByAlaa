import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/validation/domain/repositories/validation_repository.dart';

import '../state/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ValidationRepository validationRepository;

  ForgetPasswordCubit({required this.validationRepository}) : super(InitialForgetPasswordState());

  Future<void> sendResetLink({required String email}) async {
    emit(LoadingForgetPasswordState());

    try {
      // Simulate sending a reset link (replace with actual API call if needed)
      await Future.delayed(Duration(seconds: 1)); // Simulated delay
      emit(GetForgetPasswordState());
    } catch (e) {
      emit(ErrorForgetPasswordState('Failed to send reset link: ${e.toString()}'));
    }
  }
}