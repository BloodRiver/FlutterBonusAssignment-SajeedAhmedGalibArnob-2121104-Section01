# flutter_ui_class

# To-Do
- [x] Connect To Firebase
- [x] Add Task and Save to Firebase
- [x] Fetch Task from Firebase and display in UI Page
- [x] Delete Task from task list and from firebase
- [x] Real-time update UI page
- [x] Clean UI

## Changelogs
1. Connected to Firebase Database
2. Add Task page now stores new task in Firebase Database
3. Removed `CardDataModel` and `DummyData` classes as they became unnecessary
4. Random Icon is chosen from `Task.availableIcons` upon adding new task. IconData is not directly stored in Firebase, the **<u>List Index</u>** of the new icon from `Task.availableIcons` is stored in Firebase. Upon fetching tasks from firebase, the icon is again fetched using List Index of `Task.availableIcons`
5. Changed the trailing icons of the `TaskCardWidget` to `Icons.delete` for delete operation.
6. Added AlertDialog to show yes/no buttons to confirm deletion
7. Delete from firebase function implemented
8. Realtime UI Page update upon changing data in Firebase implemented.
9. Removed unnecessary widgets and files like `BottomNavigationBar` and `landing_page.dart`, `HomeScreen` etc. Combined it all into the UI page, renaming it to TasksHomeScreen. Counter no longer increments on button click, it shows the live count of tasks in the database.
