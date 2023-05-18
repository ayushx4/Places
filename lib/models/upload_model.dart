class UploadModel{
  String? uploadId;
  String? title;
  String? desc;
  String? course; //for next version
  String? sem;  //for next version
  String? subject;

  UploadModel({
    this.course,
    this.sem,
    this.title,
    this.desc,
    this.subject,
    this.uploadId,
});

  UploadModel.fromMap(Map<String,dynamic> map){
    uploadId = map["uploadId"];
    title =map["title"];
    desc =map["desc"];
    course=map["course"];
    sem=map["sem"];
    subject=map["subject"];
  }



}