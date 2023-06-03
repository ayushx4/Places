class PlaceModel{
  String? uid;
  String? placeId;
  String? placeName;
  String? aboutPlace;
  String? visibility;
  DateTime? createdOn;

  PlaceModel({
    required this.uid,
    required this.placeId,
    this.placeName,
    this.visibility,
    this.aboutPlace,
    this.createdOn,
});

  PlaceModel.fromMap(Map<String,dynamic> map){
    uid = map[uid];
    placeId =map[placeId];
    placeName = map[placeName];
    aboutPlace = map[aboutPlace];
    visibility = map[visibility];
    createdOn = map[createdOn];
  }

  Map<String,dynamic> toMap(){
    return {
      "userUid" : uid,
      "placeUid" : placeId,
      "placeName" : placeName,
      "aboutPlace" : aboutPlace,
      "visibility" : visibility,
      "createdOn" : createdOn,

  };
}



}