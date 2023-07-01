import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_states.dart';
import 'package:my_portfolio/constants/my_colors.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/presentation/widgets/my_divider.dart';
import 'package:my_portfolio/presentation/widgets/show_toast.dart';
import 'package:my_portfolio/presentation/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/Project.dart';
import '../widgets/listView_with_side_buttons.dart';

class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({super.key});
  final ScrollController _scrollController =  ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ProjectsCubit()..getAllMyProjects(),
      child: BlocBuilder<ProjectsCubit,ProjectsStates>(
        builder: (context, state){
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height,
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
                ProjectsCubit.get(context).myProjects.isNotEmpty
                    ? _buildProjectsListView(context)
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectsListView(context){
    return SizedBox(
      height: MediaQuery.of(context).size.height/2,
      child: ListViewWithSideButtons(
        scrollController: _scrollController,
        listLength: ProjectsCubit.get(context).myProjects.length,
        builder: (context,index){
          final project = ProjectsCubit.get(context).myProjects[index];
          return InkWell(
            onTap: (){
              String projectUrl = ProjectsCubit.get(context).getProjectUrl(project) ;
              Navigator.pushNamed(context, projectUrl,arguments: project);
            },
            child: PortfolioCubit.get(context).screenSize != ScreenSize.isMobile
                ? _buildProjectItemDesktopView(context, project)
                : _buildProjectItemMobileView(context, project),
          );
        },
      ),
    );
  }

  Widget _buildProjectItemDesktopView(context, Project project){
    return Container(
      width:  PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop
          ? MediaQuery.of(context).size.width * 2/3
          : MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        border: Border.all(width: 5,color: MyColors.purple2),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            flex: 2,
            child:_buildProjectMainImage(project.screens[0].image),
          ),
          Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child:_buildProjectDataDialog(context, project)
          ),
          _buildProjectLinksLauncher(context,project)
        ],
      ),
    );
  }

  Widget _buildProjectDataDialog(context,Project project){
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return  const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              MyColors.white ,
              MyColors.white,
              MyColors.purple,
            ]
        ).createShader(bounds);
      },
      child: Container(
        color: MyColors.purple,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 5,),
            Expanded(
              child: Text(
                project.description,
                //overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectLinksLauncher(context,Project project){
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      color: MyColors.purple3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: ()async{
              if(project.gitHubLink.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(mySnack(context,'GitHub Link For This Project Not Provided Yet'));
              }else{

                //url
              }
            },
            child: const Icon(MdiIcons.github,size: 50,),
          ),

         // const SizedBox(height: 10,),
          InkWell(
            onTap: ()async{
              if(project.playStoreLink.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                    mySnack(
                        context,
                        'App Will Be Available In The Store Soon'
                    )
                );
              }else{
                var url = Uri.parse(project.playStoreLink);
                await launchUrl(url,mode: LaunchMode.externalApplication);

              }
            },
            child: const Icon(MdiIcons.googlePlay,size: 50,),
          ),
          //const SizedBox(height: 10,),
          InkWell(
            onTap: (){
              if(project.apkLink.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(mySnack(context,'Sorry No Apk Link for this App yet'));
              }else{
                //url
              }
            },
            child: const Icon(MdiIcons.download,size: 50,),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectMainImage(url){
    return Stack(
      children: [
        ShaderMask(
            shaderCallback: (Rect bounds) {
              return  const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    MyColors.purple3 ,
                    MyColors.white,
                    MyColors.purple,
                  ]
              ).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: MyColors.purple,
                  borderRadius: BorderRadius.circular(20)
              ),

            )
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.contain
            ),
            border: Border.all(color: MyColors.purple2,width: 3),
            borderRadius: BorderRadius.circular(20)
          ),

        ),
      ],
    );
  }

  Widget _buildProjectItemMobileView(context, Project project){
    return SizedBox(
      width:  MediaQuery.of(context).size.width - 80,
      child: Stack(
        children: [
          _buildProjectMainImage(project.screens[0].image),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              decoration: BoxDecoration(
                  color: MyColors.purple3.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                project.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
