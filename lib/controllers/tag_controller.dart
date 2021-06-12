import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/tag_model.dart';
import 'package:final_project/controllers/repositories/tag_repository.dart';

class TagController extends GetxController{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TagRepository _tagRepository = TagRepository();
  TextEditingController tagNameController = TextEditingController();
  TextEditingController tagEditNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxList<TagModel> tagsList = <TagModel>[].obs;
  RxBool isSearchOpen = false.obs;
  RxString currentAppBar = 'mainAppBar'.obs;

  @override
  void onInit() {
    getTags();
    super.onInit();
  }

  void addTag(TagModel tag) async {
    tag.tagName = tagNameController.text;
    Either<String, bool> result = await _tagRepository.addTag(tag);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Tag added'),
        duration: Duration(seconds: 4),
      ));
    });
  }

  void updateTag(TagModel tag) async {
    Either<String, bool> result = await _tagRepository.updateTag(tag);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Server don\'t respond'),
        duration: Duration(seconds: 4),
      ));
    }, (bool r) {
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('Tag updated'),
        duration: Duration(seconds: 4),
      ));
    });
  }

  Future<void> getTags() async {
    tagsList ([]);
    Either<String, List<TagModel>> result = await _tagRepository.getTags();
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('No Tags added'),
        duration: Duration(seconds: 4),
      ));
    }, (List<TagModel> tagList) {
      if(tagList != null){
        tagsList.addAll(tagList);
      } else{
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No Tags added'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  Future<void> searchTags(String param) async {
    tagsList ([]);
    Either<String , List<TagModel>> result = await _tagRepository.searchTags(param);
    result.fold((l) {
      print(l);
    }, (List<TagModel> tagList) {
      if(tagList != null){
        tagsList.addAll(tagList);
      } else{
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('No Tags find'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }

  Future<void> removeTag(TagModel tag) async {
    Either<String, bool> result = await _tagRepository.tagRemove(tag.id);
    result.fold((l) {
      print(l);
      ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
        content: Text('No tags to remove.'),
        duration: Duration(seconds: 4),
      ));
    }, (r) {
      if(r){
        tagsList.remove(tag);
      } else{
        ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
          content: Text('Can\'t remove tag'),
          duration: Duration(seconds: 4),
        ));
      }
    });
  }
}