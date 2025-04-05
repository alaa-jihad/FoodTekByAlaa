import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(InitialSignInState());

  void signInUser({required String email, required String password}) {
    emit(LoadingSignInState());
    try {
      Future.delayed(const Duration(seconds: 2), () {
        emit(GetSignInByUserState());
      });
    } catch (e) {
      emit(ErrorSignInState('Failed to sign in: $e'));
    }
  }
}