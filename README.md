# 💎 Programming Technology Stack

**Vladyslav Petryk, CS31**

A collection of Ruby programs and labs written for the university course *"Programming Technology Stack."* While the repository was originally created to submit coursework, it doubles as a **practical showcase of Ruby fundamentals**: OOP design, design patterns, algorithms, multithreading, file/JSON handling, external API integration, and unit testing.

Each folder below is a **standalone, self-contained program**.

---

## 📂 Programs Overview

### 🧮 `MatrixMultiplication` — Custom Ruby Gem
A fully packaged **Ruby gem** implementing matrix multiplication with dimension validation and custom error handling. Structured as a real-world gem project: `lib/`, `bin/console`, `Gemfile`, `Rakefile`, `.gemspec`, `CHANGELOG.md`, `LICENSE`, RBS type signatures (`sig/`), and an RSpec test suite — showcasing knowledge of Ruby packaging and library development, not just scripting.

### 🧠 `Strategy` — Calculator (Strategy Pattern)
A calculator implementing the **Strategy design pattern**: each arithmetic operation (`+ - * / %`) is encapsulated in its own strategy class implementing a shared interface, and the `Calculator` swaps strategies at runtime — a clean demonstration of OOP design patterns in Ruby.

### ✅ `Task&Deadline` — Task Manager with Deadlines
A full CRUD task-management console app: add, edit, delete, and filter tasks by status or deadline range, with persistent storage in JSON and date validation/parsing. Includes a unit test suite.

### 🌐 `Adress` — IPv4 Address Validator
A console tool that validates whether a user-provided string is a correctly formatted IPv4 address (checks octet count, numeric range 0–255, leading zeros, and rejects subnet masks). Includes a dedicated test suite.

### 🎂 `Cutting cakes` — Cake-Cutting Algorithm
An algorithmic puzzle solver: given a grid ("cake") with raisins scattered across it, the program computes how to cut the cake into equal-area rectangular pieces so that each piece contains exactly one raisin, using recursive backtracking and rectangle-generation logic.

### 📁 `FileChecker` — Directory File Scanner
A small utility class that scans a given directory for files with a specific extension, validates the extension format, and lists matching files — a simple demonstration of file-system operations in Ruby.

### 🌦️ `Request API` — Weather Data Fetcher
A console app that queries the **OpenWeatherMap API** (via `HTTParty`) for a given city, validates the input, displays formatted weather data (temperature, humidity, wind, pressure, description), and exports the results to a CSV file. Demonstrates HTTP requests, JSON parsing, and file export.

### ✊✋✌️ `Rock-Paper-Scissors` — Classic Game
A simple interactive Rock-Paper-Scissors game against the computer, with input validation and win/lose/draw logic.

### 🔁 `rpn` — Infix-to-RPN Expression Converter
An implementation of the **shunting-yard algorithm**, converting mathematical infix expressions (with parentheses, operator precedence, unary minus, and factorial) into Reverse Polish Notation, with division-by-zero detection.

### 📝 `Exam` — Student Grades Tracker
An OOP program (using Ruby modules/mixins) that lets a user add exam scores through an interactive menu and calculates the average grade, with input validation and custom error handling.

### 🎬 `KR1/Movie` — Movie Class (Midterm Test)
A basic OOP exercise implementing a `Movie` class with validated attributes (title, director) and a formatted info display, covered by unit tests.

### 🔢 `KR1/second` — Second-Largest Number Finder
An algorithm that finds the second-largest number in an array in a single pass, with input validation and randomized test data, covered by unit tests.

### ⚙️ `KR2/numbersgeneration` — Producer-Consumer Number Processor
A multithreaded program demonstrating the **producer-consumer pattern**: one thread generates random numbers into a shared queue, while another consumes and processes them (flagging odd numbers), synchronized safely with Ruby's `Thread` and `Queue`.

### ⏱️ `KR2/timecheckdaemon` — Background Time-Check Daemon
A daemon-style background process that logs the current system time at fixed intervals for a configurable duration, then shuts down gracefully — demonstrating thread lifecycle management (`start`/`stop`).

---

## 🛠️ Tech & Concepts Demonstrated

| Category | Examples |
|---|---|
| **OOP & Design Patterns** | Classes, modules/mixins, Strategy pattern |
| **Algorithms** | Backtracking, shunting-yard, single-pass array scanning |
| **Concurrency** | `Thread`, `Queue`, producer-consumer, daemon processes |
| **I/O & Persistence** | File system scanning, JSON read/write, CSV export |
| **External APIs** | HTTP requests via `HTTParty` (OpenWeatherMap API) |
| **Packaging** | A complete, publishable Ruby gem (`matrix_multiplication`) |
| **Testing** | Unit tests for most programs |
| **Error Handling** | Custom exceptions, input validation across all programs |

---

## 👨‍💻 Author

**Vladyslav Petryk** — CS31
[GitHub](https://github.com/PetrykVladyslav)
