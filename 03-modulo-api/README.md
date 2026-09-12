# Módulo API — Pruebas Funcionales con Postman

Pruebas funcionales sobre una API REST, validando el ciclo completo de vida de un recurso: creación, consulta, actualización y verificación de la persistencia del cambio.

## API bajo prueba

| Concepto | Detalle |
| --- | --- |
| Endpoint base | `https://6aa4bd771397053d42bb04d8.mockapi.io/api/users` |
| Herramienta | Postman Desktop |
| Métodos ejercitados | POST, GET, PUT |
| Tipo de prueba | Funcional, de caja negra, a nivel de servicio |

### Por qué no se usó reqres.in

El enunciado propone `https://reqres.in/api/`. Durante la exploración inicial se detectaron dos limitaciones que impiden cumplir el resultado esperado tal como está redactado:

1. **No persiste los recursos creados.** El `POST /users` responde `201 Created` con un identificador asignado, pero el `GET /users/{id}` sobre ese mismo identificador devuelve `404` con cuerpo vacío. Es un servicio simulado: la respuesta del POST no refleja un cambio real de estado.
2. **El esquema de lectura no contiene los campos a verificar.** Al consultar un usuario que sí existe (`GET /users/2`), la respuesta expone `id`, `email`, `first_name`, `last_name` y `avatar`. No existen `name` ni `job`, que son justamente los campos que el enunciado pide comparar contra los enviados en el POST.

La grabación de la convocatoria autoriza explícitamente el uso de una API de prueba alterna ante fallos de la API pública. Se desplegó una instancia propia en mockapi.io, que sí persiste los recursos y permite validar el requerimiento de extremo a extremo. Ambos hallazgos quedan documentados formalmente en el reporte, con severidad y recomendación.

## Casos ejecutados

| ID | Caso | Método | Aserciones | Resultado |
| --- | --- | --- | --- | --- |
| API-01 | Creación de usuario | POST | 1 | APROBADO |
| API-02 | Consulta del usuario creado | GET | 3 | APROBADO |
| API-03 | Actualización del usuario | PUT | 3 | APROBADO |
| API-04 | Verificación de la persistencia | GET | 2 | APROBADO |

Los casos **API-01** y **API-02** cubren el requisito del enunciado: crear un usuario, extraer su identificador y consultarlo verificando que los datos coincidan con los enviados.

Los casos **API-03** y **API-04** se incorporaron como cobertura adicional del ciclo de actualización. Verifican el mismo dato pero comprueban propiedades distintas del servicio: API-03 valida lo que la API **responde** al actualizar, y API-04 valida lo que la API **devuelve al volver a consultarse**. Un servicio puede responder correctamente a una escritura sin haberla almacenado, como quedó demostrado con reqres.in.

## Resultado de la ejecución

Ejecución consolidada mediante el Collection Runner de Postman:

| Indicador | Resultado |
| --- | --- |
| Peticiones ejecutadas | 4 |
| Aserciones ejecutadas | 9 |
| Aserciones aprobadas | 9 |
| Aserciones fallidas | 0 |
| Errores | 0 |
| Duración total | 2 s 541 ms |
| Tiempo medio de respuesta | 172 ms |

## Encadenamiento de peticiones

Las cuatro peticiones operan sobre el mismo recurso sin identificadores escritos a mano, mediante variables de colección que se alimentan en tiempo de ejecución:

| Variable | Origen | Uso |
| --- | --- | --- |
| `nombre_enviado` | Script previo del POST | Comparar el nombre devuelto por el GET contra el enviado |
| `trabajo_enviado` | Script previo del POST | Comparar el cargo devuelto por el GET contra el enviado |
| `id_usuario` | Script posterior del POST | Construir las URL del GET y del PUT |
| `nombre_actualizado` | Script previo del PUT | Verificar que la actualización se refleje y persista |

La distinción entre script *previo* y *posterior* es deliberada: los datos enviados deben capturarse **antes** de despachar la petición, mientras que el identificador solo existe **después**, porque lo genera el servidor.

Este mecanismo resuelve el requisito de extraer el identificador del usuario recién creado y reutilizarlo en la consulta posterior. Al no haber valores fijos en el código, la colección puede ejecutarse cuantas veces se quiera sin ajustes manuales.

## Contenido de la carpeta

| Archivo | Descripción |
| --- | --- |
| `Reporte-Pruebas-API-Postman.docx` | Reporte completo: detalle de cada caso, explicación de las validaciones, capturas de evidencia y hallazgos |
| `Prueba.postman_collection.json` | Colección exportada en formato v2.1, lista para importar y ejecutar |
| `capturas-postman/` | Capturas de pantalla de la ejecución en Postman |

## Cómo reproducir las pruebas

1. Importar `Prueba.postman_collection.json` en Postman (**File → Import**).
2. Abrir la colección «Prueba» y presionar **Run**.
3. Verificar que el resumen reporte **9 aserciones ejecutadas y 9 aprobadas**.

No requiere configuración adicional: la URL base está declarada en la colección y las variables se alimentan solas durante la ejecución.
