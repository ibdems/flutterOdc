import 'package:chatapp/entity/user_entity.dart';
import 'package:floor/floor.dart';

@dao

abstract class UtilisateurDao {
  @Query("SELECT * FROM utilisateur")
  Future<List<Utilisateur>> findAllUser();

  @Query("SELECT * FROM utilisateur WHERE id= :id")
  Future <Utilisateur?> findUser(int id);

  @insert
  Future <void> insertUtilisateur(Utilisateur user);

  @Update(onConflict: OnConflictStrategy.replace) /* Ajouter une option de remplacement au cas ou il yaurais conflit entre les cles */
  Future<int> updateUtulisateur (Utilisateur user);
  @delete
  Future<void> deleteUtilisateur(Utilisateur user);
}