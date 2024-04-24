import 'package:chatapp/database.dart'; // Importation de la classe de base de données
import 'package:chatapp/entity/user_entity.dart'; // Importation de l'entité utilisateur
import 'package:chatapp/screens/home.dart'; // Importation de l'écran d'accueil
import 'package:chatapp/screens/login.dart'; // Importation de l'écran de connexion
import 'package:chatapp/screens/nav/index.dart'; // Importation de l'écran d'index de navigation
import 'package:floor/floor.dart'; // Importation du package Floor pour la gestion de la base de données
import 'package:flutter/material.dart'; // Importation du package Flutter
import 'package:form_builder_validators/form_builder_validators.dart'; // Importation des validateurs pour les formulaires
import 'package:get/route_manager.dart'; // Importation du package Get pour la gestion de la navigation

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Assure l'initialisation des widgets Flutter

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // Initialisation de la base de données en utilisant Floor avec un nom de fichier et construction

  await database.utilisateurDao.insertUtilisateur(new Utilisateur(nom: "Dems", prenom: 'Ibrahima'));
  // Insertion d'un utilisateur dans la base de données (exemple)

  runApp(MyApp(database: database)); // Exécute l'application avec la base de données initialisée
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.database}); // Constructeur MyApp prenant une base de données en paramètre

  AppDatabase database; // Référence à la base de données

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key, // Clé pour la navigation
      title: 'Flutter Demo', // Titre de l'application
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Thème de couleur
        useMaterial3: true, // Utilisation de Material 3
      ),
      /* home:  Home(database: database,), */
      home: IndexPage(), // Page d'accueil de l'application
      debugShowCheckedModeBanner: false, // Désactivation de la bannière de débogage
      localizationsDelegates: [
        FormBuilderLocalizations.delegate, // Délégués de localisation pour les formulaires
      ],
    );
  }
}
