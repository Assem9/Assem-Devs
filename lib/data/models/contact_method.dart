class ContactMethod{
  late String name;
  late String value;
  late bool isShown ;

  ContactMethod.fromJson(Map<String, dynamic> json){
    name = json['name'];
    value = json['value'];
    isShown = json['isShown'];

  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'value': value,
      'isShown': isShown,
    };
  }
  //String iconDataString = Icons.ac_unit.codePoint.toString();
  //IconData iconData = IconData(int.parse(iconDataString),
}