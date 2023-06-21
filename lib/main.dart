import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/network/local/cashhelper.dart';
import 'package:chat_app/shared/constants/constants.dart';
import 'package:chat_app/social_layout/shop_layout_screen.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_cubit.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer/bloc_observer.dart';
import 'login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

    var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print (event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print (event.data.toString());
  });
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  Widget widget;
     uid=cacheHelper.getData(key: 'uId');
  Bloc.observer=MyBlocObserver();
  if(uid !=null){
    widget=socialLayout();
  }
  else{
    widget=SocialLoginScreen();
  }



  runApp( MyApp(startWidget:widget));

}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>socialCubit()..getUserData()..getPosts()..getUsers(),
      child: BlocConsumer<socialCubit,socialStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {return MaterialApp(
          title: 'Chat App',
          theme: ThemeData(
          //  appBarTheme:AppBarTheme(backgroundColor: Theme.of(context).scaffoldBackgroundColor,elevation: 0.0) ,
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0
            )
          ),


          home:  startWidget,
        );  },

      ),
    );
  }
}


