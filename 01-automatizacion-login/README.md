# Módulo de Automatización — Smoke Test de Login (SauceDemo)

Suite de pruebas automatizadas sobre el inicio de sesión de [SauceDemo](https://www.saucedemo.com/).

## Stack

- **Framework:** Cypress 16
- **Lenguaje:** JavaScript
- **Navegador:** Chrome (headless)

## Requisitos

- Node.js 18 o superior

## Instalación y ejecución

```bash
cd 01-automatizacion-login
npm install
npm test            # ejecuta las pruebas en modo headless
npm run test:open   # abre la interfaz de Cypress
```

## Casos cubiertos

| ID | Caso | Resultado esperado |
| --- | --- | --- |
| CP-01 | Login con credenciales válidas | Redirige a `/inventory.html` y muestra el catálogo |
| CP-02 | Login con contraseña incorrecta | Muestra error de credenciales y no permite el acceso |
| CP-03 | Login con el formulario vacío | Muestra "Username is required" |
| CP-04 | Login sin contraseña | Muestra "Password is required" |
| CP-05 | Login con usuario bloqueado | Muestra el mensaje de usuario bloqueado |

Los tres casos exigidos por el enunciado corresponden a CP-01, CP-02 y CP-03/CP-04. CP-05 se agregó tras explorar los usuarios que la aplicación expone.

## Organización del código

| Carpeta | Responsabilidad |
| --- | --- | --- |
| `cypress/e2e/` | Las pruebas: qué se valida |
| `cypress/pages/` | Page Objects: cómo se interactúa con cada página |
| `cypress/fixtures/` | Datos de prueba: credenciales y mensajes esperados |

Se aplicó el patrón **Page Object Model** para centralizar los selectores: si la aplicación cambia un atributo, se modifica un solo archivo y no cada prueba.
