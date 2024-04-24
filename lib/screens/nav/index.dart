import 'package:flutter/material.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/nav/first_screen.dart';
import 'package:chatapp/screens/nav/profil.dart';
import 'package:chatapp/screens/nav/second_screen.dart';
import 'package:get/route_manager.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key}); // Définition d'une classe Stateful Widget nommée IndexPage

  @override
  State<IndexPage> createState() => _IndexPageState(); // Création de l'état associé à IndexPage
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Contrôleur d'animation

  int currentPage = 0; // Variable pour suivre la page actuelle

  List<Widget> widgets = []; // Liste des widgets à afficher dans l'IndexedStack

  String titre = "Home"; // Titre de la page par défaut

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this); // Initialisation du contrôleur d'animation

    widgets = [
      FirstPage(),
      SecondPage(),
      ProfilPage(),
      ProfilPage()
    ]; // Initialisation des widgets à afficher dans l'IndexedStack
  }

  @override
  void dispose() {
    _controller.dispose(); // Libération des ressources utilisées par le contrôleur d'animation
    super.dispose();
  }

  Widget createDrawerItem({required IconData icon, required String titre}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          titre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold pour la structure de la page
      drawer: Drawer(
        // Menu latéral de la page
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/image.jpg")
                  )
                ),
              )
            ), // Entête du menu latéral
            createDrawerItem(
              icon: Icons.settings,
              titre: "Parametres hsjsjsjskkskslslslsllslsllslslsllslsllslslsl"
            ), // Élément du menu latéral
            createDrawerItem(
              icon: Icons.lan, 
              titre: "Langue"
            ), // Élément du menu latéral
            Divider() // Séparateur entre les éléments du menu
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(titre),
      ), // Barre d'applications avec le titre dynamique
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {

        }
      ), // Bouton d'action flottant
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Position du bouton d'action flottant
      resizeToAvoidBottomInset: false,
      // Empêche le redimensionnement pour éviter le clavier qui chevauche le contenu
      bottomNavigationBar: BottomAppBar(
        // Barre de navigation en bas de la page
        color: Colors.orange,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          clipBehavior: Clip.antiAlias,

        child: Container(
          color: Colors.orange,
          child: BottomNavigationBar(
            // Barre de navigation en bas de la page
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index; // Met à jour la page actuelle lors de la sélection d'un élément de la barre de navigation
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
              ), // Élément de la barre de navigation
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: "News"
              ), // Élément de la barre de navigation
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Compte"
              ), // Élément de la barre de navigation
              BottomNavigationBarItem(
                icon: Icon(Icons.lock),
                label: "Profil"
              ) // Élément de la barre de navigation
            ]
          ),
        ),
      ),
      body: SafeArea(
        // Contenu principal de la page
        child: IndexedStack(
          index: currentPage,
          children: widgets, // Affiche le widget correspondant à la page actuelle
        )
      )
    );
  }
}
