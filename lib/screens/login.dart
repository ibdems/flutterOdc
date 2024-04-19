import 'package:chatapp/model/user.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormBuilderState>();


  void login ({required Map data}) async {
    var dioClient = new dio.Dio();
    ProgressDialog dialog = ProgressDialog(context: context);
    dialog.show(
      max:100,
      msg: "Patienter"
    );
    try {
      dio.Response response = await dioClient.post (
        "https://reqres.in/api/login",
        data: data
      );
      dialog.close();
    } catch (e) {
      Get.snackbar("Erreur", "Email ou mot de passe invalide",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        icon: Icon(Icons.error)
      );

      dialog.close();
    }
  }
  
   @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('asset/images/fleur.jpg')),
      ),
      
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Padding(padding: EdgeInsets.all(15),
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create",
                style: TextStyle(fontSize: 30),
              ),
              FormBuilder(
                key: _formKey,
                child: Column(children: [
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Champ obligatoire"),
                      FormBuilderValidators.email(errorText: "Email requis"),

                    ]),
                    name: 'email',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
                      label: Text("Email"),
                      hintText: "Entrer votre email",
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(height: 10,),
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: "Champ obligatoire"),
                        FormBuilderValidators.min(4, inclusive: true, errorText: "Min 4")
                    ]),
                    name: 'password',
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 15,
                      
                        color: Colors.white
                      ),
                      label: Text("Mot de passe"),
                      hintText: "Entrer votre mot de passe",
                      icon: Icon(Icons.password),
                      
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GFButton(
                      shape: GFButtonShape.pills,
                      fullWidthButton: true,
                      textColor: Colors.white,
                      size: GFSize.LARGE,
                      color: GFColors.SUCCESS,
                      text: "Connexion",
                      onPressed: () { 
                        if(_formKey.currentState!.saveAndValidate()){
                          print(_formKey.currentState!.value);
                          login(data: _formKey.currentState!.value);
                        }else{
                          print("Erreur");
                        }
                       },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GFButton(
                      shape: GFButtonShape.pills,
                      // Pour enlever la couleur fond du bouton
                      type: GFButtonType.outline,
                      fullWidthButton: true,
                      textColor: Colors.white,
                      size: GFSize.LARGE,
                      color: GFColors.SUCCESS,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text (
                              "Connecter vous avec",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ), 
                            ),
                            Image.asset("asset/images/google.png")
                          ],
                        ),
                      ),
                      onPressed: null,
                    ),
                  )
                ],)
              )
            ],
          ),
        ),
      ),
    );
  }
}