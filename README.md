# Rick-and-Morty
![iOS](https://img.shields.io/badge/iOS-15%20-white?logo=Apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-5.8.1-red?logo=Swift&logoColor=red)
![Xcode](https://img.shields.io/badge/Xcode-14.3.1%20-00B2FF?logo=Xcode&logoColor=00B2FF)

Тестовое задание @NDA

- Информация о всех персонажах мультсериала "Рик и Морти", а также в каких эпизодах они появлялись
- Реализован механизм авторизации и регистрации пользователя

## Preview
<details>
<summary>Экраны приложения</summary>
 
| Auth | Characters | Settings |
:---:|:---:|:---:
![LoginRM](https://github.com/2late2bad/Rick-and-Morty/assets/121951550/f1ea08fc-e113-403c-b9f1-e20203286efe) | ![CharactersRM](https://github.com/2late2bad/Rick-and-Morty/assets/121951550/16372583-366c-475a-8652-35867a99edc0) | ![SettingsRM](https://github.com/2late2bad/Rick-and-Morty/assets/121951550/6cc6a5ca-aaf4-413d-a9f4-3d87c6028d09)

</details>

## Tech stack
* UIKit
* GCD
* Reactive: Combine
* URLSession + async/await
* Data storage: UserDefaults, Keychain, NSCache
* Clean Architecture + MVVM + Coordinator

## Highlights
* Presentation Layer -> MVVM, Combine
* Domain Layer -> Use cases, Interface Repository, Entity
* Data Layer -> DTO, Repository
* Composition -> Coordinator, Factory
* Регистрация пользователя с кэшированием данных -> Keychain
* Универсальный дженерик NetworkService -> async/await
* Сохранение состояния авторизации пользователя -> UserDefaults
* Кэширование загруженных изображений -> NSCache
* Возможность смены пароля и логаута из приложения
* Пагинация запросов API с пороговым значением для начала дозагрузки
* Поддержка светлой и темной темы
* Без использования сторонних библиотек
* Верстка только кодом

### Resources
* [The Rick and Morty API](https://rickandmortyapi.com/documentation/#introduction)
