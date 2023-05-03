import 'package:flutter/cupertino.dart';

import '../../constants/my_colors.dart';

class MyDriver extends StatelessWidget {
  const MyDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyColors.purple.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ]
      ),
    );
  }
}
