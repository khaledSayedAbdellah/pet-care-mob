// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/loading.dart';
import 'package:myapp/searchResults.dart';
import 'package:myapp/services/api.dart';
// import 'package:myapp/services/api.dart' as http;
// import 'package:myapp/services/api.dart';
import './detailsScreen.dart';
import 'services/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // String value;
  // HomePage({this.value});

  var text;
  HomePage({Key key, @required this.text, Key data}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var doctors;

  var searchDoctors;
  TextEditingController search = TextEditingController();

  bool loading = false;

  var username;
  var email;
  bool isSignIn = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    username = preferences.getString("username");
    email = preferences.getString("email");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        email = preferences.getString("email");
        isSignIn = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    setState(() => loading = true);
    backData();
  }

  void backData() async {
    var data = await api.fetchDoctors();
    setState(() {
      doctors = data;
      loading = false;
    });
  }

  void searchData(String name) async {
    var search = await api.searchDoctors(name);
    setState(() {
      searchDoctors = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 54, 62),
        toolbarHeight: 77,
        centerTitle: true,
        title: Image(
          image: AssetImage('assets/images/logo.png'),
          width: 120,
          height: 70,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/man.png'),
                      backgroundColor: Colors.white,
                    ),
                    title: isSignIn
                        ? Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                        : Text("NO User"),
                    subtitle: isSignIn
                        ? Text(
                            username,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        : Text("NO Email Address"),
                  ),
                ],
              ),
              color: Color.fromARGB(255, 43, 54, 62),
            ),
            Expanded(
              child: Column(
                children: [
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: Color.fromARGB(255, 43, 54, 62),
                          size: 30,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.perm_identity,
                          color: Color.fromARGB(255, 43, 54, 62),
                          size: 30,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.pending_actions_rounded,
                          color: Color.fromARGB(255, 43, 54, 62),
                          size: 30,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'My Reservations',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("Contact");
                    },
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 43, 54, 62),
                          size: 30,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'Contact Us',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    onPressed: () {
                      Navigator.of(context).pushNamed("About");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Color.fromARGB(255, 43, 54, 62),
                          size: 30,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'About Me',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    onPressed: () async {
                      // Navigator.popUntil(context, ModalRoute.withName('/'));
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Log Out',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Icon(
                          Icons.logout,
                          color: Color.fromARGB(255, 43, 54, 62),
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  controller: search,
                  decoration: InputDecoration(
                    hintText: 'Search Vet or Clinic',
                    border: OutlineInputBorder(),
                    // hoverColor: Color.fromARGB(255, 43, 54, 62),
                    focusColor: Color.fromARGB(255, 43, 54, 62),
                    focusedBorder: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 35,
                      color: Color.fromARGB(255, 43, 54, 62),
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    print(value);
                    if (value != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Search(
                                  text: value,
                                )),
                        // value: value
                      );
                    } else {
                      print("False");
                    }
                  }),
            ),
            Container(
              height: 660,
              child: loading
                  ? Loading()
                  : ListView(
                      children: [
                        Container(
                          // height: 680,
                          child: Column(
                            children:
                                doctors.sublist(0, 2).map<Widget>((doctor) {
                              return listViewCard(doctor);
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            "How to use our App ?",
                            style: TextStyle(fontSize: 23),
                          ),
                        ),
                        Column(
                          children: [
                            Card(
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/images/search1.png',
                                  scale: 15,
                                ),
                                title: Text('Search '),
                                subtitle:
                                    Text('Look for your desired Clinic or Vet'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/images/compare.png',
                                  scale: 15,
                                ),
                                title: Text('Compare & Choose '),
                                subtitle: Text('Based on patients reviews'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/images/booking.png',
                                  scale: 15,
                                ),
                                title: Text('Book your appointment'),
                                subtitle: Text(
                                    'With the best vets in the clinic or a personal vet'),
                              ),
                            ),
                          ],
                        ),

                        //services
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            "Services 🐾",
                            style: TextStyle(fontSize: 23),
                          ),
                        ),

                        Container(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                child: getService(
                                    image: 'assets/images/health.png',
                                    title: 'Health Care'),
                              ),
                              getService(
                                  image: 'assets/images/dog-house.png',
                                  title: 'House Sitting'),
                              getService(
                                  image: 'assets/images/visit.png',
                                  title: 'Emergency Visit'),
                              getService(
                                  image: 'assets/images/grooming.png',
                                  title: 'Grooming'),
                              getService(
                                  image: 'assets/images/education.png',
                                  title: 'Pet Training'),
                              getService(
                                  image: 'assets/images/walking-the-dog.png',
                                  title: 'Dog Walking'),
                              getService(
                                  image: 'assets/images/spray.png',
                                  title: 'Insect Control'),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  getService({String title, String image}) {
    return FlatButton(
      onPressed: () {},
      child: Container(
        width: 140,
        child: Card(
          child: Column(
            children: [
              Image.asset(
                image,
                scale: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 43, 54, 62),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listViewCard(var doctor) {
    //int index
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            Padding(
              // padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage('assets/images/doctor1.jpg'),
                height: 130,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text(
                      doctor.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            Icons.pin_drop,
                            size: 18,
                            color: Color.fromARGB(255, 43, 54, 62),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            doctor.address,
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            Icons.phone,
                            size: 18,
                            color: Color.fromARGB(255, 43, 54, 62),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('${doctor.phone ?? "Empty"}',
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            Icons.pets_outlined,
                            size: 18,
                            color: Color.fromARGB(255, 43, 54, 62),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(doctor.email, style: TextStyle(fontSize: 16))
                        ],
                      ),
                      RaisedButton(
                          child: Text(
                            'More Details',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Color.fromARGB(255, 43, 54, 62),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen()),
                            );
                          }),
                      SizedBox(
                        height: 13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
