# Project 6 - TranslateMe

Submitted by: **Eilyn Tudares**

**TranslateMe** is a SwiftUI app that translates text between multiple languages using the **MyMemory REST API**, and stores translation history in **Firebase Firestore**.  
The app demonstrates networking, API integration, and cloud data persistence in SwiftUI.

Time spent: **~8 hours** in total

---

## Required Features

The following **required** functionality is completed:

- [x] Users open the app to a home page with a text field to enter a word, phrase, or sentence, a button to translate, and another field that initially displays empty text.  
- [x] When users tap **Translate**, the text entered in the upper field is translated and displayed in the lower field.  
- [x] A history of translations is stored and displayed in a scrollable view on the same screen.  
- [x] Users can clear their translation history at any time.

---

## Optional Features

The following **optional** features are implemented:

- [x] Users can choose the source and target languages from dropdown pickers.  
- [x] Added UI enhancements such as rounded text boxes, custom colors, and smooth layout spacing.  
- [x] Integrated asynchronous loading states and error handling messages.

---

## Additional Features

- [x] Firebase Firestore integration for persistent storage of translations.  
- [x] MyMemory API integration using Swift’s modern async/await networking.  
- [x] Clean MVVM architecture with a dedicated `TranslateViewModel`.  
- [x] Support for multiple languages (English, Spanish, French, German, Italian, Portuguese).  
- [x] Organized project folders (Models, Services, ViewModels, Views).  

---

## Video Walkthrough

Here's a walkthrough of the implemented user stories:

https://www.loom.com/share/8c593055f0cd41a9b1210cac9e84be14


---

## Notes

While building **TranslateMe**, I encountered and fixed these challenges:
- Configuring **Firebase Firestore** correctly and resolving “no such module FirebaseFirestoreSwift” errors.  
- Replacing Firestore’s Codable helpers with manual data mapping to avoid dependency issues.  
- Debugging network responses from the **MyMemory API** to properly decode JSON and handle errors.  
- Ensuring smooth integration between asynchronous tasks, the SwiftUI UI updates, and Firestore reads.

---

## License

    Copyright 2025 Eilyn Tudares

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
