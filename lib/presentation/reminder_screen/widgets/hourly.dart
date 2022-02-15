import 'package:flutter/material.dart';
import 'package:reminder_app/core/utils/color_constant.dart';

class hour_type extends StatelessWidget {
  const hour_type({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Every",
            ),
            Container(
              width: 130,
              child: TextFormField(
                maxLength: 2,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstant.green),
                  ),
                ),
              ),
            ),
            Text(
              "Hour",
            ),
          ],
        )
      ],
    );
  }
}
