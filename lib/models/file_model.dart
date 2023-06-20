class FileModel{
  String? fileId;
  String? fileName;
  String? fileDescription;
  String? docId;
  String? docLinkW;
  String? attachedLink;
  DateTime? fileCreatedOn;

  FileModel({
    this.fileName,
    this.fileId,
    this.fileCreatedOn,
    this.docLinkW,
    this.docId,
    this.fileDescription,
    this.attachedLink,
  });

  FileModel.fromMap(Map<String,dynamic> map){
    fileId = map["uploadId"];
    fileName =map["fileName"];
    docId=map["docId"];
    docLinkW=map["docLinkW"];
    attachedLink=map["attachedLink"];
    fileCreatedOn = map["fileCreatedOn"];
    fileDescription = map["fileDescription"];

  }

  Map<String , dynamic> toMap(){
    return{
      "fileId" : fileId,
      "fileName" : fileName,
      "docId" :docId,
      "DocLinkW" : docLinkW,
      "attachedLink" :attachedLink,
      "fileCreatedOn" : fileCreatedOn,
      "fileDescription" : fileDescription
    };
  }

}