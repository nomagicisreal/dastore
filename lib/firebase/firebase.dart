library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damath/damath.dart';

abstract final class CollectionReferenceUtils<T> {
  const CollectionReferenceUtils();

  static Future<T?> docGetData<T>(
    CollectionReference<T> collection,
    String id,
  ) =>
      collection.doc(id).get().then((snapshot) => snapshot.data());

  static Future<List<T>> getAllDocsData<T>(CollectionReference<T> collection) =>
      collection
          .get()
          .then((snapshot) => snapshot.docs.mapToList((doc) => doc.data()));
}
