import 'package:animate_do/animate_do.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/entity/user_entity.dart';
import 'package:chatapp/model/user.dart';
import 'package:chatapp/screens/message.dart';
import 'package:chatapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:animate_do/animate_do.dart'; // Importation de la bibliothèque animate_do pour les animations
import 'package:chatapp/database.dart'; // Importation du fichier de base de données
import 'package:chatapp/entity/user_entity.dart'; // Importation de l'entité utilisateur
import 'package:chatapp/model/user.dart'; // Importation du modèle utilisateur
import 'package:chatapp/screens/message.dart'; // Importation de l'écran de message
import 'package:chatapp/utils.dart'; // Importation de fichiers utilitaires
import 'package:flutter/material.dart'; // Importation du package de base Flutter
import 'package:flutter/widgets.dart'; // Importation du package de widgets Flutter
import 'package:flutter_form_builder/flutter_form_builder.dart'; // Importation du package FormBuilder pour les formulaires réactifs
import 'package:get/route_manager.dart'; // Importation de Get pour la gestion des routes
import 'package:getwidget/getwidget.dart'; // Importation de GetWidget pour les widgets personnalisés
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'; // Importation de la pagination infinie

// Définition de la classe Home qui est un StatefulWidget
class Home extends StatefulWidget {
  Home({super.key, required this.database}); // Constructeur de la classe Home
  AppDatabase database; // Base de données de l'application
  @override
  State<Home> createState() => _HomeState(); // Création de l'état de la page d'accueil
}

double fontSize = 14; // Taille de police par défaut
List<User> users = []; // Liste des utilisateurs
int pageCourante = 10; // Page actuelle
PagingController<int, User> pagingController = PagingController(firstPageKey: 1); // Contrôleur de pagination

// Classe d'état de la page d'accueil
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var _formKey = new GlobalKey<FormBuilderState>(); // Clé globale pour le formulaire
  @override
  void initState() {
    // Initialisation de l'état de la page
    super.initState(); // Appel à la méthode initState du parent
    pagingController.addPageRequestListener((pageKey) {
      getUsersList(page: pageKey); // Ajout d'un écouteur de demande de page pour la pagination
    });
  }

  // Fonction pour récupérer la liste des utilisateurs
  void getUsersList({int page = 1}) {
    getUsers(page: page, pagingController: pagingController).then((value) => {
      setState(() {
        users = value; // Mise à jour de la liste des utilisateurs à afficher
      })
    });
  }

  // Construction de l'interface utilisateur de la page d'accueil
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#181818"), // Couleur de fond de l'application

      /* Ajout d'un bouton flottant pour ajouter un utilisateur, avec un formulaire */
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), // Icône d'ajout
        backgroundColor: Colors.orange, // Couleur de fond du bouton
        onPressed: () {
          // Action lorsque le bouton est pressé
          Get.bottomSheet( // Affichage d'une bottom sheet avec GetX
            Container(
              height: MediaQuery.of(context).size.height / 2, // Hauteur de la bottom sheet
              decoration: BoxDecoration(
                color: Colors.white, // Couleur de fond de la bottom sheet
                borderRadius: BorderRadius.circular(20), // Bordure arrondie de la bottom sheet
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("asset/images/google.png"), // Image du logo
                      ),
                      title: Text("Ajout d'un utilisateur"), // Titre de la bottom sheet
                      subtitle: Text("Formulaire d'enregistrement"), // Sous-titre de la bottom sheet
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: FormBuilderTextField(
                              name: "nom",
                              decoration: InputDecoration(
                                labelText: "Nom de famille",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: FormBuilderTextField(
                              name: "prenom",
                              decoration: InputDecoration(
                                labelText: "Prenom",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: GFButton(
                              text: "Sauvergarder",
                              color: Colors.orange,
                              size: GFSize.LARGE,
                              fullWidthButton: true,
                              shape: GFButtonShape.pills,
                              onPressed: () {

                                if(_formKey.currentState!.saveAndValidate()) {

                                  widget.database.utilisateurDao.insertUtilisateur(
                                    Utilisateur(
                                      nom: _formKey.currentState!.value['nom'], 
                                      prenom:  _formKey.currentState!.value['prenom'],
                                      
                                    )
                                  );

                                  setState(() {
                                    
                                  });

                                  Get.snackbar("Success", "Succees");
                                }
                                
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                
              )
            )
          );
        }
      ),
       appBar: AppBar(
        backgroundColor: HexColor("191919"), // Couleur de la barre d'application
        title: Text(
          "Chat App", // Titre de l'application
          style: TextStyle(color: Colors.white), // Couleur du texte
        ),
        centerTitle: true, // Centrer le titre
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("#181818"),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.black, width: 2),
              ),
              height: 45,
              width: 45,
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
          )
        ],
        elevation: 0, // Pas d'ombre sous la barre d'application
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundImage: AssetImage("asset/users/user-1.jpg"), // Image de profil à gauche de la barre
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Conteneur pour afficher la liste des utilisateurs
            Container(
              height: 180,
              child: PagedListView(
                scrollDirection: Axis.horizontal,
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  firstPageProgressIndicatorBuilder: (context) {
                    // Indicateur de chargement pendant le chargement initial
                    return Row(
                      children: List.generate(6, (index) {
                        return createAvatarPlaceholder(); // Créer un placeholder pour l'avatar de l'utilisateur
                      })
                    );
                    
                  },
                  itemBuilder: (context, item, index) {
                    return createAvatar(users: item); // Créer un avatar pour chaque utilisateur
                  },
                ),
              ),
            ),
            Padding( 
              padding: EdgeInsets.all(10),
              
              child: Text(
                "Messages", // Titre de la section des messages
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            // Affichage de la liste des utilisateurs à partir de la base de données locale
            FutureBuilder(
              future:widget.database.utilisateurDao.findAllUser(), // Récupération de tous les utilisateurs de la base de données
              builder:(context, data){
                if(data.connectionState == ConnectionState.active) {
                  return CircularProgressIndicator(); // Affichage d'un indicateur de chargement pendant la récupération des données
                }

                if(!data.hasError && data.hasData){
                  List<Utilisateur> users = data.data as List<Utilisateur>; // Récupération de la liste des utilisateurs depuis les données

                  return ListView(
                    shrinkWrap: true,
                    children: users.map((user) {
                      return FadeInLeft(
                        duration: Duration(seconds: 1),
                        child: Dismissible(
                        key: Key(user.id.toString()), // Clé de l'utilisateur pour le widget Dismissible
                        child: createUserUi(users: user), // Créer l'interface utilisateur pour l'utilisateur
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Icon(Icons.delete, color: Colors.white,),
                              color: Colors.red,
                              height: double.infinity,
                              width: MediaQuery.of(context).size.height/5,
                            ),
                            Container(
                              child: Icon(Icons.archive, color: Colors.white,),
                              color: Colors.red,
                              height: double.infinity,
                              width: MediaQuery.of(context).size.height/5,
                            ),
                          ],
                        ),
                        onDismissed: (direction) async {
                          users.remove(user); // Supprimer l'utilisateur de la liste
                          await widget.database.utilisateurDao.deleteUtilisateur(user); // Supprimer l'utilisateur de la base de données
                          setState(() {
                            
                          });
                        },
                        ) 
                      
                      );
                    }).toList(),
                  );
                }
                return SizedBox();
              }
              
              ),
            ListView(
              shrinkWrap: true,
              children: List.generate(messages.length, (index) {
                return GestureDetector(
                  child: createMessage(messages: messages[index]), // Créer un widget de message pour chaque message
                  onTap: () {
                    Get.off(() => MessagePage(message: messages[index],)); // Afficher la page de message lorsque le message est tapé
                  }
                );
              }),
            )
          ],
        ),
      ),
    );
  }





Widget createUserUi({required Utilisateur users}) {
  return Padding(
      // Definir les marges du padding
      padding: EdgeInsets.only(
        bottom: 5,
        left: 8,
        right: 8
      ),
      /* Utilisation d'une liste title pour retourner les messages */
      child: ListTile(
        textColor: Colors.white,
        // First property title pour le titre principale
        title: Text(
          "${users.nom} ${users.prenom}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // Second property subtitle pour le titre secondaire
        subtitle: Text(
          '63532765'
        ),
        // Pour l'element a gauche
        leading: GestureDetector(
          onTap: () {
            setState(() {
              fontSize < 25 ? fontSize = fontSize + 2 : fontSize = fontSize - 2;
            });
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('asset/users/user-3.jpg'),
          ),
        ),
        // Pour l'element a droit
        trailing: Column(
          children: [
            IconButton(onPressed: (){UpdateUserUi(users: users);}, icon: Icon(Icons.edit), color: Colors.white,)
          ],
          
        ),
      ),
    );
}


void UpdateUserUi({required Utilisateur users}) {
  // Fonction pour afficher une bottom sheet pour mettre à jour les informations de l'utilisateur

  Get.bottomSheet(
    // Affiche une bottom sheet avec GetX
    Container(
      // Conteneur de la bottom sheet
      height: MediaQuery.of(context).size.height / 2, // Hauteur de la bottom sheet
      decoration: BoxDecoration(
        color: Colors.white, // Couleur de fond de la bottom sheet
        borderRadius: BorderRadius.circular(20), // Bordure arrondie de la bottom sheet
      ),
      child: Padding(
        // Padding autour du contenu de la bottom sheet
        padding: EdgeInsets.all(10),

        child: Column(
          // Colonne contenant le contenu de la bottom sheet
          children: [
            ListTile(
              // Élément de liste pour le titre de la bottom sheet
              leading: CircleAvatar(
                // Avatar circulaire
                backgroundColor: Colors.transparent, // Fond transparent de l'avatar
                backgroundImage: AssetImage("asset/images/google.png"), // Image de l'avatar
              ),
              title: Text("Modification d'un utilisateur"), // Titre de la bottom sheet
              subtitle: Text("Formulaire de modification"), // Sous-titre de la bottom sheet
            ),

            FormBuilder(
              // Utilisation de FormBuilder pour créer un formulaire réactif
              key: _formKey, // Clé du formulaire
              child: Column(
                // Colonne contenant les champs du formulaire
                children: [
                  Padding(
                    // Padding autour du champ "Nom de famille"
                    padding: EdgeInsets.all(10),
                    child: FormBuilderTextField(
                      // Champ de texte pour le nom de famille
                      initialValue: users.nom, // Valeur initiale du champ
                      name: "nom", // Nom du champ
                      decoration: InputDecoration(
                        // Décoration du champ
                        labelText: "Nom de famille", // Etiquette du champ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5), // Bordure arrondie du champ
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    // Padding autour du champ "Prénom"
                    padding: EdgeInsets.all(10),
                    child: FormBuilderTextField(
                      // Champ de texte pour le prénom
                      name: "prenom", // Nom du champ
                      initialValue: users.prenom, // Valeur initiale du champ
                      decoration: InputDecoration(
                        // Décoration du champ
                        labelText: "Prénom", // Etiquette du champ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5), // Bordure arrondie du champ
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    // Padding autour du bouton "Modifier"
                    padding: EdgeInsets.all(10),
                    child: GFButton(
                      // Bouton pour soumettre le formulaire de modification
                      text: "Modifier", // Texte du bouton
                      color: Colors.orange, // Couleur du bouton
                      size: GFSize.LARGE, // Taille du bouton
                      fullWidthButton: true, // Bouton largeur pleine
                      shape: GFButtonShape.pills, // Forme du bouton
                      onPressed: () {
                        // Fonction exécutée lorsque le bouton est pressé

                        if (_formKey.currentState!.saveAndValidate()) {
                          // Vérifie si le formulaire est valide

                          widget.database.utilisateurDao.updateUtulisateur(
                            // Met à jour l'utilisateur dans la base de données
                            Utilisateur(
                              id: users.id,
                              nom: _formKey.currentState!.value['nom'], // Nom de famille modifié
                              prenom: _formKey.currentState!.value['prenom'], // Prénom modifié
                            ),
                          );

                          // Get.back(); // Retourne en arrière pour fermer la bottom sheet
                          setState(() {}); // Actualise l'interface utilisateur

                          Get.snackbar("Success", "Succès"); // Affiche un message de succès
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



 Widget createMessage({required Map messages}) {
  // Fonction pour créer un widget de message, prenant un map de messages comme paramètre

  return Padding(
    // Retourne un widget Padding pour ajouter de l'espace autour du widget enfant
    padding: EdgeInsets.only(
      bottom: 5,
      left: 8,
      right: 8,
    ), // Définit les marges du widget Padding

    child: ListTile(
      // Utilisation d'un widget ListTile pour afficher un élément de liste structuré
      textColor: Colors.white, // Couleur du texte dans le ListTile

      title: Text(
        messages['users']['name'], // Titre principal du ListTile, affichant le nom de l'utilisateur
        style: TextStyle(
          fontWeight: FontWeight.bold, // Style du texte en gras
        ),
      ),

      subtitle: Text(messages['message']), // Sous-titre du ListTile, affichant le message

      leading: GestureDetector(
        // Widget leading, affiché à gauche du ListTile, pour l'image de profil de l'utilisateur
        onTap: () {
          // Fonction exécutée lorsque l'utilisateur appuie sur l'image de profil
          setState(() {
            // Mise à jour de l'état pour changer la taille de la police
            fontSize < 25 ? fontSize = fontSize + 2 : fontSize = fontSize - 2;
          });
        },
        child: CircleAvatar(
          // Affiche une image de profil arrondie
          radius: 30, // Rayon du cercle
          backgroundImage: AssetImage(messages['users']['image']), // Image de profil de l'utilisateur
        ),
      ),

      trailing: Column(
        // Widget trailing, affiché à droite du ListTile, pour l'heure du message et le statut
        children: [
          Text(messages['heure']), // Affiche l'heure du message
          SizedBox(height: 4), // Widget SizedBox pour ajouter de l'espace vertical
          Container(
            // Widget Container pour afficher le statut du message dans un cercle coloré
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: HexColor("#301C70"), // Couleur de fond du conteneur
              borderRadius: BorderRadius.all(Radius.circular(15)), // Bordure arrondie
            ),
            child: Center(
              // Centre le texte dans le conteneur
              child: Text(messages['status'].toString()), // Affiche le statut du message
            ),
          ),
        ],
      ),
    ),
  );
}

}



Widget createAvatar({required User users}) {
  // Fonction pour créer un widget d'avatar avec les informations de l'utilisateur

  return Padding(
    // Retourne un widget Padding pour ajouter de l'espace autour du widget enfant
    padding: EdgeInsets.all(5),

    child: Column(
      // Colonne contenant l'avatar et le nom de l'utilisateur
      children: [
        Padding(
          // Padding autour de l'avatar
          padding: EdgeInsets.all(5),

          child: Stack(
            // Utilisation d'un stack pour superposer des éléments
            children: [
              CircleAvatar(
                // Avatar de l'utilisateur sous forme de cercle
                radius: 40, // Rayon du cercle
                backgroundImage: NetworkImage(users.image), // Image de l'avatar récupérée depuis une URL
              ),

              // Condition ternaire pour afficher une marque de statut (par exemple, point vert ou noir) si true
              true ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    color: Colors.black, // Couleur du cercle de statut (noir)
                    borderRadius: BorderRadius.all(Radius.circular(20)), // Bordure arrondie
                  ),
                ),
              ) : const SizedBox(), // Si la condition est fausse, affiche un SizedBox (espace vide)

              true ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.green, // Couleur du cercle de statut (vert)
                    borderRadius: BorderRadius.all(Radius.circular(20)), // Bordure arrondie
                  ),
                ),
              ) : const SizedBox(), // Si la condition est fausse, affiche un SizedBox (espace vide)
            ],
          ),
        ),

        Text(
          users.lastName, // Affiche le nom de l'utilisateur
          style: TextStyle(
            color: Colors.white, // Couleur du texte (blanc)
          ),
        ),
      ],
    ),
  );
}

Widget createAvatarPlaceholder() {
  // Fonction pour créer un widget d'avatar de remplacement (placeholder)

  return Padding(
    // Retourne un widget Padding pour ajouter de l'espace autour du widget enfant
    padding: EdgeInsets.all(10),

    child: Column(
      // Colonne contenant l'avatar de remplacement et un conteneur rouge
      children: [
        Padding(
          // Padding autour de l'avatar de remplacement
          padding: EdgeInsets.all(5),

          child: Stack(
            // Utilisation d'un stack pour superposer des éléments
            children: [
              CircleAvatar(
                // Avatar de remplacement sous forme de cercle
                radius: 40, // Rayon du cercle
                child: GFShimmer(
                  // Effet de scintillement pour simuler le chargement
                  showGradient: true,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.black,
                      Colors.yellow,
                      Colors.green,
                    ],
                  ),
                  child: SizedBox(), // Aucun enfant dans le scintillement
                ),
              ),

              // Condition ternaire pour afficher une marque de statut (par exemple, point vert ou noir) si true
              true ? Positioned(
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    color: Colors.black, // Couleur du cercle de statut (noir)
                    borderRadius: BorderRadius.all(Radius.circular(20)), // Bordure arrondie
                  ),
                ),
              ) : const SizedBox(), // Si la condition est fausse, affiche un SizedBox (espace vide)

              true ? Positioned(
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.green, // Couleur du cercle de statut (vert)
                    borderRadius: BorderRadius.all(Radius.circular(20)), // Bordure arrondie
                  ),
                ),
              ) : const SizedBox(), // Si la condition est fausse, affiche un SizedBox (espace vide)
            ],
          ),
        ),

        Container(
          // Conteneur rouge en dessous de l'avatar de remplacement
          height: 10, // Hauteur du conteneur
          color: Colors.red, // Couleur du conteneur (rouge)
        ),
      ],
    ),
  );
}

