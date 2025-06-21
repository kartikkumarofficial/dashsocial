import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/editaccount_controller.dart';



class EditAccountPage extends StatelessWidget {
  final accountController = Get.put(EditAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Edit Account'), backgroundColor: Colors.black,
      leading: IconButton(onPressed: (){
        Get.back(result: true);
      }, icon: Icon(CupertinoIcons.back,color: Colors.white,))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() => Column(
          children: [
            GestureDetector(
                onTap: accountController.pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: accountController.selectedImage.value != null
                    ? FileImage(accountController.selectedImage.value!)
                    : NetworkImage(accountController.userController.profileImageUrl.value) as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: accountController.nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: accountController.emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: accountController.isLoading.value ? null : accountController.saveChanges,
              child: accountController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Save Changes'),
            ),
          ],
        )),
      ),
    );
  }
}
