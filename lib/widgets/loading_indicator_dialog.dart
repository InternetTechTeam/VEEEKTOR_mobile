import 'package:flutter/material.dart';

class LoadingIndicatorDialog {
  static late BuildContext _context;
  static bool _isShown = false;

  static show(BuildContext context) {
    if (_isShown) return;
    _isShown = true;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          _context = context;
          return const SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            insetPadding: EdgeInsets.symmetric(horizontal: 120),
            children: [
              Center(
                child: SizedBox.square(
                  dimension: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 6.0,
                  ),
                ),
              ),
            ],
          );
        });
  }

  static dismiss() {
    if (_isShown) {
      Navigator.of(_context).pop();
      _isShown = false;
    }
  }
}
