class PersonalData {
  late String portfolioTitle ;
  late String facebook ;
  late String gmail ;
  late String whatsApp ;
  late String instagram ;
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
  }

  Map<String, dynamic> toMap(){
    return {
      'portfolio_title': portfolioTitle,
      'gmail': gmail,
      'whatsapp': whatsApp,
      'instagram': instagram,
      'facebook': facebook,
    };
  }


}