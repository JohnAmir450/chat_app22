



import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../../social_layout/shop_layout_screen.dart';
import '../../social_layout/social_layout_cubit/social_layout_cubit.dart';
import '../feed/feeds_screen.dart';

class newPostScreen extends StatelessWidget {

var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<socialCubit,socialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var userModel=socialCubit.get(context).socialUserModel;
        return

        Scaffold(


        appBar: AppBar(elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black),

          leading:IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(IconBroken.Arrow___Left_2),),
          title: Text('Create Post',),actions: [
          TextButton(onPressed: (){
            var now=DateTime.now();
            if(socialCubit.get(context).postImage==null){
              socialCubit.get(context).CreatePost(dateTime: now.toString(), text: textController.text);
            }else
              {
                socialCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
              }
            navigateTo(context, socialLayout());
          }, child: Text('POST',style: TextStyle(),))
        ],),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [
              Row(children: [
                if(state is socialCreatePostLoadingStates )
                LinearProgressIndicator(),
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage('${userModel!.image}'),
                ),
                SizedBox(width: 10.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${userModel!.name}',style: TextStyle(fontWeight: FontWeight.bold,height: 1.0),),
                          // SizedBox(width: 3.0,),
                          // Icon(Icons.verified,color: Colors.blue,size: 14.0,)
                        ],
                      ),


                    ],),
                ),


              ],),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'what is on your mind…',
                  border: InputBorder.none


                ),),
              ),
              if(socialCubit.get(context).postImage!=null)
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: FileImage(
                              socialCubit.get(context).postImage!),
                          fit: BoxFit.cover
                        )),
                  ),
                  IconButton(
                      onPressed: () {

                        socialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ))
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      socialCubit.get(context).getPostImage();
                    }, child:Row(children: [
                      Icon(IconBroken.Image,),SizedBox(width: 3.0,),Text('Add Photos'),
                Spacer(),
                Expanded(
                    child: TextButton(onPressed: (){}, child:Row(children: [
                      Icon(Icons.tag,),SizedBox(width: 3.0,),Text('Add Tags'),

                      ],) ),
                ),
                ],
              ),

                    ),
                  )],
          ),
        ]),
      )); },

    );
  }
}
