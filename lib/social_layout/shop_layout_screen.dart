import 'package:chat_app/moduels/new_post/new_post_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_cubit.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class socialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit,socialStates>(
      listener: (BuildContext context, state) {
        if(state is socialNewPostState){
          navigateTo(context, newPostScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit=socialCubit.get(context);

        return Scaffold(appBar: AppBar(
          title: Text(cubit.Titles[cubit.currentIndex])
          ,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
          IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),

        ],
        ),
      body:cubit.screens[cubit.currentIndex],
            bottomNavigationBar:BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              items: [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home,),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Setting'),
            ],

            )

      // ConditionalBuilder(
      //   condition: true,
      //     //socialCubit.get(context).socialUserModel!=null,
      //   builder: (BuildContext context) {
      //     var model=FirebaseAuth.instance.currentUser!.emailVerified;
      //     return
      //       Column(children: [
      //
      //         if( ! model)
      //           Container(
      //             width: 200.0,
      //             child: Row(
      //               children: [
      //                 Expanded(child: Text('please verfiy')),
      //
      //                 SizedBox(width: 20.0,),
      //                 TextButton(
      //
      //                   onPressed: (){
      //                     FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      //
      //                     }).catchError((onError){
      //
      //                     });
      //                   }, child: Text('send Email'),)
      //               ],
      //             ),
      //           ),
      //       ],);
      //
      //   },
      //
      //
      //
      //   fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
      //
      // ),

        );
      },

    );
  }
}
