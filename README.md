# Uponorflix

A new Flutter project. Movies catalog, add, update and delete.

## Project structure

For the structure of this project I have followed the [tutorial](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/#t-1728739701070) from Reso Coder, about an implementation (or proposal) for **Flutter Clean Architecture**.

## Note

Tested in Android, not in iOS.

## Run Locally

Clone the project

```bash
  git clone https://github.com/asanz8/uponorflix-test.git
```

Go to the project directory

```bash
  cd uponorflix-test
```

Install dependencies

```bash
  flutter pub get
```

Generate files

```bash
  dart run build_runner build
```

Generate translations

```bash
  dart run intl_utils:generate
```

## Dependencies

- Flutter version 3.24.3

- Riverpod for state management

- Sqflite for local DB

- Go Router for navigation

- GetIt (Service locator)

## Running Tests

To run tests, run the following command

```bash
  flutter test
```

## Todo

- Save images in Movie model

- Show respective images

- Implement search function
