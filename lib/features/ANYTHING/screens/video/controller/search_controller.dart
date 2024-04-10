import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/common/model/user/user_model.dart';

class SSearchController extends GetxController {
  final Rx<List<UserModel>> _searchedUsers = Rx<List<UserModel>>([]);

  List<UserModel> get searchedUsers => _searchedUsers.value;
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(_firestore
        .collection('Users')
        .where('Username', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) { // Specify the generic type of QuerySnapshot
      List<UserModel> retVal = [];
      for (var elem in query.docs) {
        retVal.add(UserModel.fromSnapshot(elem)); // Use UserModel.fromSnapshot instead of User.fromSnap
      }
      return retVal;
    }));
  }
}
