import 'package:flutter/material.dart';

// Normal SnackBar
@override
SnackBar normalSnackbar(String text) {
  return SnackBar(content: Text(text));
}

// Success
SnackBar successSnackbar(String text) {
  return SnackBar(content: Text(text), backgroundColor: Colors.blue);
}

// Failure
SnackBar failureSnackbar(String text) {
  return SnackBar(
    content: Text(text),
    backgroundColor: Colors.red,
  );
}
