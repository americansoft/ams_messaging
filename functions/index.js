const {StreamChat} = require("stream-chat");
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const serverClient = StreamChat.getInstance(
    functions.config().stream.key,
    functions.config().stream.secret,
);
// When a user is deleted from Firebase
// their associated Stream account is also deleted.

exports.deleteStreamUser = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
        "unauthenticated",
        "The function must be called while authenticated.",
    );
  }

  try {
    const userId = context.auth.uid;
    await serverClient.deleteUser(userId);
    console.log(`Deleted Stream user with ID: ${userId}`);
    return {success: true, message: `Stream user ${userId} deleted.`};
  } catch (err) {
    console.error(`Failed to delete Stream user. Error:`, err);
    throw new functions
        .https
        .HttpsError("internal", "Failed to delete Stream user.");
  }
});

// Create a Stream user and return auth token.
exports.createStreamUserAndGetToken = functions
    .https
    .onCall(async (data, context) => {
      if (!context.auth) {
        throw new functions.https.HttpsError(
            "failed-precondition",
            "The function must be called while authenticated.",
        );
      }

      try {
        await serverClient.upsertUser({
          id: context.auth.uid,
          name: context.auth.token.name,
          email: context.auth.token.email,
          image: context.auth.token.image,
        });

        return serverClient.createToken(context.auth.uid);
      } catch (err) {
        console
            .error(
                `Unable to create user with
                    ID ${context.auth.uid} on Stream. Error:`,
                err);
        throw new functions.https.HttpsError(
            "aborted",
            "Could not create Stream user",
        );
      }
    });

// Get Stream user token.
exports.getStreamUserToken = functions.https.onCall((data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
        "failed-precondition",
        "The function must be called while authenticated.",
    );
  }

  try {
    return serverClient.createToken(context.auth.uid);
  } catch (err) {
    console.error(
        `Unable to get user token for
    ID ${context.auth.uid} on Stream. Error:`,
        err);
    throw new functions.https.HttpsError(
        "aborted",
        "Could not get Stream user token",
    );
  }
});

// Revoke the authenticated user's Stream chat token.
exports.revokeStreamUserToken = functions.https.onCall((data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
        "failed-precondition",
        "The function must be called while authenticated.",
    );
  }

  try {
    return serverClient.revokeUserToken(context.auth.uid);
  } catch (err) {
    console.error(`
    Unable to revoke token
    for user ID ${context.auth.uid} on Stream. Error:`,
    err);
    throw new functions.https.HttpsError(
        "aborted",
        "Could not revoke Stream user token",
    );
  }
});
