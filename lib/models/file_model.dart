class FileModel{
  String? fileId;
  String? fileType; // the file is pdfs, links , docs etc
  String? fileTitle;
  String? fileNote;
  Map<String,dynamic>? attachment;

  FileModel({
    this.fileTitle,
    this.fileNote,
    this.fileId,
    this.fileType,
    this.attachment,
  });

  FileModel.fromMap(Map<String,dynamic> map){
    fileId = map["uploadId"];
    fileTitle =map["title"];
    fileNote =map["desc"];
    fileType=map["folderType"];
    attachment=map["attachment"];
  }

  Map<String , dynamic> toMap(){
    return{
      "fileId" : fileId,
      "fileTitle" : fileTitle,
      "fileNote" : fileNote,
      "fileType" : fileType,
      "attachment" : attachment,
    };
  }

}