class FileModel{
  String? fileId;
  String? fileTitle;
  String? fileDescription;
  String? fileUrl;
  DateTime? fileCreatedOn;

  FileModel({
    this.fileTitle,
    this.fileId,
    this.fileCreatedOn,
    this.fileUrl,
    this.fileDescription
  });

  FileModel.fromMap(Map<String,dynamic> map){
    fileId = map["uploadId"];
    fileTitle =map["title"];
    fileUrl=map["fileUrl"];
    fileCreatedOn = map["fileCreatedOn"];
    fileDescription = map["fileDescription"];

  }

  Map<String , dynamic> toMap(){
    return{
      "fileId" : fileId,
      "fileTitle" : fileTitle,
      "fileUrl" : fileUrl,
      "fileCreatedOn" : fileCreatedOn,
      "fileDescription" : fileDescription
    };
  }

}