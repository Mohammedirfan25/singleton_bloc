# Singleton Bloc and Cubit

This repository contains Dart code for implementing a Singleton Bloc and Cubit pattern using the `bloc` library. The pattern is commonly used in Flutter applications to manage state and business logic.

## Table of Contents

- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Singleton Bloc and Cubit pattern is a design pattern that helps manage the state of a Flutter application. It provides a way to organize and separate the concerns of state management and business logic, making the code more modular and maintainable.

## Getting Started

### Installation

To use this Singleton Bloc and Cubit code in your Flutter project, follow these steps:

1. Add the `singleton_bloc` package to your `pubspec.yaml` file:

    ```yaml
    dependencies:
      singleton_bloc: ^0.0.1
    ```

2. Run the following command to get the dependencies:

    ```bash
    flutter pub get
    ```

### Usage

1. **SingletonCubit Usage:**

   ```dart
   import 'package:flutter/material.dart';
   import 'package:singleton_bloc/singleton_bloc.dart';

   void main() {
     runApp(MyApp());
   }

   class MyApp extends StatelessWidget {
     final SingletonCubit<String> singletonCubit = SingletonCubit<String>(SingletonState<String>('Initial State'));

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: Scaffold(
           appBar: AppBar(
             title: Text('Singleton Cubit Example'),
           ),
           body: BlocProvider(
             create: (context) => singletonCubit,
             child: MyWidget(),
           ),
         ),
       );
     }
   }

   class MyWidget extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return BlocBuilder<SingletonCubit<String>, SingletonState<String>>(
         builder: (context, state) {
           // Your UI logic based on the current state
           return Center(
             child: Text(state.current),
           );
         },
       );
     }
   }

## Testing

To run tests for this code, use the following command:

    ```bash
    flutter test
    ```

## Contributing

Contributions are welcome! If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This code is open-source and available under the [MIT License](#).