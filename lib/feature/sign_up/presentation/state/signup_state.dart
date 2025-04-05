abstract class SignUpState {}

class InitialSignUpState extends SignUpState {}

class GetSignUpByUserState extends SignUpState {}

class LoadingSignUpState extends SignUpState {}

// class LoadedSignUpState extends SignUpState {
//   final SignUpModel signUpByUser;
//
//   LoadedSignUpState(this.signUpByUser);
// }

class ErrorSignUpState extends SignUpState {
  final String message;

  ErrorSignUpState(this.message);
}