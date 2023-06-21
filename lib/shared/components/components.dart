import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required double? width,
  required double? height,
  required Color? background,
  bool isUpperCase=true,
  required Function onPress ,
  @required String? text,
}) => Container(
  width:width,

  color: background,
  child: MaterialButton(
    onPressed: () {onPress!();},

    child: Text( '${isUpperCase? text!.toUpperCase():text}', style:
    TextStyle(color: Colors.white,
      height: height,

    ),

    ),

  ),
);

Widget defaultTextButton({
  required Function onpress,
  required String text,
})=>  TextButton(onPressed:
    (){onpress!();}, child:Text(text));


Widget defaultFormField({

  required TextInputType? keytype,
  Function? onSubmited,
  Function? onChanged,
  Function? onpress,

  required Function validate,
  required String? label,
  required IconData? preifx,
  Widget? sufix,
  bool? obsecureText ,
  InputBorder? border,
  Function? ontap,
  //Function? suffixPressed,
  TextEditingController? controller,





})=>TextFormField(

  keyboardType:keytype ,//@
  decoration:InputDecoration(
    border: border,
    prefixIcon: Icon(preifx),

    labelText: label,

    suffixIcon: sufix,
  ),

  onFieldSubmitted: (s){
    onSubmited!(s);
  },

  validator:(  value){
    validate(value);
  },

  onTap: (){ontap!();},
  controller:controller,


);


Widget buildArticleItem(article,context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(

            image: NetworkImage('${article['urlToImage']}'),
            fit: BoxFit.cover,

          ),

        ),
      ),
      SizedBox(width: 15.0,),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('${article['title']}',
                style:
                // TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                Theme.of(context).textTheme.bodyLarge,
                maxLines: 4,overflow:TextOverflow.ellipsis ,),

              Text('${article['publishedAt']}',style: TextStyle(
                color: Colors.grey,
              ),)

            ],
          ),
        ),
      )
    ],
  ),
);



void navigateTo(context, page) =>   Navigator.push(context,
    MaterialPageRoute(builder: (context)=>page

    ));

Widget articleBuilder(list,context)=>ConditionalBuilder(
  condition: list.length>1,
  builder:(context)=> ListView.separated(itemBuilder: (context,index)=>buildArticleItem(list[index], context),
      separatorBuilder: (context,index)=>Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1.0,
      ),
      itemCount: 10),
  fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
);

void navigateAndFinish(context,page){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>page), (route) => false

  );
}//used in inboarding screen at shop app


// void showToast({required String msg,required ToastStates state})=>  Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: chooseToastColor(state),
//     textColor: Colors.white,
//     fontSize: 16.0
// );

enum ToastStates{SUCCESS,ERROR,WARRING}

Color? chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red; break;
    case ToastStates.WARRING:
      color= Colors.yellow;break;


  }
  return color;
}

Widget buildListItem( model,context)=>Padding(
    padding: const EdgeInsets.all(25.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 120.0, width: 120.0,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              height: 350.0,
              width: double.infinity,
            ),
            if (1 != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'OFFER',
                  style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.price} EG',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  if (1 != 0)
                    Text(
                      '${model.old_price} EG',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
//                   IconButton(
//                     onPressed: () {
//                       shopCubit.get(context).ChangeFavorites(model.product.id!);
// // print(model.id);
//                     },
//                     icon: CircleAvatar(
//                       backgroundColor:shopCubit.get(context).favorite[model.id]! ? defaultColor:Colors.grey,
//                       child: Icon(
//                         Icons.favorite_border,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
//color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    ]));