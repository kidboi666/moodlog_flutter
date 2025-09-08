import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:moodlog/domain/entities/user_provider_data.dart';

import '../../domain/entities/user.dart';
import '../../domain/entities/user_metadata.dart';

extension FirebaseUserExtensions on firebase.User {
  User toDomain() {
    return User(
      uid: uid,
      email: email,
      displayName: displayName,
      photoURL: photoURL,
      isAnonymous: isAnonymous,
      metadata: metadata.toDomain(),
      providerData: providerData.map((data) => data.toDomain()).toList(),
    );
  }
}

extension FirebaseUserMetadataExtensions on firebase.UserMetadata {
  UserMetadata toDomain() {
    return UserMetadata(
      creationTime: creationTime,
      lastSignInTime: lastSignInTime,
    );
  }
}

extension FirebaseUserProviderDataExtensions on firebase.UserInfo {
  UserProviderData toDomain() {
    return UserProviderData(providerId: providerId);
  }
}
