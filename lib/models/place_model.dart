class PlaceModel{
  String? uid;
  String? placeId;
  String? placeName;
  String? placeAbout;
  String? placeVisibility;
  DateTime? placeCreatedOn;
  List? fileList;
  List? placeKeywords;

  PlaceModel({
    this.uid,
    this.placeId,
    this.placeName,
    this.placeVisibility,
    this.placeAbout,
    this.placeCreatedOn,
    this.fileList,
    this.placeKeywords
});

  PlaceModel.fromMap(Map<String,dynamic> map){
    uid = map[uid];
    placeId =map[placeId];
    placeName = map[placeName];
    placeAbout = map[placeAbout];
    placeVisibility = map[placeVisibility];
    placeCreatedOn = map[placeCreatedOn];
    fileList = map[fileList];
    placeKeywords = map[placeKeywords];
  }

  Map<String,dynamic> toMap(){
    return {
      "uid" : uid,
      "placeId" : placeId,
      "placeName" : placeName,
      "placeAbout" : placeAbout,
      "placeVisibility" : placeVisibility,
      "placeCreatedOn" : placeCreatedOn,
      "fileList" : fileList,
      "placeKeywords" : placeKeywords,

  };
}



}