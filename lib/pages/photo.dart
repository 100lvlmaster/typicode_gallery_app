import 'package:flutter/material.dart';
import 'package:gallery_app/models/photo.dart';
import 'package:gallery_app/repository/photos.dart';

class PhotoPage extends StatefulWidget {
  final int photoId;
  const PhotoPage({
    Key? key,
    required this.photoId,
  }) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  bool _isLoading = true;
  Photo? photo;
  final PhotosRepository _photosRepository = const PhotosRepository();

  ///
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  ///
  void _fetchData() async {
    photo = await _photosRepository.photoById(widget.photoId);
    setState(() {
      _isLoading = false;
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    photo!.url!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Text(photo?.title ?? ""),
                ),
              ],
            ),
    );
  }
}
