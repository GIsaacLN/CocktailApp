# CocktailApp

Una aplicación iOS de ejemplo desarrollada con arquitectura **VIPER** y **Storyboard**, que consume la API de [The Cocktail DB](https://www.thecocktaildb.com) para listar y gestionar cócteles favoritos, e incorpora **Core Data** para persistencia de usuarios y favoritos.

---

## 📋 Características
La pantalla de Login gestiona usuarios almacenados en Core Data, cifra contraseñas en Base64 y resalta en rojo los campos vacíos para mejorar la validación. En el Listado Principal, se despliega un UITableView con paginación por letra (f=a…z), mostrando la imagen, el nombre, la categoría y un botón para marcar favoritos.

La Vista de Detalle carga la imagen, la lista de ingredientes y las instrucciones de cada cóctel, además de reflejar al instante el estado de favorito gracias a un caché en memoria con NSCache. La sección de Favoritos muestra los cócteles guardados en Core Data y emplea animaciones de inserción y borrado para actualizar la tabla sin recargas completas.

Por último, un botón Salir aparece en la barra de navegación de todas las vistas, lanzando una alerta de confirmación que permite cerrar la aplicación de forma sencilla

---

## ⚙️ Requisitos

* Xcode 14+
* iOS 18+ (dispositivo físico o simulador)
* Swift 5, UIKit, Core Data

---

## 🚀 Instalación y ejecución

1. Clona el repositorio

   ```bash
   git clone https://github.com/GIsaacLN/CocktailApp.git
   cd CocktailApp
   ```
2. Abre `CocktailApp.xcodeproj` con Xcode
3. Selecciona tu cuenta de desarrollador en el proyecto (Signing & Capabilities) y actualiza el Bundle Identifier para que sea único
4. Selecciona un simulador o dispositivo, y ▶️ Run

---

## 🔑 Credenciales de prueba

En `SceneDelegate` se siembra un usuario ficticio la primera vez que arrancas:

* **Usuario:** `user`
* **Contraseña:** `password`

> Para probar la app, ingresa con estas credenciales o añade los tuyos propios editando el seed en `SceneDelegate.swift`.

---

## 🗂️ Arquitectura

* **VIPER** para separar responsabilidades
* **Storyboard** para UI y navegación (`UINavigationController` + `UITabBarController`)
* **Core Data** con dos entidades: `Usuario` y `Favorito`
* **NetworkManager** genérico para peticiones REST
* **ImageCache** con `NSCache<NSString, UIImage>`

---

## 📡 API

* **Listado:**
  `GET https://www.thecocktaildb.com/api/json/v1/1/search.php?f={letra}`
* **Detalle:**
  `GET https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i={id}`

---

¡Gracias por revisar mi prueba! Cualquier duda, por favor házmelo saber.
