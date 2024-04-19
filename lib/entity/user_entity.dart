import 'package:floor/floor.dart';
@entity
class Utilisateur {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String nom;
  String prenom;

  Utilisateur({ this.id, required this.nom, required this.prenom});
}