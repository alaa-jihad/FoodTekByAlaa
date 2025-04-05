import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_app/core/validation/domain/repositories/validation_repository.dart';

import '../state/verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final ValidationRepository validationRepository;

  VerificationCubit({required this.validationRepository}) : super(InitialVerificationState());

  Future<void> verifyCode({required String code}) async {
    emit(LoadingVerificationState());

    try {
      // Simulate verifying the code (replace with actual API call if needed)
      await Future.delayed(Duration(seconds: 1)); // Simulated delay
      emit(GetVerificationState());
    } catch (e) {
      emit(ErrorVerificationState('Failed to verify code: ${e.toString()}'));
    }
  }
}