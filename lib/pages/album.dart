import 'package:flutter/material.dart';
import 'package:gallery_app/models/album.dart';
import 'package:gallery_app/models/photo.dart';
import 'package:gallery_app/pages/photo.dart';
import 'package:gallery_app/repository/album.dart';
import 'package:gallery_app/repository/photos.dart';

class AlbumPage extends StatefulWidget {
  final int albumId;
  const AlbumPage({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final PhotosRepository _photosRepository = const PhotosRepository();
  final AlbumRepository _albumRepository = const AlbumRepository();
  bool _isLoading = true;
  Album? _album;
  List<Photo> _photos = [];

  ///
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  ///
  void _fetchData() async {
    _album = await _albumRepository.albumById(widget.albumId);
    _photos = await _photosRepository.photosByAlbum(_album!.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: _photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PhotoPage(photoId: _photos[index].id!),
                      ),
                    );
                  },
                  child: Card(
                    child: GridTile(
                      child: Image.network(
                        _photos[index].thumbnailUrl!,
                      ), //just for testing, will fill with image later
                    ),
                  ),
                );
              },
            ),
    );
  }
}
