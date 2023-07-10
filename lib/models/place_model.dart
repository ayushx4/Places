class PlaceModel{
  String? uid;
  String? placeId;
  String? placeName;
  String? placeDescription;
  String? placeVisibility;
  DateTime? placeCreatedOn;
  List? fileList;
  List<String>? placeKeywords;
  List<String>? likesUidList;
  int? likes;

  PlaceModel({
    this.uid,
    this.placeId,
    this.placeName,
    this.placeVisibility,
    this.placeDescription,
    this.placeCreatedOn,
    this.fileList,
    this.placeKeywords,
    this.likes,
    this.likesUidList
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
    likes=map["likes"];
    likesUidList=map["likesUidList"];

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
      "likes" : likes,
      "likesUidList" : likesUidList

  };
}



}