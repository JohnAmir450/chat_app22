import 'package:chat_app/models/posts_model.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_cubit.dart';
import 'package:chat_app/social_layout/social_layout_cubit/social_layout_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class FeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit,socialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) { return ConditionalBuilder(
        condition: socialCubit.get(context).posts.length>0 && socialCubit.get(context).socialUserModel!=null,
        builder: (BuildContext context) { return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10.0,
                margin: EdgeInsets.all(10.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      image:
                      NetworkImage('https://img.freepik.com/free-photo/rear-view-programmer-working-all-night-long_1098-18697.jpg?w=900&t=st=1682979395~exp=1682979995~hmac=15035fd6e3bfb6571ee340878d3521296d42b56b786092905944650121f0d819'),
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' be ready to code',style: TextStyle(color: Colors.white),),
                    ),

                  ],
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>buildPostItem(socialCubit.get(context).posts[index],context,index), separatorBuilder:(context,index)=> SizedBox(height: 10.0,)
                  , itemCount: socialCubit.get(context).posts.length),
              SizedBox(height: 10.0,),

            ],
          ),
        ); },
        fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },

      );  },

    );
  }

  Widget buildPostItem(PostModel model , context,index)=>Card(
  margin: EdgeInsets.symmetric(horizontal: 8.0),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 5.0,
  child: Padding(
  padding: const EdgeInsets.all(10.0),
  child: Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: [
  Row(children: [
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
  SizedBox(width: 3.0,),
  Icon(Icons.verified,color: Colors.blue,size: 14.0,)
  ],
  ),
  SizedBox(height: 2.0,),
  Text('${model.dateTime}',style: TextStyle(color: Colors.grey,fontSize: 10.0,height: 1.0),),

  ],),
  ),
  Spacer(),
  IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz,size: 15.0,),)

  ],),
  Padding(
  padding: const EdgeInsets.symmetric(vertical: 15.0),
  child: Container(color: Colors.grey[300],
  width: double.infinity,
  height: 1.0,
  ),
  ),
  Text(
  '${model.text}'),
  Padding(
  padding: const EdgeInsets.symmetric(vertical: 10.0),
  child: Container(
  width: double.infinity,
  child: Wrap(
  children: [
    SizedBox(height: 15.0,),
  //tags//
  // Padding(
  // padding: EdgeInsetsDirectional.only(end: 5.0),
  // child: InkWell(onTap: (){},
  // child: Text('#coding',style: TextStyle(color: Colors.blue),)),
  // ),
  // Padding(
  // padding: EdgeInsetsDirectional.only(end: 5.0),
  // child: InkWell(onTap: (){},
  // child: Text('#flutter',style: TextStyle(color: Colors.blue),)),
  // ),

  ],
  ),
  ),
  ),
  if(model.postImage!='')
  Container(
  height: 140.0,
  width: double.infinity,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),

  image: DecorationImage(

  image:  NetworkImage('${model.postImage}'),
  fit: BoxFit.cover,

  )
  ),
  ),
  Row(children: [
  Expanded(
  child: InkWell(
  onTap: (){},
  child: Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child: Row(
  children: [
  Icon(IconBroken.Heart,color: Colors.red,size: 16.0,),
  SizedBox(width: 5.0,),
  Text('${socialCubit.get(context).likes[index]}',style: TextStyle(color: Colors.grey,fontSize: 10.0),),
  ],
  ),
  ),
  ),
  ),

  Expanded(
  child: InkWell(
  onTap: (){},
  child: Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child: Row(mainAxisAlignment: MainAxisAlignment.end,
  children: [
  Icon(IconBroken.Chat,color: Colors.amber,size: 16.0,),
  SizedBox(width: 5.0,),
  Text('120 comment',style: TextStyle(color: Colors.grey,fontSize: 10.0),),
  ],
  ),
  ),
  ),
  )
  ],),
  Padding(
  padding: const EdgeInsets.only(bottom: 10.0),
  child: Container(color: Colors.grey[300],
  width: double.infinity,
  height: 1.0,
  ),
  ),
  Row(children: [
  Expanded(
  child: Row(
  children: [
  CircleAvatar(
  radius: 15.0,
  backgroundImage: NetworkImage('${model.image}'),
  ),
    SizedBox(width: 5.0,),
  InkWell(
  onTap: (){},child: Text('Write a comment...',style: TextStyle(color: Colors.grey,fontSize: 12.0),)),
  Spacer(),
  InkWell(
  onTap: (){
    socialCubit.get(context).likePost(socialCubit.get(context).postsID[index]);
  },
  child: Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child: Row(
  children: [
  Icon(IconBroken.Heart,color: Colors.red,size: 16.0,),
  SizedBox(width: 5.0,),
  Text('Like',style: TextStyle(color: Colors.grey,fontSize: 10.0),),
  ],
  ),
  ),
  ),
  ],
  ),
  ),
  ],)
  ],),
  ),
  );
}
