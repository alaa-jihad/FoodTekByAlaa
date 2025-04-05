import '../entities/validation_model.dart';

abstract class ValidationRepository {
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
    String? countryCode,
  });

  Future<void> saveValidationState(ValidationModel validationModel);
  Future<ValidationModel> loadValidationState();
}