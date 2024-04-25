import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:singleton_bloc/src/form/input_field_validators.dart';

class MockInputFieldValidators extends Mock implements InputFieldValidators {}

void main() {
  group("Input Field Validators Test", () {
    test("required validator should return error in null or empty value", () {
      expect("This field is required",
          InputFieldValidators.required("This field is required").call(null));

      expect("This field is required",
          InputFieldValidators.required("This field is required").call(""));
    });

    test("required validator should return null on non-empty value", () {
      expect(
          null,
          InputFieldValidators.required("This field is required")
              .call("Testing"));
    });

    test("email validator should return error on empty value", () {
      expect("This field is required",
          InputFieldValidators.email("This field is required").call(""));
    });

    test("email validator should return error on incorrect email", () {
      expect(
          "Please enter a valid email",
          InputFieldValidators.email("Please enter a valid email")
              .call("example"));

      expect(
          "Please enter a valid email",
          InputFieldValidators.email("Please enter a valid email")
              .call("example@gmail"));
    });

    test("email validator should return null on correct email", () {
      expect(
          null,
          InputFieldValidators.email("Please enter a valid email")
              .call("example@gmail.com"));
    });

    test("alphanumeric validator should return error on empty value", () {
      expect("This field is required",
          InputFieldValidators.alphanumeric("This field is required").call(""));
    });

    test("alphanumeric validator should return error on special charecters",
        () {
      expect(
          "Please enter a valid alphanumeric",
          InputFieldValidators.alphanumeric("Please enter a valid alphanumeric")
              .call("Test@123\$+-/"));
    });

    test("alphanumeric validator should return null on correct alphanumeric",
        () {
      expect(
          null,
          InputFieldValidators.alphanumeric("Please enter a valid alphanumeric")
              .call("Test123"));
    });
  });

  test("url validator should return error on empty value", () {
    expect("This field is required",
        InputFieldValidators.url("This field is required").call(""));
  });

  test("url validator should return error on incorrect URL format", () {
    expect(
        "Please enter a valid URL",
        InputFieldValidators.url("Please enter a valid URL")
            .call("example.com"));

    expect(
        "Please enter a valid URL",
        InputFieldValidators.url("Please enter a valid URL")
            .call("http:/example.com"));
  });

  test("url validator should return null on correct URL format", () {
    expect(
        null,
        InputFieldValidators.url("Please enter a valid URL")
            .call("http://example.com"));
  });

  test("phone validator should return error on empty value", () {
    expect("This field is required",
        InputFieldValidators.phone("This field is required").call(""));
  });

  test("phone validator should return error on invalid phone format", () {
    expect(
        "Please enter a valid phone number",
        InputFieldValidators.phone("Please enter a valid phone number")
            .call("123"));

    expect(
        "Please enter a valid phone number",
        InputFieldValidators.phone("Please enter a valid phone number")
            .call("+12 34 567 890"));
  });

  test("phone validator should return null on correct phone format", () {
    expect(
        null,
        InputFieldValidators.phone("Please enter a valid phone number")
            .call("+1234567890"));
  });

  test("matchRegex validator should return error on mismatch", () {
    final validator = InputFieldValidators.matchRegex(
        RegExp(r"^\d{5}(?:[-\s]\d{4})?$"), "Invalid ZIP code");

    expect("Invalid ZIP code", validator.call("123"));
    expect("Invalid ZIP code", validator.call("123456"));
  });

  test("matchRegex validator should return null on match", () {
    final validator = InputFieldValidators.matchRegex(
        RegExp(r"^\d{5}(?:[-\s]\d{4})?$"), "Invalid ZIP code");

    expect(null, validator.call("12345"));
    expect(null, validator.call("12345-6789"));
  });

  test("minimum validator should return error when value is less than minimum",
      () {
    expect("Value must be at least 10",
        InputFieldValidators.minimum(10, "Value must be at least 10").call(5));
  });

  test("minimum validator should return null when value is equal to minimum",
      () {
    expect(null,
        InputFieldValidators.minimum(10, "Value must be at least 10").call(10));
  });

  test(
      "maximum validator should return error when value is greater than maximum",
      () {
    expect(
        "Value must be at most 100",
        InputFieldValidators.maximum(100, "Value must be at most 100")
            .call(150));
  });

  test("maximum validator should return null when value is equal to maximum",
      () {
    expect(
        null,
        InputFieldValidators.maximum(100, "Value must be at most 100")
            .call(100));
  });

  test(
      "minimumString validator should return error when length is less than minimum",
      () {
    expect(
        "Input must be at least 5 characters long",
        InputFieldValidators.minimumString(
                5, "Input must be at least 5 characters long")
            .call("123"));
  });

  test(
      "minimumString validator should return null when length is equal to minimum",
      () {
    expect(
        null,
        InputFieldValidators.minimumString(
                5, "Input must be at least 5 characters long")
            .call("12345"));
  });

  test(
      "maximumString validator should return error when length is greater than maximum",
      () {
    expect(
        "Input must be at most 8 characters long",
        InputFieldValidators.maximumString(
                8, "Input must be at most 8 characters long")
            .call("123456789"));
  });

  test(
      "maximumString validator should return null when length is equal to maximum",
      () {
    expect(
        null,
        InputFieldValidators.maximumString(
                8, "Input must be at most 8 characters long")
            .call("12345678"));
  });
}
