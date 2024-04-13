import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/common/model/user/user_model.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';

class SSearchController extends GetxController {
  final Rx<List<UserModel>> _searchedUsers = Rx<List<UserModel>>([]);

  List<UserModel> get searchedUsers => _searchedUsers.value;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(_firestore
        .collection('Users')
        .where('Username', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<UserModel> retVal = [];
      for (var elem in query.docs) {
        var modelo = UserModel.fromSnapshot(elem);
        if (modelo.id != AuthenticationRepository.instance.user.uid) {
          retVal.add(UserModel.fromSnapshot(elem));
        }
      }
      return retVal;
    }));
  }
}
