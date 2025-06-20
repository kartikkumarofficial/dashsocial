import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class UserController extends GetxController{
  var userName = ''.obs;
  var profileImageUrl = ''.obs;
  
  Future<void> fetchUserProfile() async{
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    final userData = await supabase.from('users').select().eq('id', user!.id).single();

    userName.value = userData['username'];
    profileImageUrl.value = userData['profile_image'];

  }


  
  
}