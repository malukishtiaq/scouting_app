/// Validation result for settings
class ValidationResult {
  final bool isValid;
  final List<ValidationError> errors;
  final List<ValidationWarning> warnings;

  const ValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });

  /// Get error messages as strings
  List<String> get errorMessages => errors.map((e) => e.message).toList();

  /// Get warning messages as strings
  List<String> get warningMessages => warnings.map((w) => w.message).toList();

  /// Check if there are any errors
  bool get hasErrors => errors.isNotEmpty;

  /// Check if there are any warnings
  bool get hasWarnings => warnings.isNotEmpty;
}

/// Validation error
class ValidationError {
  final String field;
  final String message;
  final ValidationSeverity severity;

  const ValidationError({
    required this.field,
    required this.message,
    this.severity = ValidationSeverity.error,
  });
}

/// Validation warning
class ValidationWarning {
  final String message;
  final String? suggestion;

  const ValidationWarning({
    required this.message,
    this.suggestion,
  });
}

/// Validation severity levels
enum ValidationSeverity {
  error,
  warning,
  info,
}

/// Settings validator
class SettingsValidator {
  /// Validate user preferences
  ValidationResult validateUserPreferences(dynamic preferences) {
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];

    if (preferences == null) {
      errors.add(const ValidationError(
        field: 'preferences',
        message: 'Preferences cannot be null',
      ));
      return ValidationResult(isValid: false, errors: errors, warnings: warnings);
    }

    // Basic validation - in a real app, this would be more comprehensive
    if (preferences is Map<String, dynamic>) {
      // Check required fields
      if (!preferences.containsKey('userId')) {
        errors.add(const ValidationError(
          field: 'userId',
          message: 'User ID is required',
        ));
      }

      // Check version
      if (preferences.containsKey('version')) {
        final version = preferences['version'];
        if (version is int && version < 1) {
          errors.add(const ValidationError(
            field: 'version',
            message: 'Version must be at least 1',
          ));
        }
      }
    } else {
      errors.add(const ValidationError(
        field: 'preferences',
        message: 'Preferences must be a valid object',
      ));
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  /// Validate a specific field
  ValidationResult validateField(String field, dynamic value, String fieldType) {
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];

    switch (fieldType.toLowerCase()) {
      case 'fontsize':
        if (value is num) {
          if (value < 10.0 || value > 24.0) {
            errors.add(ValidationError(
              field: field,
              message: 'Font size must be between 10.0 and 24.0',
            ));
          }
        } else {
          errors.add(ValidationError(
            field: field,
            message: 'Font size must be a number',
          ));
        }
        break;

      case 'sessiontimeout':
        if (value is int) {
          if (value < 5 || value > 1440) {
            errors.add(ValidationError(
              field: field,
              message: 'Session timeout must be between 5 and 1440 minutes',
            ));
          }
        } else {
          errors.add(ValidationError(
            field: field,
            message: 'Session timeout must be an integer',
          ));
        }
        break;

      case 'theme':
        if (value is String) {
          final validThemes = ['light', 'dark', 'system'];
          if (!validThemes.contains(value.toLowerCase())) {
            errors.add(ValidationError(
              field: field,
              message: 'Theme must be one of: ${validThemes.join(', ')}',
            ));
          }
        } else {
          errors.add(ValidationError(
            field: field,
            message: 'Theme must be a string',
          ));
        }
        break;

      case 'timeformat':
        if (value is String) {
          final validFormats = ['12h', '24h'];
          if (!validFormats.contains(value)) {
            errors.add(ValidationError(
              field: field,
              message: 'Time format must be either "12h" or "24h"',
            ));
          }
        } else {
          errors.add(ValidationError(
            field: field,
            message: 'Time format must be a string',
          ));
        }
        break;

      case 'visibility':
        if (value is String) {
          final validOptions = ['public', 'friends', 'private'];
          if (!validOptions.contains(value.toLowerCase())) {
            errors.add(ValidationError(
              field: field,
              message: 'Visibility must be one of: ${validOptions.join(', ')}',
            ));
          }
        } else {
          errors.add(ValidationError(
            field: field,
            message: 'Visibility must be a string',
          ));
        }
        break;

      case 'boolean':
        if (value is! bool) {
          errors.add(ValidationError(
            field: field,
            message: 'Value must be true or false',
          ));
        }
        break;

      case 'string':
        if (value is! String) {
          errors.add(ValidationError(
            field: field,
            message: 'Value must be a string',
          ));
        }
        break;

      case 'number':
        if (value is! num) {
          errors.add(ValidationError(
            field: field,
            message: 'Value must be a number',
          ));
        }
        break;

      case 'list':
        if (value is! List) {
          errors.add(ValidationError(
            field: field,
            message: 'Value must be a list',
          ));
        }
        break;

      default:
        // No specific validation for this field type
        break;
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  /// Validate time format (HH:MM)
  bool isValidTimeFormat(String time) {
    final timeRegex = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
    return timeRegex.hasMatch(time);
  }

  /// Validate hex color format
  bool isValidHexColor(String color) {
    final hexRegex = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$');
    return hexRegex.hasMatch(color);
  }

  /// Validate language code format
  bool isValidLanguageCode(String code) {
    final langRegex = RegExp(r'^[a-z]{2}(-[A-Z]{2})?$');
    return langRegex.hasMatch(code);
  }
}
