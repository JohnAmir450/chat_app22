import 'package:chat_app/login_screen/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class socialLoginCubit extends Cubit<socialLoginStates>{
  socialLoginCubit():super(socialLoginInitialStates());
  //socialLoginCubit(super.socialLoginInitialStates);
  static socialLoginCubit get(context)=>BlocProvider.of(context);
// استاتيك انا بعد كده  Bloc provider .of (contxet مني يعني)<=get(context)



  void userLogin
      ({
    required String email,
    required String password
  }

      ) {
    emit(socialLoginLoadongStates());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
    print(value.user!.uid);
    print(value.user!.email);

    emit(socialLoginSuccessStates(value.user!.uid));
     }).catchError((onError){
       emit(socialLoginErrorStates(onError.toString()));
     });
  }
  IconData suffix=Icons.visibility;
  bool isPasswordShow=true;
  void changePasswordVisibility(){
    isPasswordShow=!isPasswordShow;
    suffix=isPasswordShow?Icons.visibility :Icons.visibility_off_sharp;
    emit(socialChangePassworsdVisibilityState());
  }
}
