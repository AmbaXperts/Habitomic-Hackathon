import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/model/post_model.dart';

class PostController extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late Rx<List<Post>> _postList= Rx<List<Post>>([]);

  List<Post> get postList => _postList.value;
  
 // final Rx<List<Post>> _PostList = Rx<List<Post>>([]);
 // List<Post> get PostList => _PostList.value;

  var isLoading = true.obs;
  var error = ''.obs;

  

  @override
  void onInit() {
    super.onInit();
    _postList = Rx<List<Post>>([]);
    _fetchPosts();
   
    _postList.bindStream(
      _firestore.collection('post').snapshots().map((QuerySnapshot query) {
        List<Post> retVal = [];
        for (var element in query.docs) {
          retVal.add(
            Post.fromSnapshot(element), // Corrected method name
          );
        }
        return retVal;
      }),
    );
  }

  // comment count 
  
  void _fetchPosts() async {
    try {
      isLoading.value = true;
      error.value = '';

      _postList.bindStream(
        _firestore.collection('post').snapshots().map((QuerySnapshot query) {
          List<Post> retVal = [];
          for (var element in query.docs) {
            retVal.add(
              Post.fromSnapshot(element),
            );
          }
          return retVal;
        }),
      );
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // like

  likePost(String id) async {
    DocumentSnapshot doc = await _firestore.collection('post').doc(id).get();

    // Get the current user's UID
    var uid = AuthenticationRepository.instance.user.uid;

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await _firestore.collection('post').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await _firestore.collection('post').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
