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
