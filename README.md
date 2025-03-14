# KotoTinder 🐱

![Flutter](https://img.shields.io/badge/Flutter-3.0+-46D1FD?style=flat-square&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat-square&logo=dart)

## Описание проекта

KotoTinder - это мобильное приложение в стиле Tinder, но для кошек! Приложение позволяет пользователям просматривать фотографии кошек различных пород, получать информацию о них, а также ставить лайки или пропускать котиков.

Приложение использует [The Cat API](https://thecatapi.com/) для получения изображений и информации о кошках.

## Функциональность

- **Просмотр фотографий котиков** - свайпайте вправо или влево, чтобы лайкнуть или пропустить котика
- **Анимации** - красивые анимации при взаимодействии с интерфейсом
- **Информация о породах** - подробная информация о породе каждого котика
- **Детальная страница** - нажмите на фото, чтобы увидеть подробную информацию о котике
- **Счетчик лайков** - отслеживайте, скольким котикам вы поставили лайк
- **Кэширование изображений** - для быстрой загрузки и экономии трафика

## Скриншоты

| Основной экран | Детальная информация |
| --- | --- |
| <img src="screenshots/main_screen.png" alt="Основной экран" width="300" /> | <img src="screenshots/cat_details.png" alt="Детальная информация" width="300" /> |

## Технические детали

- Язык программирования: Dart
- Фреймворк: Flutter
- Управление состоянием: StatefulWidget
- API: https://thecatapi.com
- Обработка изображений: cached_network_image

## Путь до apk файла

[APK файл](build/app/outputs/flutter-apk/app-release.apk)
