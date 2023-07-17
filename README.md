# Developer Portfolio

Its A website is a personal showcase of  skills and experience as a developer. The website features  personal data, as well as a list of completed projects. The website is connected to Firebase, This allows me to easily manage and update the content of the website, including adding and editing projects or my personal data. As an admin, I have full control over the website's content and can make changes to it at any time.

## Installing
To get started with this project, you will need to follow these steps:

1. Setup Flutter and Dart on your machine by following the instructions in the official documentation: https://flutter.dev/docs/get-started/install ↗

2. Setup a Firebase project for web in your Firebase console account by following these steps:

     -Go to the Firebase Console: https://console.firebase.google.com/
     -Create a new project, or select an existing one.
     -Click on the "Add App" button and select "Web" as the platform.
     -Register the app by providing an app nickname and click on "Register".
     -Copy the Firebase configuration data for your app, including the appId, appKey, messagingSenderId and projectId.
     -Create a new file called firebase_initialization.dart in the lib/utils directory with the following content:
``` 
class FirebaseInitialization {
  static const String appId = 'YOUR_APP_ID';
  static const String appKey = 'YOUR_APP_KEY';
  static const String messagingSenderId = 'YOUR_MESSAGING_SENDER_ID';
  static const String projectId = 'YOUR_PROJECT_ID';
}

```

3. Replace the `appId`, `appKey`, `messagingSenderId` and `projectId` values with the ones you copied from your project

4. Initialize the Firebase app data in your main() function as follows:

```
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio_website/utils/firebase_initialization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    appId: FirebaseInitialization.appId,
    apiKey: FirebaseInitialization.appKey,
    messagingSenderId: FirebaseInitialization.messagingSenderId,
    projectId: FirebaseInitialization.projectId,
  );
  runApp(MyApp());
}
```

5.Run flutter pub get to install the required packages.

Run flutter run to start the app and launch the website in your browser.
