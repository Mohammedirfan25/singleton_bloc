class ValidationError {
  late String? fieldName;

  late String error;

  ValidationError({this.fieldName, required this.error});
}
