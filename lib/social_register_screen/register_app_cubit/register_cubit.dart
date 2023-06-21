import 'package:chat_app/models/social_user_model.dart';
import 'package:chat_app/social_register_screen/register_app_cubit/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants/constants.dart';

class socialRegisterCubit extends Cubit<socialRegisterStates>{
  socialRegisterCubit():super(socialRegisterInitialStates());
  //socialLoginCubit(super.socialLoginInitialStates);
  static socialRegisterCubit get(context)=>BlocProvider.of(context);
// استاتيك انا بعد كده  Bloc provider .of (contxet مني يعني)<=get(context)

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }

      ) {
    emit(socialRegisterLoadongStates());

FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
print ('hello');
  print(value.user!.email);
print (value.user!.uid);
UserCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
emit(socialRegisterSuccessStates());
}).catchError((onError){
  emit(socialRegisterErrorStates(onError.toString()));

});

   }

   void UserCreate({
     required String name,
     required String email,
     required String phone,
     required String uId,
   }){
    SocialUserModel socialUserModel=SocialUserModel(
      name:name,
      email: email,
      phone: phone,
      uId: uId,
        cover: 'https://img.freepik.com/free-photo/rear-view-programmer-working-all-night-long_1098-18697.jpg?w=900&t=st=1682979395~exp=1682979995~hmac=15035fd6e3bfb6571ee340878d3521296d42b56b786092905944650121f0d819',
        bio: 'Hey there I\'m using John\'s chat-app' ,
        image: 'https://cdn-icons-png.flaticon.com/512/709/709699.png?w=740&t=st=1683150914~exp=1683151514~hmac=859cffa48980a3412f6dca4bb300d58fc061589315314b3f6e3816a9a0557fd5',
        isEmailVerified: false
    );
    FirebaseFirestore.instance.collection('users').doc(uId)
        .set(socialUserModel.toMap()).then((value) {

          emit(socialCreateUserSuccessStates());
    }).catchError((onError){
      print (onError.toString());
      emit(socialCreateUserErrorStates(onError.toString()));
    });

   }

    IconData suffix = Icons.visibility;
    bool isPasswordShow = true;
    void changePasswordVisibility() {
      isPasswordShow = !isPasswordShow;
      suffix = isPasswordShow ? Icons.visibility : Icons.visibility_off_sharp;
      emit(socialRegisterChangePassworsdVisibilityState());
    }
  }