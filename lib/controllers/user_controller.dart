import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class UserController extends GetxController{
  var userName = ''.obs;
  var profileImageUrl = ''.obs;
  final supabase = Supabase.instance.client;
  
  Future<void> fetchUserProfile() async{

    final user = supabase.auth.currentUser;
    final userData = await supabase.from('users').select().eq('id', user!.id).single();

    userName.value = userData['username'];
    profileImageUrl.value = userData['profile_image'];

  }

  Future<void> updateProfileImage(String url) async{
    final user = supabase.auth.currentUser;
    await Supabase.instance.client.from('profiles').update({'profile_image':url}).eq('id', user!.id);
    profileImageUrl.value=url;
  }
  
  
}