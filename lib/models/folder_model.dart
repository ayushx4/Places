import 'package:clg_mat/models/file_model.dart';

class FolderModel{
  String? folderId;
  String? folderType; // the folder is for student or not
  bool? visibility; // true for public and false for private
  String? folderTitle;
  String? folderNote;
  String? course; //for next version
  String? sem;  //for next version
  String? subject;
  List<FileModel> ? fileModel;


  FolderModel({
    this.course,
    this.sem,
    this.folderTitle,
    this.folderNote,
    this.subject,
    this.folderId,
    this.folderType,
    this.visibility,
    this.fileModel,
});

  FolderModel.fromMap(Map<String,dynamic> map){
    folderId = map["uploadId"];
    folderTitle =map["title"];
    folderNote =map["desc"];
    course=map["course"];
    sem=map["sem"];
    subject=map["subject"];
    folderType=map["folderType"];
    visibility=map["visibility"];
    fileModel=map["fileModel"];
  }

  Map<String,dynamic> toMap() {

    return {
    "folderId" : folderType,
    "folderTitle" : folderType,
    "folderNote" : folderNote,
    "course" : course,
    "sem" : sem,
    "subject" : subject,
    "folderType" : folderType,
    "visibility" : visibility,
    "fileModel" : fileModel,
  };
}


}