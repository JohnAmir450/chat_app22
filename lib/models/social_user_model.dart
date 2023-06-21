class SocialUserModel{
   String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? bio;
  String? cover;
  SocialUserModel({required this.email,required this.cover,required this.bio,required this.phone,required this.name,required this.uId,required this.image,required this.isEmailVerified});
  SocialUserModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
    isEmailVerified=json['isEmailVerified'];
  }

    Map<String, dynamic> toMap() {
      return {
        'name': name,
        'phone': phone,
        'email': email,
        'uId': uId,
        'bio': bio,
        'image': image,
        'cover': cover,
        'isEmailVerified': isEmailVerified,
      };
  }
}