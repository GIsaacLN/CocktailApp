# CocktailApp

Una aplicación iOS de ejemplo desarrollada con arquitectura **VIPER** y **Storyboard**, que consume la API de [The Cocktail DB](https://www.thecocktaildb.com) para listar y gestionar cócteles favoritos, e incorpora **Core Data** para persistencia de usuarios y favoritos.

---

## 📋 Características

* **Login**

  * Usuarios guardados en Core Data
  * Contraseña en Base64
  * Validación de campos vacíos (resaltados en rojo)
* **Listado Principal**

  * UITableView con paginación “por letra” (f=a…z)
  * Muestra imagen, nombre, categoría y botón de favorito
* **Detalle de Cóctel**

  * Imagen, ingredientes, instrucciones y estado de favorito
  * Carga rápida con caché en memoria (`NSCache`)
* **Favoritos**

  * Lista de cócteles guardados en Core Data
  * Animaciones de inserción/borrado sin recargar toda la tabla
* **Salir**

  * Botón “Salir” en la NavBar de todas las vistas
  * Alerta “Aviso” con “Cancelar” y “Aceptar” (cerrar app)

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



