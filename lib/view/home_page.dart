import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String searchText = "";

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).jfun();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 9),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Galaxy Universe",
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.white),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
                ),
              ),
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (BuildContext context, HomeProvider value,
                      Widget? child) {
                    List filteredList = value.glist.where((item) {
                      return item["name"].toLowerCase().contains(searchText);
                    }).toList();
                    return AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {
                        return GridView.builder(
                          itemCount: filteredList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> item = filteredList[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 80),
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            Color(0xff1B1241).withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "detail_page",arguments: value.glist[index]);
                                      },
                                      child: Column(
                                        children: [
                                          Transform.rotate(
                                            angle: _animation.value,
                                            child: Image.network(
                                              "${item["image"]}",
                                              fit: BoxFit.cover,
                                              height: 150,
                                            ),
                                          ),
                                          Text(
                                            "${item["name"]}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
