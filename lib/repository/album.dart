import 'package:dio/dio.dart';
import 'package:gallery_app/constants.dart';
import 'package:gallery_app/models/album.dart';

class AlbumRepository {
  const AlbumRepository();
  static final Dio _dio = Dio();

  ///
  ///
  Future<List<Album>> fetchAlbums() async {
    final response = await _dio.get(Constants.albumsApi);
    final albums = List.generate(response.data.length,
        (int index) => Album.fromMap(response.data[index]));
    return albums;
  }

  ///
  ///
  Future<Album> albumById(int id) async {
    final response = await _dio.get("${Constants.albumsApi}/$id");
    return Album.fromMap(response.data);
  }

  ///
  ///
}
