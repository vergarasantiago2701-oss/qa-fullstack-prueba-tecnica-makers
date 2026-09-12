# Prueba Técnica QA Full Stack

Repositorio con los tres módulos de la prueba técnica: automatización web, diseño de pruebas funcionales y testing de API.

**Autor:** Santiago Vergara Serpa

## Módulos

| Módulo | Carpeta | Contenido |
| --- | --- | --- |
| Automatización | [`01-automatizacion-login/`](./01-automatizacion-login) | Smoke test del login de [SauceDemo](https://www.saucedemo.com/) automatizado con Cypress y JavaScript |
| Funcional | [`02-modulo-funcional-makerspay/`](./02-modulo-funcional-makerspay) | Diseño de pruebas para MakersPay: escenarios, casos, técnicas aplicadas y reporte de defectos |
| API | [`03-modulo-api/`](./03-modulo-api) | Pruebas funcionales sobre una API REST, ejecutadas y documentadas con Postman |

## Resumen de resultados

| Módulo | Alcance | Resultado |
| --- | --- | --- |
| Automatización | 5 casos automatizados sobre el inicio de sesión | 5 de 5 aprobados |
| Funcional | 7 escenarios descompuestos en 18 casos de prueba | 18 casos diseñados y 6 defectos de especificación reportados |
| API | 4 casos con 9 aserciones sobre el ciclo de vida de un recurso | 9 de 9 aserciones aprobadas |

## Tablero de casos de prueba

Los casos de prueba se gestionan como tarjetas en un tablero Kanban, simulando el ciclo de testing de un equipo real:

[QA Full Stack - Casos de Prueba](https://github.com/users/vergarasantiago2701-oss/projects/2)

Cada tarjeta corresponde a un caso de prueba, con su descripción, precondiciones, pasos y resultado esperado. El estado refleja su situación real: los casos de automatización y de API figuran como ejecutados; los de MakersPay permanecen pendientes de ejecución, por no existir un ambiente desplegado del producto.

## Cómo ejecutar la automatización

Requiere Node.js 18 o superior.

    cd 01-automatizacion-login
    npm install
    npm test

Las pruebas se ejecutan en Chrome en modo headless. Para verlas correr en la interfaz de Cypress:

    npm run test:open

## Cómo ejecutar las pruebas de API

1. Importar `03-modulo-api/Prueba.postman_collection.json` en Postman (**File → Import**).
2. Abrir la colección «Prueba» y presionar **Run**.
3. Verificar que el resumen reporte 9 aserciones ejecutadas y 9 aprobadas.

## Decisiones técnicas

- **Cypress + JavaScript** para la automatización: instalación sin dependencias adicionales, ciclo de retroalimentación rápido y buena legibilidad de las aserciones.
- **Page Object Model** en la suite de automatización, para centralizar los selectores y aislar las pruebas de los cambios en la interfaz.
- **Selectores `data-test`** en lugar de `id` o clases CSS, por ser atributos dedicados a pruebas y no verse afectados por refactorizaciones de estilos.
- **Gherkin** para documentar los escenarios del módulo funcional, de modo que sirvan como especificación ejecutable y base para una futura automatización BDD.
- **Cambio de API en el módulo 3**: se sustituyó `reqres.in` por una instancia propia en mockapi.io, tras detectar que la API propuesta no persiste los recursos creados mediante POST. El hallazgo está documentado en el módulo correspondiente.
