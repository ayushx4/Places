class UsersPlacesDetail{
  String? uid;
  List<String>? placesList;

  UsersPlacesDetail({
    this.uid,
    this.placesList
});

  UsersPlacesDetail.fromMap(Map<String,dynamic> map){
    uid = map["uid"];
    placesList = map["placesList"];
  }

  Map<String,dynamic> toMap(){
    return {
      "uid" : this.uid,
      "placesList" : this.placesList
    };
}

}