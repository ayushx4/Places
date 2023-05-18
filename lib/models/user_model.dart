
class UserModel{

  String? uid;
  String? userName;
  String? mailId;
  String? profilePic;
  String? phoneNumber;
  String? description;
  String? country;
  String? state;
  String? institute;
  String? course;
  int? year;
  int? sem;

  UserModel({
    this.uid,
    this.userName,
    this.year,
    this.country,
    this.course,
    this.description,
    this.institute,
    this.mailId,
    this.phoneNumber,
    this.sem,
    this.state,
    this.profilePic,
  });

  UserModel.fromMap(Map<String,dynamic>map){
    uid=map["userId"];
    userName=map["userName"];
    year=map["year"];
    country=map["country"];
    course=map["course"];
    description=map["description"];
    institute=map["institute"];
    mailId=map["mailId"];
    phoneNumber=map["phoneNumber"];
    sem=map["sem"];
    state=map["state"];
    profilePic=map["profilePic"];
  }

  Map<String,dynamic> toMap(){
    return {

      "userId" : uid,
      "userName" : userName,
      "year" : year,
      "country" :country,
      "course" : course,
      "description" : description,
      "institute" :institute,
      "mailId" : mailId,
      "phoneNumber" : phoneNumber,
      "sem" : sem,
      "state" : state,
      "profilePic" : profilePic,

  };
}

}