class UsersPlacesDetail{
  String? uid;
  List<String>? placesList;
  List? userKeyword; // user interested in this keyword

  UsersPlacesDetail({
    this.uid,
    this.placesList,
    this.userKeyword
});

  UsersPlacesDetail.fromMap(Map<String,dynamic> map){
    uid = map["uid"];
    placesList = map["placesList"];
    userKeyword = map["userKeyword"];
  }

  Map<String,dynamic> toMap(){
    return {
      "uid" : this.uid,
      "placesList" : this.placesList,
      "userKeyword" : this.userKeyword
    };
}

}