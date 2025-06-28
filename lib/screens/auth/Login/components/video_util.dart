
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:stream_video/stream_video.dart';

import '../../../../app.dart';

StreamVideo connectVideoStream(firebase.User? user, data) {

  return StreamVideo(
    streamKey,
    user: User.regular(userId: user!.uid, role: 'admin', name: user.displayName),
    userToken: data,
  );
}
