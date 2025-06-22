
# 📊 DashSocial – Social Media Analytics & Post Scheduler

**DashSocial** is a responsive and feature-rich Flutter app that helps creators and marketers manage their Instagram presence. It includes analytics dashboards, post scheduling, user profile handling, and real-time visualizations — all integrated with a mock Instagram API served via **Mockoon**.

Built with **Flutter + GetX**, powered by **Supabase**, and styled for modern social media workflows.

---

## 🧩 Features

### 👤 **Authentication & Profile**

* Sign up / login via **Supabase Auth**
* User profile data fetched from Supabase DB
* Profile image selection and upload using **Cloudinary**
* Edit profile: name, email, profile image

### 📈 **Dashboard Analytics**

* Real-time charts for followers, likes, and reach
* Data fetched from a custom **Mockoon API**
* Visualization using `fl_chart`
* Insights update dynamically in the UI

### 🗓️ **Post Scheduler**

* Create posts with media and captions
* Schedule posts with a date/time picker
* View scheduled posts in a timeline interface

### 🏠 **Home Feed**

* Dynamic post feed pulled from Mock API
* Posts include thumbnails, captions, and analytics
* Clean UI with responsive cards

---

## 🧠 Tech Stack

| Layer          | Tech Used                           |
| -------------- | ----------------------------------- |
| **Frontend**   | Flutter, Dart                       |
| **State Mgmt** | GetX                                |
| **Auth & DB**  | Supabase (Auth + Postgres)          |
| **Media**      | Cloudinary                          |
| **Charts**     | fl\_chart                           |
| **API**        | Mockoon (Local API for Instagram)   |
| **Utils**      | File Picker, DateTime, Image Picker |

---

## 📁 Folder Structure

```
dashsocial/
├── controllers/         # GetX logic controllers
├── models/              # Data models (User, Post, Stats)
├── presentation/
│   ├── screens/         # Auth, Home, Dashboard, Profile
│   ├── widgets/         # Reusable UI components
├── services/            # Supabase, Cloudinary, API handlers
├── utils/               # Constants, themes, helper functions
├── main.dart            # Entry point
└── pubspec.yaml         # Dependencies
```

---

## 🧪 Setup Locally

1. **Clone the repository**

```bash
git clone https://github.com/kartikkumarofficial/dashsocial.git
cd dashsocial
```

2. **Install Flutter dependencies**

```bash
flutter pub get
```

3. **Set up environment variables**

Create a `.env` file or use your own config file with the following keys:

```
supabaseUrl=your_supabase_url
supabaseKey=your_anon_key
cloudName=your_cloud_name
uploadPreset=your_upload_preset
```

4. **Start Mock API Server**

Use [Mockoon](https://mockoon.com/) to start your Instagram-like local API:

* Import your custom JSON configuration
* Start the local server on your desired port

5. **Run the Flutter app**

```bash
flutter run
```

---

## 📸 Screenshots (optional section)

> You can add screenshots here showing the dashboard, post creation, or user profile views for visual impact.

---

Let me know if you'd like the above saved as a `README.md` file or want to add any badges, screenshots, or contribution guidelines!
