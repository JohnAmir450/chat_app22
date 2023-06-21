import 'package:chat_app/social_register_screen/register_app_cubit/register_cubit.dart';
import 'package:chat_app/social_register_screen/register_app_cubit/register_states.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/components.dart';
import '../social_layout/shop_layout_screen.dart';

var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();
var passwordController=TextEditingController();
var nameController=TextEditingController();
var phoneController=TextEditingController();

class socialRegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => socialRegisterCubit(),
      child: BlocConsumer<socialRegisterCubit,socialRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is socialCreateUserSuccessStates){
            navigateAndFinish(context, socialLayout());
          }

        },
        builder: (BuildContext context, Object? state) {

          return  Scaffold(
              appBar: AppBar(),
              body:
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER', style: GoogleFonts.alegreya(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          Text('Register Now To Meet New Friends ',
                            style: GoogleFonts.aclonica(
                                fontSize: 20.0, color: Colors.grey),),
                          SizedBox(height: 30.0),

                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            decoration: InputDecoration(
                              label: Text('Name'),
                              prefixIcon: Icon(Icons.person,),
                              border: OutlineInputBorder(),


                            ),
                          ),
                          SizedBox(height: 15.0,),

                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
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
                            controller: passwordController,
                            obscureText: socialRegisterCubit.get(context)
                                .isPasswordShow,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'password must be added';
                              }
                            },

                            decoration: InputDecoration(

                                label: Text('Password'),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.password),

                                suffixIcon: IconButton(onPressed: () {
                                  socialRegisterCubit.get(context)
                                      .changePasswordVisibility();
                                }, icon: Icon(socialRegisterCubit
                                    .get(context)
                                    .suffix),)

                            ),
                          ),
                          SizedBox(height: 15.0,),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Phone Number';
                              }
                            },
                            decoration: InputDecoration(
                              label: Text('Phone Number'),
                              prefixIcon: Icon(Icons.phone,),
                              border: OutlineInputBorder(),


                            ),
                          ),
                          SizedBox(height: 15.0,),

                          SizedBox(height: 30.0,),
                          ConditionalBuilder(
                            condition: state is ! socialRegisterLoadongStates,
                            builder: (context) =>
                                defaultButton(width: double.infinity,

                                  background: Colors.deepOrange,
                                  text: 'Register',

                                  height: 2.2,
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      socialRegisterCubit.get(context).userRegister(
                                        name:nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                     );


                                    }
                                  },

                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),


                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              )
          ); },


      ),
    );
  }
}
