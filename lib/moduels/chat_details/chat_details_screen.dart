import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/models/social_user_model.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_cubit.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class chatDetailsScreen extends StatelessWidget {
var messageController=TextEditingController();
  SocialUserModel? socialUserModel;
  chatDetailsScreen({required this.socialUserModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        socialCubit.get(context).getMessages(reciverID: socialUserModel!.uId!);

        return BlocConsumer<socialCubit,socialStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title:Row(children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    '${socialUserModel!.image}'
                ),
              ),
              SizedBox(width:10 ,),
              Text('${socialUserModel!.name}',style: TextStyle(color: Colors.black),)
            ],) ,
          ),
          body: ConditionalBuilder(
            condition: socialCubit.get(context).messages.length>=0,
            builder: (BuildContext context) {return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(itemBuilder:(context,index){
                      var message=socialCubit.get(context).messages[index];
                      if(socialCubit.get(context).socialUserModel!.uId==message.senderID)
                       return buildMyMessage(message);
                      else
                      return  buildMessage(message);

                    },itemCount: socialCubit.get(context).messages.length,separatorBuilder:(context,index)=> SizedBox(height: 15.0,)),
                  ),

                  Row(children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!,width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: 'type your message here…',
                              border: InputBorder.none,


                            ),),
                        ),
                      ),
                    ),SizedBox(width: 5.0,),
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle,
                        color: Colors.blue,
                      ),

                      child: MaterialButton(
                        minWidth: 1.0,
                        onPressed: (){socialCubit.get(context).sendMessage(reciverID: socialUserModel!.uId, dateTime: DateTime.now().toString(), Text: messageController.text);
                        messageController.text = '';
                        }
                        ,child: Icon(IconBroken.Send,size: 16.0,color: Colors.white,),),
                    )
                  ],)
                ],
              ),
            );  },
            fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),

          ),
        ); },

      ); },

    );
  }
}
Widget buildMessage(MessageModel model)=>   Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd:Radius.circular(10.0),
          topEnd:Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        )
    ),
    child: Text('${model.text}'),
  ),
) ;

Widget buildMyMessage(MessageModel model)=>    Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
    decoration: BoxDecoration(
        color: Colors.cyanAccent,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart:Radius.circular(10.0),
          topEnd:Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        )
    ),
    child: Text('${model.text}'),
  ),
) ;