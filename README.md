# flutter_ui_class

## Changelogs
1. Connected to Firebase Database
2. Add Task page now stores new task in Firebase Database
3. Random Icon is chosen from `CardDataModel.availableIcons` upon adding new task. IconData is not directly stored in Firebase, the **<u>List Index</u>** of the new icon from `CardDataModel.availableIcons` is stored in Firebase. Upon fetching tasks from firebase, the icon is again fetched using List Index of `CardDataModel.availableIcons`

