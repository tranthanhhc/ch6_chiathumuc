import 'package:flutter/material.dart';

class Alert{
  static void showLoading(BuildContext context) {
    showDialog(context: context,barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  static void showErrorDialog(BuildContext context, errorText) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: Text(errorText),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              },
                child: const Text('Đóng'),),
            ],
          );
        });
  }

  static void showIntResult(BuildContext context, int result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết Quả'),
          content: Text('Kết quả phần tử : $result'),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  static void showStringResult(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết Quả'),
          content: Text('Kết quả phần tử : $result'),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}