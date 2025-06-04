// ignore: file_names
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project/utils/theme_utils.dart';

class DialogApp {
  static create(context, String? title, String? desc, Widget body,
      Function? okPressed, Function? cancelPressed) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      width: 500,
      title: title,
      desc: desc,
      body: body,
      dialogBackgroundColor: ThemeUtils.backgroundColor,
      btnOkColor: ThemeUtils.primaryColor,
      btnCancelColor: Colors.red[400],
      buttonsTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      btnOkOnPress: () => okPressed,
      btnCancelOnPress: () => cancelPressed,
    ).show();
  }

  static info(context, String? title, String? desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      width: 500,
      title: title,
      desc: desc,
      dialogBackgroundColor: ThemeUtils.backgroundColor,
      btnOkColor: ThemeUtils.primaryColor,
      buttonsTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      btnOkOnPress: () => Navigator.of(context),
    ).show();
  }

  static error(context, String? title, String? desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      width: 500,
      title: title,
      desc: desc,
      dialogBackgroundColor: ThemeUtils.backgroundColor,
      btnOkColor: ThemeUtils.primaryColor,
      buttonsTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      btnOkOnPress: () => Navigator.of(context),
    ).show();
  }

  static success(context, String? title, String? desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      width: 500,
      title: title,
      desc: desc,
      dialogBackgroundColor: ThemeUtils.backgroundColor,
      btnOkColor: ThemeUtils.primaryColor,
      buttonsTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      btnOkOnPress: () => Navigator.of(context),
    ).show();
  }

  static warning(context, String? title, String? desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      width: 500,
      title: title,
      desc: desc,
      dialogBackgroundColor: ThemeUtils.backgroundColor,
      btnOkColor: ThemeUtils.primaryColor,
      buttonsTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      btnOkOnPress: () => Navigator.of(context),
    ).show();
  }
}
