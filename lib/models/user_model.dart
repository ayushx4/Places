
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
    this.avatar
  });

  UserModel.fromMap(Map<String,dynamic>map){
    uid=map["userId"];
    userName=map["userName"];
    country=map["country"];
    aboutUser=map["aboutUser"];
    mailId=map["mailId"];
    phoneNumber=map["phoneNumber"];
    profilePic=map["profilePic"];
    createdOn=map["createdOn"];
    avatar=map["avatar"];
  }

  Map<String,dynamic> toMap(){
    return {

      "userId" : uid,
      "userName" : userName,
      "country" :country,
      "aboutUser" : aboutUser,
      "mailId" : mailId,
      "phoneNumber" : phoneNumber,
      "profilePic" : profilePic,
      "createdOn" : createdOn,
      "avatar" : avatar,

  };
}

}