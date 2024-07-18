// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String TodoValueKey = 'todo';
const String UserIdValueKey = 'userId';

final Map<String, TextEditingController> _AddTaskViewTextEditingControllers =
    {};

final Map<String, FocusNode> _AddTaskViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AddTaskViewTextValidations = {
  TodoValueKey: null,
  UserIdValueKey: null,
};

mixin $AddTaskView {
  TextEditingController get todoController =>
      _getFormTextEditingController(TodoValueKey);
  TextEditingController get userIdController =>
      _getFormTextEditingController(UserIdValueKey);

  FocusNode get todoFocusNode => _getFormFocusNode(TodoValueKey);
  FocusNode get userIdFocusNode => _getFormFocusNode(UserIdValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddTaskViewTextEditingControllers.containsKey(key)) {
      return _AddTaskViewTextEditingControllers[key]!;
    }

    _AddTaskViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddTaskViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddTaskViewFocusNodes.containsKey(key)) {
      return _AddTaskViewFocusNodes[key]!;
    }
    _AddTaskViewFocusNodes[key] = FocusNode();
    return _AddTaskViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    todoController.addListener(() => _updateFormData(model));
    userIdController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    todoController.addListener(() => _updateFormData(model));
    userIdController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TodoValueKey: todoController.text,
          UserIdValueKey: userIdController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddTaskViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddTaskViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AddTaskViewTextEditingControllers.clear();
    _AddTaskViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get todoValue => this.formValueMap[TodoValueKey] as String?;
  String? get userIdValue => this.formValueMap[UserIdValueKey] as String?;

  set todoValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TodoValueKey: value}),
    );

    if (_AddTaskViewTextEditingControllers.containsKey(TodoValueKey)) {
      _AddTaskViewTextEditingControllers[TodoValueKey]?.text = value ?? '';
    }
  }

  set userIdValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UserIdValueKey: value}),
    );

    if (_AddTaskViewTextEditingControllers.containsKey(UserIdValueKey)) {
      _AddTaskViewTextEditingControllers[UserIdValueKey]?.text = value ?? '';
    }
  }

  bool get hasTodo =>
      this.formValueMap.containsKey(TodoValueKey) &&
      (todoValue?.isNotEmpty ?? false);
  bool get hasUserId =>
      this.formValueMap.containsKey(UserIdValueKey) &&
      (userIdValue?.isNotEmpty ?? false);

  bool get hasTodoValidationMessage =>
      this.fieldsValidationMessages[TodoValueKey]?.isNotEmpty ?? false;
  bool get hasUserIdValidationMessage =>
      this.fieldsValidationMessages[UserIdValueKey]?.isNotEmpty ?? false;

  String? get todoValidationMessage =>
      this.fieldsValidationMessages[TodoValueKey];
  String? get userIdValidationMessage =>
      this.fieldsValidationMessages[UserIdValueKey];
}

extension Methods on FormStateHelper {
  setTodoValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TodoValueKey] = validationMessage;
  setUserIdValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UserIdValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    todoValue = '';
    userIdValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TodoValueKey: getValidationMessage(TodoValueKey),
      UserIdValueKey: getValidationMessage(UserIdValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddTaskViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddTaskViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      TodoValueKey: getValidationMessage(TodoValueKey),
      UserIdValueKey: getValidationMessage(UserIdValueKey),
    });
