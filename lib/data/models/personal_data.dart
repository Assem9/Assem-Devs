import 'package:my_portfolio/data/models/aboutMe.dart';

class PersonalData {
  late String portfolioTitle ;
  late String facebook ;
  late String gmail ;
  late String whatsApp ;
  late String instagram ;
  late String aboutMeParagraph ;
  late String resume ;
  List<Job> jobs = [];
  //List<ContactMethod> contactMethods = [];

  PersonalData({
    required this.portfolioTitle,
    required this.facebook,
    required this.whatsApp,
    required this.instagram,
    required this.gmail,
}) ;
  PersonalData.fromJson(Map<String, dynamic> json){
    portfolioTitle = json['portfolio_title'];
    facebook = json['facebook'];
    whatsApp = json['whatsapp'];
    instagram = json['instagram'];
    gmail = json['gmail'];
    aboutMeParagraph = json['about'];
    resume = json['resume'];
    json['jobs'].forEach((element){
      jobs.add(Job.fromJson(element));
    });
  }

  Map<String, dynamic> toMap(){
    return {
      'portfolio_title': portfolioTitle,
      'gmail': gmail,
      'whatsapp': whatsApp,
      'instagram': instagram,
      'facebook': facebook,
      'about': aboutMeParagraph,
      'resume':resume,
      'jobs': jobs.map((x) => x.toMap()).toList(),
    };
  }


}