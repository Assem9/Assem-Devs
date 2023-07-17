import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_states.dart';
import 'package:my_portfolio/utils/my_colors.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/presentation/widgets/default_button.dart';
import 'package:my_portfolio/presentation/widgets/links_icon_widget.dart';
import 'package:my_portfolio/presentation/widgets/my_divider.dart';
import '../../data/models/Project.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ProjectsCubit()..getAllMyProjects(context),
      child: BlocBuilder<PortfolioCubit,PortfolioStates>(
        builder: (context, state){
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width >1200
                  ? MediaQuery.of(context).size.width * 0.8
                  : MediaQuery.of(context).size.width - 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MyDriver(),
                  Container(
                    color: MyColors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                    child: Text(
                      'MY PROJECTS',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 20,),
                   _buildProjectsGridView(context),
                  const SizedBox(height: 300,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectsGridView(context){
    return  BlocBuilder<ProjectsCubit,ProjectsStates>(
  builder: (context, state) {
    return ProjectsCubit.get(context).myProjects.isNotEmpty ?
      SingleChildScrollView(
        child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: ProjectsCubit.get(context).girdHeight.toDouble(),
           // color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
                      ? 1
                      : 2,
                  childAspectRatio:1.5/1,
                  crossAxisSpacing:15,
                  mainAxisSpacing: 20
              ),
              itemBuilder: (context,index)=> _buildProjectItem(
                  context,
                  ProjectsCubit.get(context).myProjects[index]
              ),
              itemCount: ProjectsCubit.get(context).myProjects.length,
            ),
          ),
          BlocBuilder<PortfolioCubit, PortfolioStates>(
  builder: (context, state) {
    return DefaultButton(
              title: 'SHOW MORE',
              buttonColor: MyColors.appBarColor,
              height: 50,
              textStyle: Theme.of(context).textTheme.titleSmall,
              onTap: ()=> ProjectsCubit.get(context).changeGridHeight(
                context,
                PortfolioCubit.get(context).screenSize == ScreenSize.isMobile ? 1 : 2
              )
          );
  },
),
        ],
    ),
      ) : Container();
  },
);
  }
  
  Widget _buildProjectItem(context,Project project){
    return InkWell(
      onTap: (){
        String projectUrl = ProjectsCubit.get(context).getProjectUrl(project) ;
        Navigator.pushNamed(context, projectUrl,arguments: project);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: MyColors.purple3.withOpacity(0.5),
            border: Border.all(width: 2,color: MyColors.purple1),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                      project.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                )
            ),
            Expanded(
                flex: 4,
                child: _buildProjectImageView(project.screens[0].image)
            ),
            const SizedBox(height: 8,),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                   // color: MyColors.purple3.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    Text(
                      project.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8,),
                    LinkIconButton(project: project),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildProjectImageView(url){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/ballons_loader.gif',
        image: url,
      ),
    ) ;
  }



}
