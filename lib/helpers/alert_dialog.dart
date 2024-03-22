import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialog {

  CupertinoAlertDialog _cupertinoAlertDialog(
    {required BuildContext context, required String title, required String message}) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }



 void showAlert(
 { required BuildContext context, 
 required String title, 
 required String message}
  ) {
     showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return _cupertinoAlertDialog(
          context: context,
          title: title,
          message: message,
        );
      },
    );
  }

}