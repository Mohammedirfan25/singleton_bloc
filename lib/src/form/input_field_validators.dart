typedef InputFieldValidator<T> = String? Function(T? value);

class InputFieldValidators {
  /// Required field validator function that validates a value and returns
  /// the corresponding error message if it is NULL
  static InputFieldValidator<T> required<T>(String errorMessage) {
    return ((value) {
      if (value == null) {
        //just return the error message
        return errorMessage;
      } else if (value is String && value.isEmpty) {
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<String> email(String errorMessage) {
    return ((value) {
      if (value != null &&
          !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<String> alphanumeric(String errorMessage) {
    return (value) {
      if (value != null && !RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) {
        return errorMessage;
      }

      //No Error
      return null;
    };
  }

  static InputFieldValidator<String> url(String errorMessage) {
    return (value) {
      if (value != null &&
          !RegExp(r"^(http?|https):\/\/[^\s/$.?#].[^\s]*$",
                  caseSensitive: false, multiLine: false)
              .hasMatch(value)) {
        return errorMessage;
      }

      //No Error
      return null;
    };
  }

  static InputFieldValidator<String> phone(String errorMessage) {
    return (value) {
      if (value != null && !RegExp(r"^\+?[1-9][0-9]{7,14}$").hasMatch(value)) {
        return errorMessage;
      }

      //No Error
      return null;
    };
  }

  static InputFieldValidator<String> matchRegex(
      RegExp reg, String errorMessage) {
    return (value) {
      if (value != null && !reg.hasMatch(value)) {
        return errorMessage;
      }

      //No Error
      return null;
    };
  }

  static InputFieldValidator<int> minimum(int minimum, String errorMessage) {
    return ((value) {
      if (value != null && value < minimum) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<int> maximum(int maximum, String errorMessage) {
    return ((value) {
      if (value != null && value > maximum) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<String> minimumString(
      int minimum, String errorMessage) {
    return ((value) {
      if (value != null && value.length < minimum) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  static InputFieldValidator<String> maximumString(
      int maximum, String errorMessage) {
    return ((value) {
      if (value != null && value.length > maximum) {
        //just return the error message
        return errorMessage;
      }

      //No Error
      return null;
    });
  }

  ///Just compose a function which returns the Error Message if any
  ///of the validator returns an string message
  static InputFieldValidator<T> compose<T>(
      List<InputFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final errMsg = validator.call(valueCandidate);
        if (errMsg != null) {
          //There is an error Message. return that
          return errMsg;
        }
      }
      //No error
      return null;
    };
  }
}
