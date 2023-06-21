import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_cubit.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:chat_app/social_register_screen/register_app_cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../social_register_screen/register_app_cubit/register_cubit.dart';
import '../edit/edit_screen.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit,socialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var userModel=socialCubit.get(context).socialUserModel;
        return SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),
                                topRight:Radius.circular(8.0) ,bottomRight: Radius.circular(8.0)),
                            image: DecorationImage(
                              image:  NetworkImage('${userModel!.cover}'),
                              fit: BoxFit.cover,

                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${userModel!.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Text('${userModel!.name}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 4.0,),
              Text('${userModel!.bio}',style: TextStyle(color: Colors.grey),),
              SizedBox(height: 25.0,),
              Row(children: [
                Expanded(
                  child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text('Posts',style: TextStyle(fontSize: 15.0,color: Colors.grey),),
                      SizedBox(height: 4.0,),
                      Text('100',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),)
                    ],),
                  ),
                ),
                Expanded(
                  child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text('Follwers',style: TextStyle(fontSize: 15.0,color: Colors.grey),),
                      SizedBox(height: 4.0,),
                      Text('10K',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),)
                    ],),
                  ),
                ),
                Expanded(
                  child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text('Follwing',style: TextStyle(fontSize: 15.0,color: Colors.grey),),
                      SizedBox(height: 4.0,),
                      Text('2K',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),)
                    ],),
                  ),
                ),
                Expanded(
                  child: InkWell(onTap: (){},
                    child: Column(children: [
                      Text('Saved',style: TextStyle(fontSize: 15.0,color: Colors.grey),),
                      SizedBox(height: 4.0,),
                      Text('30',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),)
                    ],),
                  ),
                ),
              ],),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    
                    Expanded(child: OutlinedButton(onPressed: () {  }, child: Text('Add Photos'),)),
                    SizedBox(width: 3.0,),
                    OutlinedButton(onPressed: () { navigateTo(context, EditProfileScreen()); }, child: Icon(IconBroken.Edit)),
                      
                  ],),
              )

            ],
          ),
      ),
        ); },
    );
  }
}