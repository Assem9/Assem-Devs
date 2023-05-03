import 'package:flutter/material.dart';
import 'package:my_portfolio/presentation/widgets/textfield.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key}) : super(key: key);

  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: DefaultTextField(
              controller: passwordController,
              hint: 'password',
              type: TextInputType.visiblePassword
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(){
    return Center(
      child: DefaultTextField(
          controller: passwordController,
          hint: 'password',
          type: TextInputType.visiblePassword
      ),
    ) ;
  }
}
