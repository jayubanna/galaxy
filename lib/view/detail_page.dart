import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).jfun();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );
    _animation = Tween<double>(
      begin: 0,
      end: (2 * 3.141),
    ).animate(_controller);

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {


    Map<String, dynamic> gd =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    HomeProvider favoriteProvider = Provider.of<HomeProvider>(context);

    String gravityValue = "${gd["gravity"]["value"]}";
    String gravityUnit = "${gd["gravity"]["unit"]}";
    String diameterValue = "${gd["diameter"]["value"]}";
    String diameterUnit = "${gd["diameter"]["unit"]}";
    String massValue = "${gd["mass"]["value"]}";
    String massUnit = "${gd["mass"]["unit"]}";

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
          "Universe Detail",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "favorite_page");
              },
              icon: Icon(Icons.save_alt, color: Colors.white, size: 30),
            ),
          )
        ],
        backgroundColor: Color(0xff1B1241),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: _animation.value,
                  child: Image.network(
                  "${gd["image"]}",
                  fit: BoxFit.cover,
                  height: 300,
                                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff1B1241).withOpacity(0.9),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${gd["name"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                favoriteProvider.toggleFavorite(Item(
                                  name: "${gd["name"]}",
                                  image: "${gd["image"]}",
                                  type: "${gd["type"]}",
                                ));
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("favorite successfully!"),
                                ));
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "${gd["type"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "description:-   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              TextSpan(
                                text: "${gd["description"]}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "gravity:-   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              TextSpan(
                                text: "$gravityValue ${gravityUnit}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "diameter:-   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              TextSpan(
                                text: "$diameterValue ${diameterUnit}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "mass:-   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              TextSpan(
                                text: "$massValue ${massUnit}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            },
          ),
        ],
      ),
    );
  }
}
