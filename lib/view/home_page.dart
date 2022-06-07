import 'package:coders_meme/model/meme_model.dart';
import 'package:coders_meme/services/firebase_services.dart';
import 'package:coders_meme/view/edit_page.dart';
import 'package:coders_meme/view/upload_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget memeCard(MemeModel memeModel) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
      child: Column(
        children: [
          Container(
            // width: double.infinity,
            child: Image.network(
              memeModel.url,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memeModel.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      memeModel.author,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Spacer(),
              if (FirebaseAuth.instance.currentUser!.email == memeModel.author)
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(memeModel),
                        ));
                  },
                  icon: Icon(
                    Icons.menu,
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final isGuest = user.isAnonymous;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coder\'s Meme'),
        actions: [
          if (isGuest == false)
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadPage(),
                      ));
                },
                icon: Icon(Icons.upload_file)),
          IconButton(
            onPressed: () {
              FireBaseServices().signOut();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<List<MemeModel>>(
        stream: FireBaseServices().fetchMemes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final memes = snapshot.data!;
            return ListView(
              children: memes.map(memeCard).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'error ocurred',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
