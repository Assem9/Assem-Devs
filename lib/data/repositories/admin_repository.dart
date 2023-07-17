import 'package:my_portfolio/data/firestore_services/admin_data_services.dart';
import 'package:my_portfolio/data/models/Project.dart';
import 'package:my_portfolio/data/models/app_screen_details.dart';
import 'package:my_portfolio/data/models/subject_model.dart';

class AdminRepository{
  final AdminDataServices adminDataServices ;
  AdminRepository(this.adminDataServices);

  Future<void> createNewProject()async{
    Project project = Project(
        iD: 'iD',
        screens: [
          AppScreen(
              image: '',
              title: 'Main ',
              description: 'description'
          ),
          AppScreen(
              image: '',
              title: 'Main ',
              description: 'description'
          ),
          AppScreen(
              image: '',
              title: 'Main ',
              description: 'description'
          ),
          AppScreen(
              image: '',
              title: 'Main ',
              description: 'description'
          ),
          AppScreen(
              image: '',
              title: 'Main ',
              description: 'description'
          ),
          AppScreen(
              image: '',
              title: 'Main ',
              description: 'description'
          ),
          AppScreen(
              image: '',
              title: 'Main ',
              description: 'description'
          ),
        ],
        subjects: [
          Subject(
              title: 'App Features',
              description: 'description',
              points: [
                'Create Your Costume Mockup Device From a to Z',
                'Use One Off Mockup Devices That we Provide For you',
                'There Are Iphone, Android and Desktop Mockups',
                'Add Stickers For Better Design',
                'Upload Images You Need To The Design',
                'Add Texts With Multiple Fonts',
                'Colorize The Page Background or use Our Filter Or Upload Image As An Background',
                'Control Page Size To Maintain Your Design Needs ',
              ]
          ),
          Subject(
              title: 'Development Info',
              description: 'description',
              points: []
          ),
          Subject(
              title: 'Libraries Used In Project',
              description: 'description',
              points: [
                'url_strategy',
                'package_info_plus',
                'cupertino_icons',
                'material_design_icons_flutter',
                'scrollable_positioned_list',
                'flutter_bloc',
                'bloc',
                'carousel_slider',
                'google_fonts',
                'animated_text_kit',
                'lottie',
                'flutter_svg',
                'fluttertoast',
                'flutter_native_splash',
                'path_provider',
                'flutter_colorpicker',
                'file_selector',
                'image_picker',
                'hive',
                'hive_flutter',
                'google_mobile_ads',
                'gallery_saver',
                'url_launcher',
                'flutter_offline',
                'connectivity_plus',
                'equatable',
                'get_it',
                'shared_preferences',
                'firebase_core',
                'cloud_firestore',
                'firebase_storage',
                'firedart',

              ]
          ),
        ],
        title: 'MockMate',
        verticalScreen: false,
        description: 'Introducing MockMate, the ultimate design tool for app developers and designers looking '
            'to showcase their mobile applications. With MockMate, users can easily display screenshots of their '
            'apps in a variety of device mockups, including mobile, tablet, and PC.In addition to displaying'
            ' screenshots, MockMate provides users with a wide range of design tools and options to help them create'
            ' stunning images to showcase their apps. Whether you want to add text, images, or combine multiple '
            'screenshots, [App Name] has everything you need to create a professional-looking image that perfectly '
            'captures your app\'s features and functionality.With intuitive and user-friendly controls, '
            'MockMate makes it easy for anyone to create beautiful and engaging images that will help your app stand '
            'out in the crowded app market. Whether you\'re a seasoned app developer or just starting out, [App Name] is the perfect tool to help you create stunning visual content that will help drive downloads and increase engagement.',
        gitHubLink: '',
        playStoreLink: 'https://play.google.com/store/apps/details?id=com.assemDev.mock_flow',
        apkLink: '', uploadDate: DateTime.now()
    );
    await adminDataServices.addNewProjectToFireStore(project);

  }

  Future<void> updateProjectData(Project project)async{
    List<Subject> newSubjects = [
      Subject(
          title: 'App Features',
          description: 'Discussing App Features ',
          points: [
            'You Can Pick The Avatar That Suits You',
            'Can Create Multiple Accounts ',
            'User Can Add Task Easily',
            'Or Add Plans which Consist of Multiple Tasks',
            'Set A StartDate - DeadLine Date',
            'Keep Track Of your Task And Plans ',
            'Simple Ui With (Light, Dark) Themes'
          ]
      ),
      Subject(
          title: 'Development Info',
          description: 'Some Information about The App\'s Development Process ',
          points: [
            'App Developed With Flutter Framwork',
            'Using Cubit As State Management ',
            'The Project Is Build With BloC Architecture',
            'Using Hive As Local DataBase',
          ]
      ),
      Subject(
          title: 'Code Libraries',
          description: 'This All Libraries And Packages That Are Used In Project',
          points: [
            'google_fonts',
            'fluttertoast',
            'flutter_bloc',
            'bloc',
            'hive',
            'hive_flutter',
            'url_launcher',
            'shared_preferences',
            'intl',
            'path_provider',
            'flutter_datetime_picker',
            'flutter_native_splash',
          ]
      ),
    ];
    Project updatedProject = Project(
        iD: project.iD,
        screens: project.screens,
        subjects:  newSubjects,
        title: project.title,
        verticalScreen: project.verticalScreen,
        description: project.description,
        gitHubLink: project.gitHubLink,
        playStoreLink: project.playStoreLink,
        apkLink: project.apkLink, uploadDate: project.uploadDate
    );
    await adminDataServices.updateProjectToFireStore(updatedProject);
  }


}