import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/admin_cubit/admin_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/admin_cubit/admin_states.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/utils/strings.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/presentation/widgets/app_logo.dart';
import 'package:my_portfolio/presentation/widgets/default_button.dart';
import 'package:my_portfolio/presentation/widgets/textfield.dart';

class AdminLogInScreen extends StatelessWidget {
  AdminLogInScreen({Key? key}) : super(key: key);

  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PortfolioCubit,PortfolioStates>(
        builder: (context,state) {
          return SafeArea(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: PortfolioCubit.get(context).screenSize != ScreenSize.isMobile
                    ? 500
                    : MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LOGIN AS ADMIN',style: Theme.of(context).textTheme.displayMedium,),
                    const SizedBox(height: 20,),
                    const AppLogoWidget(radius: 40),
                    const SizedBox(height: 20,),
                    _buildPasswordField(),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  Widget _buildPasswordField(){
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state){},
      builder: (context,state) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTextField(
                  controller: passwordController,
                  hint: 'password',
                  type: TextInputType.visiblePassword
              ),
              const SizedBox(height: 10,),
              DefaultButton(
                  title: 'LOGIN',
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      // login
                      Navigator.pushReplacementNamed(context, adminPanelScreen) ;

                    }
                  }
              ),
            ],
          ),
        );
      }
    ) ;
  }
}
