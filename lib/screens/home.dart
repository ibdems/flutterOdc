import 'package:chatapp/model/user.dart';
import 'package:chatapp/screens/message.dart';
import 'package:chatapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

double fontSize =  14;
List <User> users = [];
int pageCourante = 10;
PagingController <int, User> pagingController= PagingController(firstPageKey: 1); 

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      getUsersList(page: pageKey);
    });
  }

  void getUsersList({int page = 1}){
    getUsers(page: page, pagingController: pagingController).then((value) => {
      setState(() {
        users = value;
      })
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#181818"),
       appBar: AppBar(
        backgroundColor: HexColor("191919"),
        title: Text(
          "Chat App",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundImage: AssetImage("asset/users/user-1.jpg"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 150,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: List.generate(users.length, (index) {
            //       return createAvatar(users: users[index]);
            //     }),
            //   ),
            // ),
            Container(
              height: 150,
              child: PagedListView(
                scrollDirection: Axis.horizontal,
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, item, index){
                    return createAvatar(users: item);
                  }
                  
                  ),
                  
                
                ),
            ),
            Padding( 
              padding: EdgeInsets.all(10),
              
              child: Text(
                "Messages",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: List.generate(messages.length, (index) {
                return GestureDetector(
                  child: createMessage(messages: messages[index]),
                  onTap: () {
                    // Aller a une page avec le boutton de retour
                    // Get.to(() => MessagePage());

                    // Aller a une page sans le boutton de retour en effasant la derniere ouverte
                    Get.off(() => MessagePage(message: messages[index],));

                    // Aller a une page en supprimant toutes les pages anterieur
                    // Get.offAll(() => MessagePage());
                  }
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget createMessage({required Map messages}){
  // retourner un padding
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
          messages['users']['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // Second property subtitle pour le titre secondaire
        subtitle: Text(
          messages['message']
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
            backgroundImage: AssetImage(messages['users']['image']),
          ),
        ),
        // Pour l'element a droit
        trailing: Column(
          children: [
            Text(messages['heure']),
            SizedBox(height: 4,),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: HexColor("#301C70"),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Center(
                child: Text(messages['status'].toString()),
              ),
            )
          ],
          
        ),
      ),
    );
  }


}



Widget createAvatar({required User users}) {
  return Padding(
    padding: EdgeInsets.all(5),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(users.image),
              ),
              true ? Positioned(
                bottom: 0,
                right: 0,                                                         
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                )
              ): const SizedBox(),
              true ? Positioned(
                
                bottom: 0,
                right: 0,
                child: Container(
                  
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                )
              ): const SizedBox()
            ],
          ),
        ),
        Text(
          users.lastName,
          style: TextStyle(
            color: Colors.white
          ),
        )
      ],
    ),
  );
}
