abstract class SignInState {}

class InitialSignInState extends SignInState {}

class GetSignInByUserState extends SignInState {}

class LoadingSignInState extends SignInState {}

// class LoadedSignInState extends SignInState {
//   final SignInModel signInByUser;
//
//   LoadedSignInState(this.signInByUser);
// }

class ErrorSignInState extends SignInState {
  final String message;

  ErrorSignInState(this.message);
}