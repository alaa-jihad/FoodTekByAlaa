import 'package:equatable/equatable.dart';

abstract class ValidationState extends Equatable {
  const ValidationState();

  @override
  List<Object?> get props => [];
}

class InitialValidationState extends ValidationState {}

class LoadingValidationState extends ValidationState {}

class ValidatedState extends ValidationState {
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final bool isRequiredPasswordValid;
  final bool isNameValid;
  final bool isRetypePasswordValid;
  final bool isBioValid;
  final bool isCodeValid;
  final List<bool> checklistStates;

  const ValidatedState({
    required this.isEmailValid,
    required this.isPhoneValid,
    required this.isPasswordValid,
    required this.isRequiredPasswordValid,
    required this.isNameValid,
    required this.isRetypePasswordValid,
    required this.isBioValid,
    required this.isCodeValid,
    required this.checklistStates,
  });

  @override
  List<Object?> get props => [
    isEmailValid,
    isPhoneValid,
    isPasswordValid,
    isRequiredPasswordValid,
    isNameValid,
    isRetypePasswordValid,
    isBioValid,
    isCodeValid,
    checklistStates,
  ];
}

class ErrorValidationState extends ValidationState {
  final String message;

  const ErrorValidationState(this.message);

  @override
  List<Object?> get props => [message];
}