import 'package:chat_app/network/local/cashhelper.dart';
import 'package:chat_app/social_layout/shop_layout_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/components/components.dart';
import '../social_register_screen/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return    BlocProvider(
      create: (BuildContext context)  => socialLoginCubit(),
      child: BlocConsumer<socialLoginCubit,socialLoginStates>(
        listener: (BuildContext context, state) {
          if(state is socialLoginSuccessStates ){
            cacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            navigateAndFinish(context, socialLayout());
            });
          }
        },
        builder: (BuildContext context, Object? state) { return
          Scaffold(
            appBar: AppBar(),
            body:
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style: GoogleFonts.alegreya(fontSize: 30.0,fontWeight: FontWeight.bold),
                        ),
                        Text('Login Now To Meet New Friends ',style: GoogleFonts.aclonica(fontSize: 20.0,color: Colors.grey),),
                        SizedBox(height: 30.0),



                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'Please Enter Your E-mail Address';
                            }

                          },
                          decoration: InputDecoration(
                            label: Text('E-mail Address'),
                            prefixIcon: Icon(Icons.alternate_email,),
                            border: OutlineInputBorder(),


                          ),
                        ),
                        SizedBox(height: 15.0,),



                        TextFormField(
                          onFieldSubmitted: (value){
                            if(formkey.currentState!.validate()) {
                              // socialLoginCubit.get(context).userLogin(
                              //     email: emailController.text, password: passwordController.text);
                            }   },
                          controller: passwordController,
                          obscureText: socialLoginCubit.get(context).isPasswordShow,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'Password must be added';
                            }
                          },
                          decoration: InputDecoration(

                              label: Text('Password'),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.password),

                              suffixIcon: IconButton(onPressed: () {
                                socialLoginCubit.get(context).changePasswordVisibility();
                              },icon: Icon(socialLoginCubit.get(context).suffix),)

                          ),
                        ),
                        SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition:state is socialLoginStates ,
                          builder: (context)=> defaultButton(width: double.infinity,

                            background: Colors.blue,
                            text: 'Login',

                            height: 2.2,
                            onPress: (){

                              if(formkey.currentState!.validate()){
                                socialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);

                              }

                            },

                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),


                        ),
                        SizedBox(height: 8.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(onpress: (){navigateTo(context,socialRegisterScreen() );}, text: 'Register Now',)
                            // TextButton(onPressed: (){navigateTo(context,registerScreen() );}, child:Text('Register Now',style: GoogleFonts.aclonica(color: Colors.blue),))
                          ],)

                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          );

        },


      ),
    );
  }
}