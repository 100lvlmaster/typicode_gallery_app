import 'package:flutter/material.dart';
import 'package:gallery_app/models/album.dart';
import 'package:gallery_app/models/user.dart';
import 'package:gallery_app/pages/album.dart';
import 'package:gallery_app/repository/album.dart';
import 'package:gallery_app/repository/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;
  List<User> _users = [];
  List<Album> _albums = [];
  final UserRepository _userRepository = const UserRepository();
  final AlbumRepository _albumRepository = const AlbumRepository();
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    _users = await _userRepository.users();
    _albums = await _albumRepository.fetchAlbums();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: _albums.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, int index) {
                return const Divider(color: Colors.transparent);
              },
              itemBuilder: (context, int index) {
                final user =
                    _users.firstWhere((e) => e.id == _albums[index].userId);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AlbumPage(
                          albumId: _albums[index].id,
                        ),
                      ),
                    );
                  },
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(_albums[index].title),
                  subtitle: Text("by ${user.username}"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                );
              },
            ),
    );
  }
}
