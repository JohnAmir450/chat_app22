class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;


  PostModel({required this.name,required this.uId,required this.image,required this.dateTime,this.postImage,this.text});
  PostModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    dateTime=json['dateTime'];
    text=json['text'];
    uId=json['uId'];
    image=json['image'];
    postImage=json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'dateTime': dateTime,
      'uId': uId,
      'image': image,
      'text': text,
    };
  }
}