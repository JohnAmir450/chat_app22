import 'dart:io';

import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/models/posts_model.dart';
import 'package:chat_app/models/social_user_model.dart';
import 'package:chat_app/moduels/chats/chats_screen.dart';
import 'package:chat_app/moduels/feed/feeds_screen.dart';
import 'package:chat_app/moduels/new_post/new_post_screen.dart';
import 'package:chat_app/moduels/settings/settings_screen.dart';
import 'package:chat_app/moduels/users/users_screen.dart';
import 'package:chat_app/shared/constants/constants.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../social_register_screen/register_app_cubit/register_states.dart';

class socialCubit extends Cubit<socialStates>{

  socialCubit():super(socialInitialstate());
  static socialCubit get(context)=> BlocProvider.of(context);


  SocialUserModel? socialUserModel;
  void getUserData(){
emit(socialGetUserLaoadingstate());
FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
  print(uid);
  print(value.data());
  socialUserModel=SocialUserModel.fromJson(value.data()!);
  emit(socialGetUserScuccessstate());
}).catchError((onError){
  print(uid);
  print(onError.toString());

  emit(socialGetUserErrorstate(onError.toString()));
});
  }

  int currentIndex=0;
  List<Widget>screens=[
    FeedScreen(),
    ChatScreen(),
    newPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
void changeBottomNav(int index){

if(index==2){
  emit(socialNewPostState());
}
else {
      currentIndex = index;
      emit(socialChangeBottomNavState());
    }
  }
List<String>Titles=[
  'Home',
  'Chats',
  'Add post',
  'Users',
  'Setting'
];

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final packedimage = await picker.getImage(source: ImageSource.gallery);
    if (packedimage != null){
      profileImage = File(packedimage.path);
      emit(socialProfileImagePickedSuccessStates());
    }


    else
      print('no image selected');
    emit(socialProfileImagePickedErrorStates());

  }


  File? coverImage;

  Future<void> getCoverImage() async {
    final packedimage = await picker.getImage(source: ImageSource.gallery);
    if (packedimage != null){
      coverImage = File(packedimage.path);
      emit(socialCoverImagePickedSuccessStates());
    }


    else
      print('no image selected');
    emit(socialCoverImagePickedErrorStates());

  }

  void uploadProfileImage({ required String name,
    required String phone,
    required String bio,
    String? image,}){
    emit(socialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri.file(profileImage!.path).pathSegments.last}').
    putFile(profileImage!).
    then((value) {
      value.ref.getDownloadURL()
          .then((value) {

            //emit(socialUploadProfileImageSuccessStates());
            print (value);
            updateUser(name: name, phone: phone, bio: bio,image:value );
      })
          .catchError((onError){
        emit(socialUploadProfileImageErrorStates());
      });
    }).catchError((error){
      emit(socialUploadProfileImageErrorStates());

    });
  }





  void uploadCoverImage({ required String name,
    required String phone,
    required String bio,
    String? cover,}){
    emit(socialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri.file(coverImage!.path).pathSegments.last}').
    putFile(coverImage!).
    then((value) {
      value.ref.getDownloadURL()
          .then((value) {

        //emit(socialUploadCoverImageSuccessStates());
        print (value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);
      })
          .catchError((onError){
        emit(socialUploadCoverImageErrorStates());
      });
    }).catchError((error){
      emit(socialUploadCoverImageErrorStates());

    });
  }



void updateUser({
  required String name,
  required String phone,
  required String bio,
  String? image,
  String? cover
}){

  SocialUserModel model=SocialUserModel(
      name:name,
      email: socialUserModel!.email,
      phone: phone,
      uId: socialUserModel!.uId,
      cover:cover?? socialUserModel!.cover,
      bio: bio,
      image: image?? socialUserModel!.image,
      isEmailVerified: false
  );
  FirebaseFirestore.instance.collection('users').doc(socialUserModel!.uId).update(model!.toMap()).then((value) {
    getUserData();
  }).catchError((error){
    emit(socialUserUpdateErrorStates());
  });
}

  File? postImage;

  Future<void> getPostImage() async {
    final packedimage = await picker.getImage(source: ImageSource.gallery);
    if (packedimage != null) {
      postImage = File(packedimage.path);
      emit(socialPostImagePickedSuccessStates());
    }
    else{
      emit(socialPostImagePickedErrorStates());
    }
  }
void removePostImage(){
    postImage=null;
    emit(socialRemovePostImagePickedStates());
}
    void uploadPostImage
        ({

      required String dateTime,
      required String text,

       }) {
      emit(socialCreatePostLoadingStates());
      firebase_storage.FirebaseStorage.instance.ref().
      child('posts/${Uri
          .file(postImage!.path)
          .pathSegments
          .last}').
      putFile(postImage!).
      then((value) {
        value.ref.getDownloadURL()
            .then((value) {
          CreatePost(dateTime:dateTime, text: text,postImage: value);
        })
            .catchError((onError) {
          emit(socialCreatePostErrorStates());
        });
      }).catchError((error) {
        emit(socialCreatePostErrorStates());
      });
    }
    void CreatePost({
      required String dateTime,
      required text,
      String ? postImage

    }){

      PostModel model=PostModel(
          name:socialUserModel!.name,
          text: text,
          dateTime: dateTime,
          uId: socialUserModel!.uId,
          image:socialUserModel!.image,
          postImage:postImage??'',

      );
      FirebaseFirestore.instance.collection('posts').add(model!.toMap()).then((value) {
  emit(socialCreatePostSuccessStates());
      }).catchError((error){
        emit(socialCreatePostErrorStates());
      });
    }

    List<PostModel> posts=[];
  List<String> postsID=[];
  List<int>likes=[];
void getPosts(){
FirebaseFirestore.instance.collection('posts').get()
    .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').orderBy('dateTime').get().then((value) {
          likes.add(value.docs.length);
          postsID.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((onError){});

      });
      emit(socialGetPostsScuccessstate());
})
    .catchError((onError){
  emit(socialGetPostsErrorstate(onError.toString()));
});
}
void likePost(String postId)
{
FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(socialUserModel!.uId).set({
  'like':true
}).then((value) {
  emit(socialLikePostsScuccessstate());
}).catchError((onError){
  emit(socialLikePostsErrorstate(onError.toString()));
});
}
List<SocialUserModel>users=[];




void getUsers(){
FirebaseFirestore.instance.collection('users').get().then((value) {

  value.docs.forEach((element) {
    if(element.data()['uId']!=socialUserModel!.uId)
    users.add(SocialUserModel.fromJson(element.data()));
  });
  emit(socialGetAllUsersScuccessstate());
}).catchError((onError){
  emit(socialGetAllUsersErrorstate(onError.toString()));

});
}

void sendMessage({
  required String? reciverID,
  required String? dateTime,
  required String? Text,


}){
MessageModel messageModel=MessageModel(reciverID: reciverID, senderID: socialUserModel!.uId, dateTime: dateTime, text: Text);

//set my chat
FirebaseFirestore.instance.collection('users').doc(socialUserModel!.uId).collection('chats').doc(reciverID).collection('messages').add(messageModel.toMap())
    .then((value) {
      emit(socialSendMessageSuccessState());
}).catchError((onError){
  emit(socialSendMessageErrorState());

});
//set reciver chat
FirebaseFirestore.instance.collection('users').doc(reciverID).collection('chats').doc(socialUserModel!.uId).collection('messages').add(messageModel.toMap())
    .then((value) {
  emit(socialSendMessageSuccessState());
}).catchError((onError){
  emit(socialSendMessageErrorState());

});

}

List<MessageModel>messages=[];

void getMessages( {
    required String reciverID,
}){
FirebaseFirestore.instance.collection('users').doc(socialUserModel!.uId).collection('chats').doc(reciverID).collection('messages').orderBy('dateTime').snapshots().listen((event) {

  messages=[];
  event.docs.forEach((element) {

    messages.add(MessageModel.fromJson(element.data()));
  });
emit(socialGetMessageSuccessState());
});
}

  }