abstract class ForgetPasswordState {}

class InitialForgetPasswordState extends ForgetPasswordState {}

class GetForgetPasswordState extends ForgetPasswordState {}

class LoadingForgetPasswordState extends ForgetPasswordState {}

// class LoadedForgetPasswordState extends ForgetPasswordState {
//   final ForgetPasswordModel forgetPassword;
//
//   LoadedForgetPasswordState(this.forgetPassword);
// }

class ErrorForgetPasswordState extends ForgetPasswordState {
  final String message;

  ErrorForgetPasswordState(this.message);
}