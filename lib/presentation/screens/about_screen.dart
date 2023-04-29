import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioCubit,PortfolioStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = PortfolioCubit.get(context);
        return Container();
      },

    );
  }
}
