import 'dart:ui';

class HexColor extends Color {
    static int _getColorFromHex(String hexColor) {
        hexColor = hexColor.toUpperCase().replaceAll("#", "");
        if (hexColor.length == 6) {
            hexColor = "FF" + hexColor;
        }
        return int.parse(hexColor, radix: 16);
    }

    HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

List users = [
  {
    'name' : 'Dems',
    'image' : 'asset/users/user-3.jpg',
    'statut' : true,
  },
  {
    'name' : 'Dems',
    'image' : 'asset/users/user-2.jpg',
    'statut' : false,
  },
  {
    'name' : 'Dems',
    'image' : 'asset/users/user-4.jpg',
    'statut' : true,
  },
  {
    'name' : 'Dems',
    'image' : 'asset/users/user-5.jpg',
    'statut' : false,
  },
  {
    'name' : 'Dems',
    'image' : 'asset/users/user-6.jpg',
    'statut' : true,
  }
];

List messages = [
  {
    'users': users[0],
    'message': 'Hello friend',
    'heure': '12H 30',
    'status': 1
  },
  {
    'users': users[2],
    'message': 'Hello friend',
    'heure': '12H 30',
    'status': 2
  },
  {
    'users': users[3],
    'message': 'Hello friend',
    'heure': '12H 30',
    'status': 1
  },
  {
    'users': users[4],
    'message': 'Hello friend',
    'heure': '12H 30',
    'status': 4
  }
];