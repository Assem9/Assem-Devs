import 'package:flutter/material.dart';
import '../../utils/my_colors.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller ;
  final String hint ;
  final TextInputType type ;
  final int? maxLines ;
  final InputBorder? border ;

  const DefaultTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.type,
    this.maxLines,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.black1,
      ),
      child: TextFormField(
        maxLines: maxLines  ,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyColors.white) ,
        controller: controller ,
        validator: (value){
          if(value!.isEmpty) {
            return 'please $hint ';
          }
          return null;
        },
      //  cursorColor: Colors.red,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:  Theme.of(context).textTheme.bodySmall!.copyWith(color: MyColors.white) ,
          border: border ??  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ) ,
      ),
    );
  }
}
