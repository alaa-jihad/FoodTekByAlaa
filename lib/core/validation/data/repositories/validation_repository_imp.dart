import '../../../constants/app_constants.dart';
import '../../../utils/secure_storage_helper.dart';
import '../../domain/entities/validation_model.dart';
import '../../domain/repositories/validation_repository.dart';
import 'dart:convert';

class ValidationRepositoryImpl implements ValidationRepository {
  @override
  Future<ValidationModel> validate({
    String? email,
    String? phoneNumber,
    String? password,
    String? requiredPassword,
    String? name,
    String? retypePassword,
    String? bio,
    String? code,
    int? checklistIndex,
    String? countryCode, // Add country code parameter
  }) async {
    bool isEmailValid = email != null &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email);

    bool isPhoneValid = false;
    if (phoneNumber != null && countryCode != null) {
      if (countryCode == 'JO') { // Jordan
        isPhoneValid = RegExp(r'^\+962(77|78|79)\d{7}$').hasMatch(phoneNumber);
      } else if (countryCode == 'PS') { // Palestine
        isPhoneValid = RegExp(r'^\+970(59|56|57)\d{7}$').hasMatch(phoneNumber);
      }
    }

    bool isPasswordValid = password != null &&
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~%]).{8,}$').hasMatch(password);
    bool isRequiredPasswordValid = requiredPassword != null && requiredPassword.isNotEmpty;
    bool isNameValid = name != null && name.isNotEmpty;
    bool isRetypePasswordValid = retypePassword != null && password != null && retypePassword == password;
    bool isBioValid = bio != null && bio.isNotEmpty;
    bool isCodeValid = code != null && code.isNotEmpty;

    List<bool> checklistStates = List.generate(6, (index) => false);
    if (checklistIndex != null && checklistIndex >= 0 && checklistIndex < 6) {
      checklistStates = List.from(checklistStates)..[checklistIndex] = !checklistStates[checklistIndex];
    }

    return ValidationModel(
      isEmailValid: isEmailValid,
      isPhoneValid: isPhoneValid,
      isPasswordValid: isPasswordValid,
      isRequiredPasswordValid: isRequiredPasswordValid,
      isNameValid: isNameValid,
      isRetypePasswordValid: isRetypePasswordValid,
      isBioValid: isBioValid,
      isCodeValid: isCodeValid,
      checklistStates: checklistStates,
    );
  }
  @override
  Future<void> saveValidationState(ValidationModel validationModel) async {
    await SecureStorageHelper().savePrefString(
      key: AppConstants.VALIDATION_STATE_KEY,
      value: jsonEncode({
        'isEmailValid': validationModel.isEmailValid,
        'isPhoneValid': validationModel.isPhoneValid,
        'isPasswordValid': validationModel.isPasswordValid,
        'isRequiredPasswordValid': validationModel.isRequiredPasswordValid,
        'isNameValid': validationModel.isNameValid,
        'isRetypePasswordValid': validationModel.isRetypePasswordValid,
        'isBioValid': validationModel.isBioValid,
        'isCodeValid': validationModel.isCodeValid,
        'checklistStates': validationModel.checklistStates,
      }),
    );
  }

  @override
  Future<ValidationModel> loadValidationState() async {
    String? jsonString = await SecureStorageHelper().getPrefString(
      key: AppConstants.VALIDATION_STATE_KEY,
      defaultValue: '',
    );
    if (jsonString!.isNotEmpty) {
      Map<String, dynamic> map = jsonDecode(jsonString);
      return ValidationModel(
        isEmailValid: map['isEmailValid'] as bool? ?? false,
        isPhoneValid: map['isPhoneValid'] as bool? ?? false,
        isPasswordValid: map['isPasswordValid'] as bool? ?? false,
        isRequiredPasswordValid: map['isRequiredPasswordValid'] as bool? ?? true,
        isNameValid: map['isNameValid'] as bool? ?? false,
        isRetypePasswordValid: map['isRetypePasswordValid'] as bool? ?? false,
        isBioValid: map['isBioValid'] as bool? ?? false,
        isCodeValid: map['isCodeValid'] as bool? ?? true,
        checklistStates: (map['checklistStates'] as List<dynamic>?)?.cast<bool>() ?? List.generate(6, (index) => false),
      );
    }
    return ValidationModel(
      isEmailValid: false,
      isPhoneValid: false,
      isPasswordValid: false,
      isRequiredPasswordValid: true,
      isNameValid: false,
      isRetypePasswordValid: false,
      isBioValid: false,
      isCodeValid: true,
      checklistStates: List.generate(6, (index) => false),
    );
  }
}