import 'package:equatable/equatable.dart';

class ValidationModel extends Equatable {
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final bool isRequiredPasswordValid;
  final bool isNameValid;
  final bool isRetypePasswordValid;
  final bool isBioValid;
  final bool isCodeValid;
  final List<bool> checklistStates;

  const ValidationModel({
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

  ValidationModel copyWith({
    bool? isEmailValid,
    bool? isPhoneValid,
    bool? isPasswordValid,
    bool? isRequiredPasswordValid,
    bool? isNameValid,
    bool? isRetypePasswordValid,
    bool? isBioValid,
    bool? isCodeValid,
    List<bool>? checklistStates,
  }) {
    return ValidationModel(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isRequiredPasswordValid: isRequiredPasswordValid ?? this.isRequiredPasswordValid,
      isNameValid: isNameValid ?? this.isNameValid,
      isRetypePasswordValid: isRetypePasswordValid ?? this.isRetypePasswordValid,
      isBioValid: isBioValid ?? this.isBioValid,
      isCodeValid: isCodeValid ?? this.isCodeValid,
      checklistStates: checklistStates ?? List.from(this.checklistStates),
    );
  }

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