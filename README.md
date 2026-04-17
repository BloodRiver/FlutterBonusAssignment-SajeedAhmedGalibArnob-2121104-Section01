# flutter_ui_class

# To-Do
- [x] Connect To Firebase
- [x] Add Task and Save to Firebase
- [x] Fetch Task from Firebase and display in UI Page
- [x] Delete Task from task list and from firebase
- [x] Real-time update UI page
- [ ] Clean UI

## Changelogs
1. Connected to Firebase Database
2. Add Task page now stores new task in Firebase Database
3. Random Icon is chosen from `Task.availableIcons` upon adding new task. IconData is not directly stored in Firebase, the **<u>List Index</u>** of the new icon from `Task.availableIcons` is stored in Firebase. Upon fetching tasks from firebase, the icon is again fetched using List Index of `Task.availableIcons`

