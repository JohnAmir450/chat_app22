

import 'dart:io';

import 'package:chat_app/social_layout/social_layout_cubit/social_layout_cubit.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:chat_app/social_register_screen/social_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
var nameController=TextEditingController();
var PioController=TextEditingController();
var PhoneController=TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit,socialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        var userModel=socialCubit.get(context).socialUserModel;
        var profileImage=socialCubit.get(context).profileImage;
        var coverImage=socialCubit.get(context).coverImage;

        nameController.text=userModel!.name!;
        PioController.text=userModel!.bio!;
        PhoneController.text=userModel!.phone!;

        return Scaffold(

        appBar: AppBar(leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(IconBroken.Arrow___Left_2),),
          title: Text('Edit your profile'),
          titleSpacing: 5.0,
          actions: [
            TextButton(onPressed: (){
              socialCubit.get(context).updateUser(name: nameController.text, phone: PhoneController.text, bio: PioController.text);
            }, child: Text('UPDATE',style: TextStyle(color: Colors.white),))
            ,SizedBox(width: 10.0,),
          ],

        ),
        body:

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: [
              if(state is socialUserUpdateLoadingStates)
                LinearProgressIndicator(),
              SizedBox(height: 10.0,),
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 140.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),
                                    topRight:Radius.circular(8.0) ,bottomRight: Radius.circular(8.0)),
                                image: DecorationImage(
                                  image: coverImage==null? NetworkImage('${userModel!.cover}'):FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,

                                )
                            ),
                          ),
                          IconButton(onPressed: (){
                            socialCubit.get(context).getCoverImage();
                          }, icon: CircleAvatar(radius:15.0,child: Icon(IconBroken.Camera))),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundImage: profileImage==null ? NetworkImage('${userModel!.image}'):FileImage(profileImage) as ImageProvider,
                          ),
                          IconButton(onPressed: (){
                            socialCubit.get(context).getProfileImage();
                          }, icon: CircleAvatar(radius:15.0,child: Icon(IconBroken.Camera))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0,),
              if(socialCubit.get(context).profileImage!=null || socialCubit.get(context).coverImage!=null)
              Row(
                children: [
                  if(socialCubit.get(context).profileImage!=null)
                  Expanded(
                    child: Column(
                      children: [
                        Container(

                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextButton(onPressed: (){socialCubit.get(context).uploadProfileImage(name: nameController.text,
                                phone: phoneController.text,
                                bio: PioController.text);}, child: Text('Upload Profile'))),
                        SizedBox(height: 5.0,),
                        if(state is socialUserUpdateLoadingStates)
                        LinearProgressIndicator(),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  if(socialCubit.get(context).coverImage!=null)
                  Expanded(
                    child: Column(
                      children: [
                        Container(

                        decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                            )
                            ,child: TextButton(onPressed: (){socialCubit.get(context).uploadCoverImage(name: nameController.text,
                            phone: phoneController.text, bio: PioController.text);}, child: Text('Upload Cover'))),
                        SizedBox(height: 5.0,),
                        if(state is socialUserUpdateLoadingStates)
                        LinearProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: nameController,
                validator: (String? value){if (value!.isEmpty){
                return 'New name must be added';
                }
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  label: Text('Edit your name'),
                  border:OutlineInputBorder(),
                  prefixIcon: Icon(IconBroken.User)

                ),
              ),
              SizedBox(height: 8.0,),
              TextFormField(
                controller: PioController,
                validator: (String? value){if (value!.isEmpty){
                  return 'New bio must be added';
                }
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: Text('Edit your bio'),
                    border:OutlineInputBorder(),
                    prefixIcon: Icon(IconBroken.Info_Circle)

                ),
              ),
              SizedBox(height: 8.0,),
              TextFormField(
                controller: PhoneController,
                validator: (String? value){if (value!.isEmpty){
                  return 'New Phone number must be added';
                }
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    label: Text('Edit your phone number'),
                    border:OutlineInputBorder(),
                    prefixIcon: Icon(IconBroken.Call)

                ),
              ),
            ],),
          ),
        ),
      );},

    );
  }
}
