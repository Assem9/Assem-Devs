import 'package:my_portfolio/data/models/app_screen_details.dart';

class Project {
  late String iD;
  List<AppScreen> screens = [] ;
  late String title;
  late String description;
  late String gitHubLink;
  late String playStoreLink;
  late String apkLink;

  Project.fromJson(Map<String, dynamic> json){
    iD = json['iD'];
    json['screens'].forEach((element){
      screens.add(AppScreen.fromJson(element));
    });
    title = json['title'];
    description = json['description'];
    gitHubLink = json['gitHubLink'];
    playStoreLink = json['playStoreLink'];
    apkLink = json['apkLink'];
  }

  Map<String, dynamic> toMap(){
    return {
      'iD': iD,
      'screens': screens.map((e) => e.toMap()) ,
      'title': title,
      'description': description,
      'playStoreLink': playStoreLink,
      'gitHubLink': gitHubLink,
      'apkLink': apkLink,
    };
  }

}