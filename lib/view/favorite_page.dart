import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            iconSize: 30,
          ),
        ),
        title: Text(
          "Favorite Detail",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1B1241),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
          ),
          ListView.builder(
            itemCount: homeProvider.favoriteItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: NetworkImage(
                    homeProvider.favoriteItems[index].image,
                  ),
                  backgroundColor: Color(0xff1B1241),
                ),
                  trailing: IconButton(
                      onPressed: () {
                        homeProvider.removeFavorite(homeProvider.favoriteItems[index]);
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        size: 35,
                        color: Colors.white,
                      )),
                  title: Text(homeProvider.favoriteItems[index].name,style: TextStyle( fontSize: 25,color: Colors.white,),),
                subtitle: Text(homeProvider.favoriteItems[index].type,style: TextStyle(color: Colors.white),
              ));
            },
          ),
        ],
      ),
    );
  }
}
