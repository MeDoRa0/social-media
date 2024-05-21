import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/app_images.dart';
import 'package:social_media/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('search users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SearchBar(
              controller: searchCont,
              onChanged: (value) {
                setState(() {
                  searchCont.text = value;
                });
              },
              hintText: 'search by user name',
              trailing: [
                const Icon(Icons.search),
              ],
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: kSecondryColor),
                ),
              ),
              elevation: MaterialStateProperty.resolveWith((states) => 0),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => kPrimaryColor.withOpacity(0.1),
              ),
            ),
            const Gap(20),
            //i use Expanded because i use listview in coloumn
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('userName', isEqualTo: searchCont.text)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  // Check the connection state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        dynamic item = snapshot.data.docs[index];

                        return ListTile(
                          leading: item['profilePicture'] == ""
                              ? const CircleAvatar(
                                  backgroundImage: AssetImage(Assets.imagesMan),
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    item['profilePicture'],
                                  ),
                                ),
                          title: Text(item['displayName']),
                          subtitle: Text('@' + item['userName']),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
