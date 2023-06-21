import 'package:chat_app/models/social_user_model.dart';
import 'package:chat_app/moduels/chat_details/chat_details_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_cubit.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<socialCubit,socialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {return  ConditionalBuilder(condition: socialCubit.get(context).users.length > 0,
        builder: (BuildContext context) { return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => buildChatItem(socialCubit.get(context).users[index],context),
          separatorBuilder: (BuildContext context, int index) =>Container(color: Colors.grey[300],height: 2.0,width: double.infinity,),
          itemCount: socialCubit.get(context).users.length,); },
        fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
      );  },

    );


  }



}
Widget buildChatItem(SocialUserModel model,context)=>InkWell(
  onTap:(){navigateTo(context, chatDetailsScreen(socialUserModel: model));},
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child:   Row(children: [
  
      CircleAvatar(
  
        radius: 20.0,
  
        backgroundImage: NetworkImage('${model.image}'),
  
      ),
  
      SizedBox(width: 10.0,),
  
      Expanded(
  
        child: Column(
  
          crossAxisAlignment: CrossAxisAlignment.start,
  
          children: [
  
            Row(
  
              children: [
  
                Text('${model.name}',style: TextStyle(fontWeight: FontWeight.bold,height: 1.0),),
  
  
              ],
  
            ),
  
          ],),
  
      ),
  
  
  
    ],),
  ),
);