# ✖️ Mathios

A fun and interactive multiplication table practice app for kids, built entirely in SwiftUI.

Created as a consolidation challenge during the [100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) course by Paul Hudson — **Hacking with Swift**.

---

## 📱 Features

- Choose which multiplication table to practice (1–10)
- Choose how many questions to answer (5, 10, 20, or 50)
- Animated feedback for correct and incorrect answers
- Score tracker with animated number transitions
- Custom full-screen overlays for correct, incorrect, empty answer, and finish states
- Playful UI with radial gradients, wool texture effect, and custom images
- Romanian language interface

---

## 🛠 What I learned building this

- Managing **multiple `@State` variables** across a complex UI
- Conditionally rendering views with `if/else` inside a `ZStack`
- Using `DispatchQueue.main.asyncAfter` to sequence animations in time
- Building **custom animations** with `.spring()`, `.bouncy()`, and `.easeInOut()`
- `@FocusState` for keyboard focus management
- `ToolbarItemGroup` with a custom "Verifică" button above the keyboard
- Drawing a custom background texture with **Canvas**
- Writing a custom `Color` extension for hex color support

---

## 🎮 How it works

1. Pick a multiplication table (1–10)
2. Pick the number of questions (5, 10, 20, or 50)
3. Answer each question by typing in the text field
4. Get instant animated feedback — correct ✅, incorrect ❌, or empty answer ⚠️
5. See your final score when the round ends 🎉

---
## 🖼 Screenshots

<img width="1504" height="2474" alt="B384050C-5883-4322-809C-937D6257193F_1_201_a" src="https://github.com/user-attachments/assets/89d2dc12-40ab-4fbb-a113-6c2a8fc2f4bd" />


---
## 👨‍💻 Built by

Valentin Constantin — iOS development learner, working through [Hacking with Swift](https://www.hackingwithswift.com).
