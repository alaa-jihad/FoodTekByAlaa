abstract class VerificationState {}

class InitialVerificationState extends VerificationState {}

class GetVerificationState extends VerificationState {}

class LoadingVerificationState extends VerificationState {}

// class LoadedVerificationState extends VerificationState {
//   final VerificationModel verification;
//
//   LoadedVerificationState(this.verification);
// }

class ErrorVerificationState extends VerificationState {
  final String message;

  ErrorVerificationState(this.message);
}