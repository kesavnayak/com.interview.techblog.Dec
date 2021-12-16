import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techblog/Mixins/index.dart';
import 'package:uuid/uuid.dart';

class UploadController extends GetxController with PrintLogMixin {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final Uuid uuid = const Uuid();
  final ImagePicker _picker = ImagePicker();

  final Rxn<File> _imageFile = Rxn<File>();
  final Rxn<PickedFile> _imagePickFile = Rxn<PickedFile>();
  final Rx<dynamic> _pickImageError = Rxn<dynamic>();

  Rxn<File> get imageFile => _imageFile;
  void setImageFile(File file) => _imageFile.value = file;

  Rxn<PickedFile> get imagePickFile => _imagePickFile;
  void setImagePickFile(PickedFile file) => _imagePickFile.value = file;

  Rx<dynamic> get pickImageError => _pickImageError;
  void setPickImageError(dynamic err) => _pickImageError.value = err;

  String bytesTransferred(TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  Widget previewImage() {
    // ignore: deprecated_member_use
    if (!imageFile.value!.uri.hasEmptyPath) {
      return SizedBox(
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Image.file(
            imageFile.value!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      if (pickImageError.value != null) {
        return Text(
          'Pick image error: ${pickImageError.value}',
          textAlign: TextAlign.center,
        );
      } else {
        return const SizedBox();
      }
    }
  }

  Future<TaskSnapshot> uploadFile({File? file, String? uid}) async {
    // Generate a v1 (time-based) id
    String id = uuid.v1();

    final Reference photoRef =
        storage.ref().child('photos').child(uid!).child(id);

    final UploadTask uploadTask = photoRef.putFile(
        file!,
        SettableMetadata(
          contentLanguage: 'en',
          customMetadata: <String, String>{'photoId': id},
        ));

    TaskSnapshot taskSnap = await uploadTask;
    return taskSnap;
  }

  Future<void> deleteFile({String? uid, String? photoId}) async {
    final Reference photoRef =
        storage.ref().child('photos').child(uid!).child(photoId!);

    await photoRef.delete();
  }

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      // ignore: deprecated_member_use
      final PickedFile? pickedFile = await _picker.getImage(
        source: source,
      );
      if (kDebugMode) {
        print(pickedFile?.path);
      }

      if (pickedFile != null) {
        setImageFile(File(pickedFile.path));
        setImagePickFile(pickedFile);
      }
    } catch (e) {
      setPickImageError(e);
    }
  }
}
