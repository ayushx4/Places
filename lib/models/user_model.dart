
class UserModel{

  String? uid;
  String? userName;
  String? mailId;
  String? profilePic;
  String? phoneNumber;
  String? description;
  String? country;

  UserModel({
    this.uid,
    this.userName,
    this.country,
    this.description,
    this.mailId,
    this.phoneNumber,
    this.profilePic,
  });

  UserModel.fromMap(Map<String,dynamic>map){
    uid=map["userId"];
    userName=map["userName"];
    country=map["country"];
    description=map["description"];
    mailId=map["mailId"];
    phoneNumber=map["phoneNumber"];
    profilePic=map["profilePic"];
  }

  Map<String,dynamic> toMap(){
    return {

      "userId" : uid,
      "userName" : userName,
      "country" :country,
      "description" : description,
      "mailId" : mailId,
      "phoneNumber" : phoneNumber,
      "profilePic" : profilePic,

  };
}

}