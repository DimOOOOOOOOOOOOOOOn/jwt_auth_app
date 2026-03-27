# JWT Auth App

Мобільний додаток на Flutter з JWT авторизацією, Dio HTTP клієнтом та interceptors.

## Технології
- Flutter 3.x
- Dio — HTTP клієнт
- Provider — state management
- Shared Preferences — збереження токену

## Функціонал
- Реєстрація та вхід через REST API
- JWT токен зберігається локально
- Auto-login при повторному запуску
- Захищені маршрути з Bearer токеном
- Редагування профілю (PUT запит)
- Logout з очисткою токену
- Remember Me — збереження email

## Архітектура
```
lib/
├── core/
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart
│   │       ├── logging_interceptor.dart
│   │       └── error_interceptor.dart
│   └── storage/
│       └── token_storage.dart
├── features/
│   └── auth/
│       ├── auth_service.dart
│       ├── auth_provider.dart
│       └── user_model.dart
└── screens/
    ├── login_screen.dart
    ├── register_screen.dart
    └── profile_screen.dart
```

## Interceptors
- **AuthInterceptor** — автоматично додає `Authorization: Bearer <token>` до кожного запиту
- **LoggingInterceptor** — логує всі запити і відповіді в консоль
- **ErrorInterceptor** — перетворює помилки на зрозумілі повідомлення українською

## Тестовий акаунт
- Email: будь-який
- Password: emilyspass

## API
Використовується [DummyJSON](https://dummyjson.com) — безкоштовний REST API для тестування
