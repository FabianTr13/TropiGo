import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:flutter/material.dart';

class CalendarPicker {
  Future<DateTime> showPicker(BuildContext context) async {
    DateTime date = DateTime(1900);

    var fecha = DateTime.now();
    date = await showDatePicker(
      context: context,
      helpText: "Mayor de 18 años",
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime(fecha.year - 18),
      firstDate: DateTime(1920),
      lastDate: DateTime(fecha.year - 18),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
            colorScheme: ColorScheme.light(
              primary: TropiColors.orangeButons,
              onPrimary: Colors.white,
              surface: TropiColors.orangeButons,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    return date;
  }
}
