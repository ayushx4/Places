class PlaceModel{
  String? uid;
  String? placeId;
  String? placeName;
  String? placeDescription;
  String? placeVisibility;
  DateTime? placeCreatedOn;
  List? fileList;
  List? placeKeywords;

  PlaceModel({
    this.uid,
    this.placeId,
    this.placeName,
    this.placeVisibility,
    this.placeDescription,
    this.placeCreatedOn,
    this.fileList,
    this.placeKeywords
});

  PlaceModel.fromMap(Map<String,dynamic> map){
    uid = map["uid"];
    placeId =map["placeId"];
    placeName = map["placeName"];
    placeDescription = map["placeDescription"];
    placeVisibility = map["placeVisibility"];
    placeCreatedOn = map["placeCreatedOn"];
    fileList = map["fileList"];
    placeKeywords = map["placeKeywords"];
  }

  Map<String,dynamic> toMap(){
    return {
      "uid" : uid,
      "placeId" : placeId,
      "placeName" : placeName,
      "placeDescription" : placeDescription,
      "placeVisibility" : placeVisibility,
      "placeCreatedOn" : placeCreatedOn,
      "fileList" : fileList,
      "placeKeywords" : placeKeywords,

  };
}



}