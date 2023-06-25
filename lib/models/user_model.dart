
class UserModel{

  String? uid;
  String? userName;
  String? mailId;
  String? profilePic;
  String? phoneNumber;
  String? aboutUser;
  String? country;
  DateTime? createdOn;
  int? avatar;

  UserModel({
    this.uid,
    this.userName,
    this.country,
    this.aboutUser,
    this.mailId,
    this.phoneNumber,
    this.profilePic,
    this.createdOn,
  });

  UserModel.fromMap(Map<String,dynamic>map){
    uid=map["userId"];
    userName=map["userName"];
    country=map["country"];
    aboutUser=map["description"];
    mailId=map["mailId"];
    phoneNumber=map["phoneNumber"];
    profilePic=map["profilePic"];
    createdOn=map["createdOn"];
  }

  Map<String,dynamic> toMap(){
    return {

      "userId" : uid,
      "userName" : userName,
      "country" :country,
      "description" : aboutUser,
      "mailId" : mailId,
      "phoneNumber" : phoneNumber,
      "profilePic" : profilePic,
      "createdOn" : createdOn,

  };
}

}