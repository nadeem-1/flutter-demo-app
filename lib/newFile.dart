
////
///
import 'dart:async';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/new.dart';

Future<Album> createAlbum(String email,name,number) async {
 
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'name':name,
      'number':number
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
   final String email;
  final String name;
  final String number;

  const Album({required this.id, required this.email,required this.name,required this.number});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      number: json['number']
    );
  }
}

void main() {
  runApp(const newFile());
}

class newFile extends StatefulWidget {
  const newFile({super.key});

  @override
  State<newFile> createState() {
    return _newFileState();
  }
}
 bool isLoading=false;

class _newFileState extends State<newFile> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController number = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         ElevatedButton(
          
          onPressed: () {
            
              Navigator.pop(context);
            //  Navigator.of(context).pop(false);
            //  Navigator.of(context).push(_createRoute());
          },
          child: const Text('Go back!'),
        ),
        TextFormField(
          controller: email,
          decoration: const InputDecoration(hintText: 'Enter email'),
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
        ),
        TextFormField(
          controller: name,
          decoration: const InputDecoration(hintText: 'Enter name'),
          keyboardType: TextInputType.name,
          validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
        ),
        TextFormField(
          controller: number,
          decoration: const InputDecoration(hintText: 'Enter number'),
          keyboardType: TextInputType.phone,
          validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child:
        ElevatedButton(
          onPressed: () {
        
            // Navigator.of(context).push(_createRoute());
            if(number.text.isNotEmpty && name.text.isNotEmpty && email.text.isNotEmpty)
            {
              setState(() {
              _futureAlbum = createAlbum(email.text,name.text,number.text);
            });

      //         Form(
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //    Text('emplty'),
         
      //   ]
      // )
      //         );
              }
            
          },
          child: const Text('Create Data'),
        ),
        )
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        
        if (snapshot.hasData) {
          isLoading=true;
          // return Form(
          //   Text(snapshot.data!.name);
          // )

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          
          
        child: Text(snapshot.data!.name,style: TextStyle(fontSize: 20),)
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(snapshot.data!.email,style: TextStyle(fontSize: 20),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(snapshot.data!.number,style: TextStyle(fontSize: 20),),
        ),
        
         ElevatedButton(
          
          onPressed: () {
            
              Navigator.of(context).push(_fetchRoute());
            //  Navigator.of(context).pop(false);
            //  Navigator.of(context).push(_createRoute());
          },
          child: const Text('Fetch Sample API Title'),
        ),
        ]
      )
);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

   return SizedBox(
  width: 200.0,
  height: 100.0,
  child: Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.25),
    highlightColor: Colors.white.withOpacity(0.6),
    period: const Duration(seconds: 2),
    child: Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.rectangle,
        ),
        child: ClipOval(
          child: Image.network(
            'https://flutter'
            '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    // child: Text(
    //   'shimmer effect',
    //   textAlign: TextAlign.center,
    //   style: TextStyle(
    //     fontSize: 40.0,
    //     fontWeight:
    //     FontWeight.bold,
    //   ),
    // ),
  ),
);
        // return const CircularProgressIndicator();
      },
    );
  }

}

Route _fetchRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MyApiApp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}