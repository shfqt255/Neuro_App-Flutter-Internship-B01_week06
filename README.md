## Week 6 — REST APIs & HTTP in Flutter

This repository contains multiple Flutter applications developed to understand and implement RESTful API communication in real-world scenarios. The projects demonstrate API integration, CRUD operations, state management, and file uploads.


## Projects Included

###  Task 6.1 — API Basics App (`api_basics_app`)

Fetches posts from a public API and displays them in a list.

####  Features

* HTTP GET request using `http` package
* JSON parsing using `jsonDecode`
* Model class with `fromJson()`
* ListView display
* Loading & error handling
* FutureBuilder implementation

###  Task 6.2 — CRUD API App (`crud_api_app`)

Implements complete CRUD operations with REST APIs.

####  Features

* Create, Read, Update, Delete posts
* HTTP POST, PUT, DELETE requests
* JSON request body using `jsonEncode`
* Form for adding & editing posts
* Pre-filled edit form
* Delete confirmation dialog
* SnackBar success & error messages


###  Task 6.3 — Users App with Provider (`users_app`)

Demonstrates API integration using Provider state management.

####  Features

* Provider-based state management
* API state handling (loading, success, error)
* Fetch, add, update, delete users
* Pull-to-refresh functionality
* Pagination using ScrollController
* Search & filtering users


### Task 6.4 — Image Upload App (`image_upload_app`)

Uploads images to a server using multipart requests.

#### Features

* Image selection via gallery/camera
* Multipart API upload
* Upload progress indicator
* Display uploaded image from URL
* Image compression for large files
* Error handling & user feedback



##  Technologies Used

* Flutter & Dart
* REST APIs
* HTTP package
* Provider State Management
* JSON Serialization
* Multipart Requests
* Image Picker



##  Packages Used

```yaml
http:
provider:
image_picker:
```


##  Learning Objectives

This repository demonstrates:

* Making HTTP requests in Flutter
* Parsing and mapping JSON data
* Implementing RESTful CRUD operations
* Managing API state using Provider
* Handling pagination & search
* Uploading files using multipart requests
* Error handling & UX feedback


##  How to Run

1. Clone the repository

```bash
git clonehttps://github.com/shfqt255/Neuro_App-Flutter-Internship-B01_week06.git
```

2. Navigate to a project

```bash
cd api_basics_app
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the app

```bash
flutter run
```


##  Internship Task Context

These applications were developed as part of an internship training program to build practical experience with REST APIs and real-world Flutter development workflows.

##  License

This project is licensed under the MIT License.
