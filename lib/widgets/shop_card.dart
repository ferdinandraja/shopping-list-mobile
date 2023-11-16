import 'package:shopping_list/screen/shoplist_form.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/screen/list_product.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screen/login.dart';
class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}
class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {Key? key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Responsive touch area
        onTap: () async {
    // Show SnackBar when clicked
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text("You pressed the ${item.name} button!")));

    // Navigate to the appropriate route (depending on the button type)
    if (item.name == "Add Product") {
      // TODO: Use Navigator.push to navigate to a MaterialPageRoute that encompasses ShopFormPage.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ShopFormPage(),
        ));
    }
    else if (item.name == "View Products") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProductPage()));
      }
    else if (item.name == "Logout") {
        final response = await request.logout(
            // TODO: Change the URL to your Django app's URL. Don't forget to add the trailing slash (/) if needed.
            "http://127.0.0.1:8000/auth/logout/");
        String message = response["message"];
        if (response['status']) {
          String uname = response["username"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$message Good bye, $uname."),
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$message"),
          ));
        }
      }
  },
        child: Container(
          // Container to hold Icon and Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}