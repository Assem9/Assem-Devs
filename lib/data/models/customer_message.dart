class CustomerMessage{

  late String dateTime ;
  late String message ;
  CustomerMessage({required this.dateTime,required this.message}) ;

  CustomerMessage.fromJson(Map<String, dynamic> json){
    dateTime = json['dateTime'];
    message = json['message'];
  }

  Map<String, dynamic> toMap(){
    return {
      'dateTime': dateTime,
      'message': message,
    };
  }
}