# Casos de Prueba — MakersPay

Cada caso deriva de un escenario (ver `01-escenarios-de-prueba.md`) e indica la técnica de diseño y el tipo de prueba que le corresponde.

## Resumen

| ID | Caso | Escenario | Técnica | Tipo | Prioridad |
| --- | --- | --- | --- | --- | --- |
| MP-01 | Login exitoso con credenciales válidas | ESC-01 | Partición de equivalencia | Funcional | Alta |
| MP-02 | Login fallido con credenciales inválidas | ESC-01 | Partición de equivalencia | Negativa | Alta |
| MP-03 | Acceso denegado sin sesión activa | ESC-01 | Adivinación de errores | Negativa | Alta |
| MP-04 | Visualización del saldo disponible | ESC-02 | Partición de equivalencia | Funcional | Alta |
| MP-05 | El saldo se actualiza tras una transacción exitosa | ESC-06 | Tabla de decisión | Funcional | Alta |
| MP-06 | El historial registra el movimiento en ambos usuarios | ESC-06 | Tabla de decisión | Funcional | Alta |
| MP-07 | Envío por el monto mínimo permitido | ESC-03 | Análisis de valores límite | Funcional | Alta |
| MP-08 | Envío por un monto inferior al mínimo | ESC-03 | Análisis de valores límite | Negativa | Alta |
| MP-09 | Envío por el monto máximo permitido | ESC-03 | Análisis de valores límite | Funcional | Alta |
| MP-10 | Envío por un monto superior al máximo | ESC-03 | Análisis de valores límite | Negativa | Alta |
| MP-11 | Envío por un monto mayor al saldo disponible | ESC-04 | Partición de equivalencia | Negativa | Alta |
| MP-12 | Envío por un monto igual al saldo disponible | ESC-04 | Análisis de valores límite | Funcional | Media |
| MP-13 | Envío al propio número de celular | ESC-05 | Pruebas negativas | Negativa | Alta |
| MP-14 | Envío a un celular no registrado | ESC-05 | Adivinación de errores | Negativa | Media |
| MP-15 | Efectos de una transacción exitosa | ESC-06 | Tabla de decisión | End-to-end | Alta |
| MP-16 | Una transacción fallida no modifica saldos | ESC-07 | Pruebas negativas | Regresión | Alta |
| MP-17 | Envío con monto en cero o negativo | ESC-03 | Adivinación de errores | Negativa | Media |
| MP-18 | Envío con celular en formato inválido | ESC-05 | Adivinación de errores | Negativa | Media |

## Detalle

### MP-01 — Login exitoso con credenciales válidas

**Escenario:** ESC-01 · **Técnica:** Partición de equivalencia · **Tipo:** Funcional · **Prioridad:** Alta

**Precondición:** el usuario está registrado en MakersPay y no tiene sesión activa.

**Pasos:** 1) Ingresar a la aplicación. 2) Escribir usuario y contraseña válidos. 3) Presionar "Iniciar sesión".

**Resultado esperado:** el sistema autentica al usuario, lo redirige al inicio de la billetera y muestra su saldo disponible.

### MP-02 — Login fallido con credenciales inválidas

**Escenario:** ESC-01 · **Técnica:** Partición de equivalencia · **Tipo:** Negativa · **Prioridad:** Alta

**Precondición:** el usuario está registrado en MakersPay.

**Pasos:** 1) Ingresar a la aplicación. 2) Escribir un usuario válido con una contraseña incorrecta. 3) Presionar "Iniciar sesión".

**Resultado esperado:** el sistema rechaza el acceso, muestra un mensaje de error claro y no revela si el fallo fue del usuario o de la contraseña.

### MP-03 — Acceso denegado a la billetera sin sesión activa

**Escenario:** ESC-01 · **Técnica:** Adivinación de errores · **Tipo:** Negativa · **Prioridad:** Alta

**Precondición:** no existe una sesión activa en el navegador.

**Pasos:** 1) Acceder directamente a la URL de la billetera sin haber iniciado sesión.

**Resultado esperado:** el sistema redirige al inicio de sesión y en ningún momento expone el saldo ni el historial.

### MP-04 — Visualización del saldo disponible

**Escenario:** ESC-02 · **Técnica:** Partición de equivalencia · **Tipo:** Funcional · **Prioridad:** Alta

**Precondición:** el usuario inició sesión y su cuenta tiene un saldo de $100.000 COP.

**Pasos:** 1) Ingresar a la sección de saldo de la billetera.

**Resultado esperado:** se muestra $100.000 COP, con el formato de moneda colombiana y coincidiendo con el saldo real de la cuenta.

### MP-05 — El saldo se actualiza tras una transacción exitosa

**Escenario:** ESC-06 · **Técnica:** Tabla de decisión · **Tipo:** Funcional · **Prioridad:** Alta

**Precondición:** el usuario inició sesión con un saldo de $100.000 COP.

**Pasos:** 1) Enviar $30.000 COP a un celular registrado. 2) Volver a la sección de saldo.

**Resultado esperado:** el saldo mostrado es de $70.000 COP.

### MP-06 — El historial registra el movimiento en ambos usuarios

**Escenario:** ESC-06 · **Técnica:** Tabla de decisión · **Tipo:** Funcional · **Prioridad:** Alta

**Precondición:** se realizó una transacción exitosa de $30.000 COP entre dos usuarios registrados.

**Pasos:** 1) Consultar el historial del remitente. 2) Consultar el historial del destinatario.

**Resultado esperado:** el movimiento aparece en ambos historiales, con el monto, la fecha y la contraparte correctos; como egreso en el remitente y como ingreso en el destinatario.

### MP-07 — Envío por el monto mínimo permitido

**Escenario:** ESC-03 · **Regla:** RN1 · **Técnica:** Análisis de valores límite · **Tipo:** Funcional · **Prioridad:** Alta

**Precondición:** el usuario inició sesión con saldo suficiente.

**Pasos:** 1) Enviar $5.000 COP a un celular registrado distinto al propio.

**Resultado esperado:** la transacción se procesa correctamente. El valor límite inferior es un monto válido.

### MP-08 — Envío por un monto inferior al mínimo

**Escenario:** ESC-03 · **Regla:** RN1 · **Técnica:** Análisis de valores límite · **Tipo:** Negativa · **Prioridad:** Alta

**Precondición:** el usuario inició sesión con saldo suficiente.

**Pasos:** 1) Enviar $4.999 COP a un celular registrado.

**Resultado esperado:** la transacción se rechaza con un mensaje que indica el monto mínimo permitido, y el saldo no se modifica.

### MP-09 — Envío por el monto máximo permitido

**Escenario:** ESC-03 · **Regla:** RN2 · **Técnica:** Análisis de valores límite · **Tipo:** Funcional · **Prioridad:** Alta

**Precondición:** el usuario inició sesión con un saldo de $3.000.000 COP.

**Pasos:** 1) Enviar $2.000.000 COP a un celular registrado.

**Resultado esperado:** la transacción se procesa correctamente. El valor límite superior es un monto válido.

### MP-10 — Envío por un monto superior al máximo

**Escenario:** ESC-03 · **Regla:** RN2 · **Técnica:** Análisis de valores límite · **Tipo:** Negativa · **Prioridad:** Alta

**Precondición:** el usuario inició sesión con un saldo de $3.000.000 COP.

**Pasos:** 1) Enviar $2.000.001 COP a un celular registrado.

**Resultado esperado:** la transacción se rechaza con un mensaje que indica el monto máximo permitido, y el saldo no se modifica.

### MP-11 — Envío por un monto mayor al saldo disponible

**Escenario:** ESC-04 · **Regla:** RN3 · **Técnica:** Partición de equivalencia · **Tipo:** Negativa · **Prioridad:** Alta

**Precondición:** el usuario inició sesión con un saldo de $20.000 COP.

**Pasos:** 1) Enviar $50.000 COP a un celular registrado.

**Resultado esperado:** la transacción se rechaza por saldo insuficiente y el saldo permanece en $20.000 COP.

### MP-12 — Envío por un monto exactamente igual al saldo disponible

**Escenario:** ESC-04 · **Regla:** RN3 · **Técnica:** Análisis de valores límite · **Tipo:** Funcional · **Prioridad:** Media

**Precondición:** el usuario inició sesión con un saldo de $50.000 COP.

**Pasos:** 1) Enviar $50.000 COP a un celular registrado.

**Resultado esperado:** la transacción se procesa y el saldo queda en $0. Este es el límite superior de RN3 y suele revelar comparaciones mal implementadas.

### MP-13 — Envío al propio número de celular

**Escenario:** ESC-05 · **Regla:** RN4 · **Técnica:** Pruebas negativas · **Tipo:** Negativa · **Prioridad:** Alta

**Precondición:** el usuario inició sesión con saldo suficiente.

**Pasos:** 1) Ingresar el propio número de celular como destinatario. 2) Enviar $10.000 COP.

**Resultado esperado:** la transacción se rechaza indicando que no es posible enviarse dinero a uno mismo, y el saldo no se modifica.

### MP-14 — Envío a un número de celular no registrado

**Escenario:** ESC-05 · **Técnica:** Adivinación de errores · **Tipo:** Negativa · **Prioridad:** Media

**Precondición:** el usuario inició sesión con saldo suficiente.

**Pasos:** 1) Ingresar un celular que no pertenece a ningún usuario de MakersPay. 2) Enviar $10.000 COP.

**Resultado esperado:** la transacción se rechaza con un mensaje claro y el saldo no se modifica.

**Observación:** el requerimiento no especifica este comportamiento. Se reporta como ambigüedad en `03-reporte-de-bugs.md` (BUG-04).

### MP-15 — Efectos de una transacción exitosa sobre ambos usuarios

**Escenario:** ESC-06 · **Regla:** RN5 · **Técnica:** Tabla de decisión · **Tipo:** End-to-end · **Prioridad:** Alta

**Precondición:** remitente con $100.000 COP y destinatario con $10.000 COP, ambos registrados.

**Pasos:** 1) Enviar $25.000 COP del remitente al destinatario. 2) Verificar el saldo de ambos. 3) Verificar el historial de ambos.

**Resultado esperado:** el remitente queda con $75.000 COP, el destinatario con $35.000 COP, y el movimiento figura en ambos historiales. Los tres efectos de RN5 deben cumplirse de forma conjunta.

### MP-16 — Una transacción fallida no modifica ningún saldo

**Escenario:** ESC-07 · **Regla:** RN6 · **Técnica:** Pruebas negativas · **Tipo:** Regresión · **Prioridad:** Alta

**Precondición:** remitente con $30.000 COP y destinatario con $10.000 COP.

**Pasos:** 1) Intentar enviar $4.000 COP (por debajo del mínimo). 2) Verificar el saldo de ambos usuarios. 3) Verificar ambos historiales.

**Resultado esperado:** se muestra un mensaje de error claro, los saldos permanecen en $30.000 y $10.000 COP, y no se registra ningún movimiento en los historiales.

### MP-17 — Envío con monto en cero o negativo

**Escenario:** ESC-03 · **Técnica:** Adivinación de errores · **Tipo:** Negativa · **Prioridad:** Media

**Precondición:** el usuario inició sesión con saldo suficiente.

**Pasos:** 1) Intentar enviar $0 COP. 2) Intentar enviar un monto negativo.

**Resultado esperado:** ambos intentos se rechazan antes de procesar la transacción. Un monto negativo nunca debe poder incrementar el saldo del remitente.

### MP-18 — Envío con número de celular en formato inválido

**Escenario:** ESC-05 · **Técnica:** Adivinación de errores · **Tipo:** Negativa · **Prioridad:** Media

**Precondición:** el usuario inició sesión con saldo suficiente.

**Pasos:** 1) Ingresar un celular con menos de 10 dígitos, con letras o con caracteres especiales. 2) Intentar enviar $10.000 COP.

**Resultado esperado:** el sistema valida el formato antes de procesar y muestra un mensaje indicando que el número no es válido.
