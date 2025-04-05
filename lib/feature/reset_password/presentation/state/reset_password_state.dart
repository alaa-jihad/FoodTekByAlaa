abstract class ResetPasswordState {}

class InitialResetPasswordState extends ResetPasswordState {}

class GetResetPasswordState extends ResetPasswordState {}

class LoadingResetPasswordState extends ResetPasswordState {}

// class LoadedResetPasswordState extends ResetPasswordState {
//   final ResetPasswordModel resetPassword;
//
//   LoadedResetPasswordState(this.resetPassword);
// }

class ErrorResetPasswordState extends ResetPasswordState {
  final String message;

  ErrorResetPasswordState(this.message);
}