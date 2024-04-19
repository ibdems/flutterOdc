import 'package:chatapp/database.dart';
import 'package:chatapp/entity/user_entity.dart';
import 'package:chatapp/screens/home.dart';
import 'package:chatapp/screens/login.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  await database.utilisateurDao.insertUtilisateur(new Utilisateur(nom: "Dems", prenom: 'Ibrahima'));



  print(Utilisateur); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
    ],
    );
  }
}
