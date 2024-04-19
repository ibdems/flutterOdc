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
}