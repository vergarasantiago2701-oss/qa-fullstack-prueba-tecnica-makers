# Módulo Funcional — MakersPay

## Producto bajo prueba

MakersPay es una billetera digital que permite al usuario iniciar sesión, ver su saldo y enviar dinero a otro usuario registrado usando su número de celular.

**Requerimiento bajo análisis:** un usuario autenticado puede enviar dinero a otro usuario registrado usando su número de celular.

Al no existir un ambiente desplegado, el trabajo se desarrolló como **testing de caja negra basado en requisitos**: análisis de la especificación, diseño de escenarios y casos listos para ejecutarse, y prueba estática sobre el requerimiento.

## Proceso de testing aplicado

| Etapa | Actividad realizada | Artefacto |
| --- | --- | --- |
| Análisis del requerimiento | Revisión de la especificación y las reglas de negocio en busca de ambigüedades, omisiones y reglas no verificables | `03-reporte-de-bugs.md` |
| Planificación | Definición del alcance, la estrategia, las técnicas a aplicar y los criterios de cierre | Este documento |
| Diseño de escenarios | Derivación de 7 escenarios a partir de las 3 funcionalidades y las 6 reglas de negocio | `01-escenarios-de-prueba.md` y `.feature` |
| Diseño de casos | Descomposición de los escenarios en 18 casos, cada uno con su técnica y tipo asignados | `02-casos-de-prueba.md` |
| Gestión y seguimiento | Carga de cada caso como tarjeta en un tablero Kanban con estados Todo / In Progress / Done | GitHub Project del repositorio |
| Reporte de defectos | Documentación de los hallazgos de la prueba estática, con severidad, prioridad y recomendación | `03-reporte-de-bugs.md` |
| Cierre | Verificación de la cobertura de reglas de negocio y funcionalidades | Este documento |

## Alcance

Se cubren las tres funcionalidades del producto, con profundidad proporcional a su criticidad.

### Dentro del alcance

- **Inicio de sesión:** autenticación válida e inválida, y restricción de acceso sin sesión activa. Es la funcionalidad habilitante: sin sesión no hay saldo ni envíos.
- **Ver saldo:** visualización del saldo, consistencia después de transacciones exitosas y fallidas, y registro en el historial.
- **Enviar dinero:** las seis reglas de negocio del requerimiento. Es donde se concentra la lógica y, por lo tanto, el esfuerzo de prueba.

### Fuera del alcance

- Pruebas de rendimiento y carga.
- Pruebas de seguridad en profundidad (cifrado, autenticación multifactor, pruebas de penetración).
- Integración con pasarelas de pago o entidades bancarias reales.
- Registro de usuarios y recuperación de contraseña, por no formar parte del requerimiento entregado.

## Reglas de negocio bajo prueba

| ID | Regla | Escenario | Casos |
| --- | --- | --- | --- |
| RN1 | Monto mínimo de $5.000 COP | ESC-03 | MP-07, MP-08 |
| RN2 | Monto máximo de $2.000.000 COP | ESC-03 | MP-09, MP-10 |
| RN3 | No se puede enviar más del saldo disponible | ESC-04 | MP-11, MP-12 |
| RN4 | No se permiten envíos al propio número de celular | ESC-05 | MP-13 |
| RN5 | Transacción exitosa: descuenta, acredita y registra historial | ESC-06 | MP-05, MP-06, MP-15 |
| RN6 | Transacción fallida: mensaje claro y saldo sin afectar | ESC-07 | MP-16 |

## Técnicas de prueba aplicadas

| Técnica | Dónde se aplicó | Por qué |
| --- | --- | --- |
| Análisis de valores límite | MP-07 a MP-10, MP-12 | Los defectos se concentran en los bordes de un rango. Probar $5.000 exacto y $4.999 detecta un `>` escrito donde correspondía `>=`; un valor intermedio como $10.000 nunca lo revelaría |
| Partición de equivalencia | MP-01, MP-02, MP-04, MP-11 | Agrupa las entradas en clases válidas e inválidas y prueba un representante de cada una, en lugar de agotar todos los valores posibles |
| Tabla de decisión | MP-05, MP-06, MP-15 | Las reglas se combinan entre sí: una transacción exitosa debe cumplir tres efectos simultáneos. La técnica obliga a verificarlos en conjunto y no por separado |
| Pruebas negativas | MP-13, MP-16 | Confirma que el sistema rechaza lo que debe rechazar. Validar solo el camino feliz deja fuera la mitad del comportamiento |
| Adivinación de errores | MP-03, MP-14, MP-17, MP-18 | Basada en experiencia sobre dónde suelen fallar las billeteras digitales: montos en cero o negativos, destinatarios inexistentes, formatos inválidos y accesos sin sesión |

## Tipos de prueba aplicados

| Tipo | Aplicación |
| --- | --- |
| Funcional | Verificar que las tres funcionalidades cumplen lo especificado |
| De valores límite | Montos en $4.999, $5.000, $2.000.000 y $2.000.001, y monto igual al saldo disponible |
| Negativa | Credenciales inválidas, saldo insuficiente, autoenvío, montos y formatos fuera de rango |
| End-to-end | MP-15: flujo completo verificando saldos e historiales de ambos usuarios |
| De regresión | MP-16: confirmar que una transacción fallida no deja efectos secundarios |
| Estática | Revisión del requerimiento, que produjo los seis hallazgos del reporte de bugs |

## Riesgos identificados

| Riesgo | Impacto | Tratamiento |
| --- | --- | --- |
| Ausencia de ambiente desplegado | No es posible ejecutar pruebas dinámicas ni confirmar el comportamiento real | Los casos quedan diseñados y listos para ejecutar en cuanto exista ambiente |
| Mensajes de error no especificados | Los casos negativos no tienen un texto contra el cual contrastar | Reportado como BUG-01; se requiere definición del equipo de producto |
| Concurrencia no contemplada | Riesgo de saldo negativo y pérdida monetaria | Reportado como BUG-03 con severidad crítica |

## Cobertura y criterios de cierre

- **3 de 3** funcionalidades del producto cubiertas.
- **6 de 6** reglas de negocio cubiertas, cada una con al menos un caso positivo y uno negativo.
- **7** escenarios diseñados, descompuestos en **18** casos de prueba.
- **6** defectos de especificación reportados con severidad, prioridad y recomendación.

Todos los casos están cargados como tarjetas en el tablero del repositorio para su seguimiento.

**Estado en el tablero:** los 18 casos figuran en la columna *Todo* del tablero del repositorio, que en este contexto significa "diseñados y listos para ejecutar". No se movieron a *Done* porque su ejecución requiere un ambiente desplegado de MakersPay, que no está disponible. Los casos del módulo de automatización sí figuran en *Done*, por haberse ejecutado efectivamente sobre SauceDemo.

## Documentos del módulo

| Archivo | Contenido |
| --- | --- |
| `01-escenarios-de-prueba.md` | Los 7 escenarios y su trazabilidad con reglas y casos |
| `01-escenarios-de-prueba.feature` | Los mismos escenarios en Gherkin, listos para automatizar con BDD |
| `02-casos-de-prueba.md` | Los 18 casos detallados, con técnica y tipo señalados |
| `03-reporte-de-bugs.md` | Los 6 hallazgos de la prueba estática y el formato de reporte de ejecución |
