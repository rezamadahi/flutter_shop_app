import 'package:final_project/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_project/views/components/admin_drawer_screen.dart';
import 'package:final_project/controllers/tag_controller.dart';

import 'package:final_project/views/components/tags_appbar_screen.dart';

class TagListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TagController>(() => TagController());
    final _pageColor = Colors.pink;

    return Scaffold(
      appBar: TagAppBarScreen(),
      drawer: adminDrawer(context),
      body: Obx(() => tagsMainBody(_pageColor)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 25,
        ),
        onPressed: () {
          _showAddDialog(context, _pageColor);
        },
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  Widget tagsMainBody(MaterialColor _pageColor) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _controller.tagsList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _pageColor.shade50,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _controller.tagsList[index].tagName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(context, _pageColor, index);
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            _controller.removeTag(_controller.tagsList[index]);
                          }),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _showAddDialog(BuildContext context, MaterialColor pageColor) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Add Tag"),
              backgroundColor: pageColor.shade50,
              actionsPadding: const EdgeInsets.all(10),
              content: Form(
                key: _controller.formKey,
                child: TextFormField(
                  controller: _controller.tagNameController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Field must filled';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    isDense: true,
                    hintText: 'Tag Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              actions: <Widget>[
                OutlinedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_controller.formKey.currentState.validate()) {
                      TagModel tag = TagModel();
                      _controller.addTag(tag);
                      _controller.tagNameController.clear();
                      _controller.getTags();
                      Get.back();
                    }
                  },
                ),
                SizedBox(
                  width: 120,
                ),
                OutlinedButton(
                  child: Text('Close'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ));
  }

  _showEditDialog(BuildContext context, MaterialColor pageColor, int index) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Edit Tag"),
              backgroundColor: pageColor.shade50,
              actionsPadding: const EdgeInsets.all(10),
              content: Form(
                key: _controller.editFormKey,
                child: TextFormField(
                  controller: _controller.tagEditNameController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Field must filled';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    isDense: true,
                    hintText: _controller.tagsList[index].tagName,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              actions: <Widget>[
                OutlinedButton(
                  child: Text('Edit'),
                  onPressed: () {
                    if (_controller.editFormKey.currentState.validate()) {
                      TagModel tag = TagModel();
                      tag.tagName = _controller.tagEditNameController.text;
                      tag.id = _controller.tagsList[index].id;
                      _controller.updateTag(tag);
                      _controller.getTags();
                      Get.back();
                    }
                  },
                ),
                SizedBox(
                  width: 120,
                ),
                OutlinedButton(
                  child: Text('Close'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ));
  }

  TagController get _controller => Get.find<TagController>();
}
