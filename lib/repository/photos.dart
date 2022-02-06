import 'package:dio/dio.dart';
import 'package:gallery_app/constants.dart';
import 'package:gallery_app/models/photo.dart';

class PhotosRepository {
  const PhotosRepository();
  static final Dio _dio = Dio();

  Future<Photo> photoById(String photoId) async {
    final response = await _dio.get("${Constants.photosApi}/$photoId");
    return Photo.fromMap(response.data);
  }

  ///
  ///
  Future<List<Photo>> photosByAlbum(String albumId) async {
    final response = await _dio.get("${Constants.photosApi}?albumId=$albumId");
    final photos = List.generate(
      response.data.length,
      (int index) => Photo.fromMap(response.data[index]),
    );
    return photos;
  }
}
