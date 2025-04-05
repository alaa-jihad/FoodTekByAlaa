import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/validation_model.dart';
import '../../domain/repositories/validation_repository.dart';
import '../state/validation_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  final ValidationRepository validationRepository;

  ValidationCubit({required this.validationRepository}) : super(InitialValidationState()) {
    _loadInitialState();
  }

  // Private validation states
  bool _isEmailValid = false;
  bool _isPhoneValid = false;
  bool _isPasswordValid = false;
  bool _isRequiredPasswordValid = true;
  bool _isNameValid = false;
  bool _isRetypePasswordValid = false;
  bool _isBioValid = false;
  bool _isCodeValid = true; // Default to true until validated
  List<bool> _checklistStates = List.generate(6, (index) => false);

  // Public getters
  bool get isEmailValid => _isEmailValid;
  bool get isPhoneValid => _isPhoneValid;
  bool get isPasswordValid => _isPasswordValid;
  bool get isRequiredPasswordValid => _isRequiredPasswordValid;
  bool get isNameValid => _isNameValid;
  bool get isRetypePasswordValid => _isRetypePasswordValid;
  bool get isBioValid => _isBioValid;
  bool get isCodeValid => _isCodeValid;
  List<bool> get checklistStates => List.from(_checklistStates);

  Future<void> _loadInitialState() async {
    final savedState = await validationRepository.loadValidationState();
    _isEmailValid = savedState.isEmailValid;
    _isPhoneValid = savedState.isPhoneValid;
    _isPasswordValid = savedState.isPasswordValid;
    _isRequiredPasswordValid = savedState.isRequiredPasswordValid;
    _isNameValid = savedState.isNameValid;
    _isRetypePasswordValid = savedState.isRetypePasswordValid;
    _isBioValid = savedState.isBioValid;
    _isCodeValid = savedState.isCodeValid;
    _checklistStates = savedState.checklistStates;
    emitValidatedState();
  }

  void validateEmail({required String email}) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    _isEmailValid = regExp.hasMatch(email);
    emitValidatedState();
    _saveState();
  }

  void validatePhoneNumber({required String phoneNumber}) {
    String pattern = r'^(050|053|054|055|056|057|058|059)\d{7}$';
    RegExp regExp = RegExp(pattern);
    _isPhoneValid = regExp.hasMatch(phoneNumber);
    emitValidatedState();
    _saveState();
  }

  void validatePassword({required String password}) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~%]).{8,}$';
    RegExp regExp = RegExp(pattern);
    _isPasswordValid = regExp.hasMatch(password);
    emitValidatedState();
    _saveState();
  }

  void validateRequiredPassword({required String requiredPassword}) {
    _isRequiredPasswordValid = requiredPassword.isNotEmpty;
    emitValidatedState();
    _saveState();
  }

  void validateCode({required String code}) {
    _isCodeValid = code.isNotEmpty && code.length == 4 && RegExp(r'^\d{4}$').hasMatch(code); // Ensure 4 digits
    emitValidatedState();
    _saveState();
  }

  void validateRetypePassword({required String password, required String retypePassword}) {
    _isRetypePasswordValid = retypePassword.isNotEmpty && password == retypePassword;
    emitValidatedState();
    _saveState();
  }

  void emitValidatedState() {
    emit(ValidatedState(
      isEmailValid: _isEmailValid,
      isPhoneValid: _isPhoneValid,
      isPasswordValid: _isPasswordValid,
      isRequiredPasswordValid: _isRequiredPasswordValid,
      isNameValid: _isNameValid,
      isRetypePasswordValid: _isRetypePasswordValid,
      isBioValid: _isBioValid,
      isCodeValid: _isCodeValid,
      checklistStates: List.from(_checklistStates),
    ));
  }

  void emitErrorState(String message) {
    emit(ErrorValidationState(message));
  }

  Future<void> _saveState() async {
    final state = ValidationModel(
      isEmailValid: _isEmailValid,
      isPhoneValid: _isPhoneValid,
      isPasswordValid: _isPasswordValid,
      isRequiredPasswordValid: _isRequiredPasswordValid,
      isNameValid: _isNameValid,
      isRetypePasswordValid: _isRetypePasswordValid,
      isBioValid: _isBioValid,
      isCodeValid: _isCodeValid,
      checklistStates: _checklistStates,
    );
    await validationRepository.saveValidationState(state);
  }
}