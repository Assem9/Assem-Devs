class AppScreen{
  late String image ;
  late String title ;
  late String description ;

  AppScreen({required this.image, required this.title, required this.description});

  AppScreen.fromJson(Map<String, dynamic> json){
    image = json['image'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toMap(){
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }

}