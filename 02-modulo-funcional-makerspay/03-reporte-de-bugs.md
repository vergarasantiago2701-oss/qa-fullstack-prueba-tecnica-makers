# Reporte de Bugs — MakersPay

## Contexto

MakersPay no cuenta con un ambiente desplegado, por lo que no fue posible ejecutar pruebas dinámicas. En su lugar se aplicó **prueba estática** sobre el requerimiento y las reglas de negocio: una revisión sistemática de la especificación en busca de ambigüedades, omisiones y reglas no verificables.

Los defectos de especificación son defectos reales y son los más económicos de corregir, porque se detectan antes de que exista una línea de código. Los siguientes hallazgos deberían resolverse con el equipo de producto antes de iniciar el desarrollo.

Al final se incluye un ejemplo del formato que se usaría para reportar un defecto encontrado durante la ejecución, una vez exista el ambiente de pruebas.

## Criterios de clasificación

**Severidad** (impacto técnico): Crítica, Alta, Media, Baja.
**Prioridad** (urgencia de corrección): Alta, Media, Baja.

---

## BUG-01 — La regla RN6 no es verificable objetivamente

| | |
| --- | --- |
| **Tipo** | Defecto de especificación — testabilidad |
| **Severidad** | Media |
| **Prioridad** | Alta |
| **Regla afectada** | RN6 |

**Descripción:** RN6 establece que ante una transacción fallida "se muestra un mensaje de error claro", pero no define cuáles son esos mensajes ni qué significa "claro". Un criterio subjetivo no se puede verificar: dos personas evaluarían el mismo mensaje de forma distinta.

**Impacto:** los casos MP-08, MP-10, MP-11, MP-13, MP-14, MP-17 y MP-18 esperan mensajes de error específicos, pero no hay una fuente contra la cual contrastarlos. La prueba queda a criterio del tester.

**Recomendación:** definir el texto exacto de cada mensaje de error por tipo de rechazo (monto mínimo, monto máximo, saldo insuficiente, autoenvío, destinatario no registrado, formato inválido).

---

## BUG-02 — No se definen límites acumulados por período

| | |
| --- | --- |
| **Tipo** | Defecto de especificación — regla faltante |
| **Severidad** | Alta |
| **Prioridad** | Alta |
| **Regla afectada** | RN2 |

**Descripción:** el requerimiento define un máximo de $2.000.000 COP **por transacción**, pero no establece límites diarios, semanales ni mensuales. Tal como está especificado, un usuario podría realizar cien transacciones de $2.000.000 en un mismo día sin restricción alguna.

**Impacto:** en una billetera digital real esto tiene implicaciones regulatorias y de prevención de fraude y lavado de activos.

**Recomendación:** definir si existen topes acumulados y, en caso afirmativo, agregarlos como reglas de negocio con sus propios casos de prueba.

---

## BUG-03 — No se define el comportamiento ante transacciones concurrentes

| | |
| --- | --- |
| **Tipo** | Defecto de especificación — regla faltante |
| **Severidad** | Crítica |
| **Prioridad** | Alta |
| **Regla afectada** | RN3 |

**Descripción:** RN3 indica que el usuario no puede enviar más dinero del saldo disponible, pero no especifica cómo se comporta el sistema si se inician dos transacciones simultáneas desde la misma cuenta. Con un saldo de $50.000 y dos envíos concurrentes de $40.000, ambos podrían validar el saldo antes de que el otro lo descuente.

**Impacto:** riesgo de saldo negativo y pérdida monetaria directa. Es el defecto de mayor severidad identificado.

**Recomendación:** especificar el mecanismo de control de concurrencia (bloqueo optimista, transacciones atómicas o cola de procesamiento) e incorporar un caso de prueba dedicado.

---

## BUG-04 — No se define el comportamiento ante un celular no registrado

| | |
| --- | --- |
| **Tipo** | Defecto de especificación — omisión |
| **Severidad** | Alta |
| **Prioridad** | Alta |
| **Caso relacionado** | MP-14 |

**Descripción:** el requerimiento indica que el envío se realiza "a otro usuario registrado", pero no especifica qué ocurre cuando el número ingresado no corresponde a ningún usuario de la plataforma. No se define si se rechaza, si se ofrece invitar al destinatario, ni qué mensaje se muestra.

**Impacto:** es uno de los flujos de error más frecuentes en una billetera digital y queda sin comportamiento definido. Sin especificación, cada desarrollador lo resolvería de forma distinta.

**Recomendación:** definir explícitamente el comportamiento esperado y su mensaje asociado.

---

## BUG-05 — No se especifica si el monto admite decimales

| | |
| --- | --- |
| **Tipo** | Defecto de especificación — ambigüedad |
| **Severidad** | Media |
| **Prioridad** | Media |
| **Reglas afectadas** | RN1, RN2 |

**Descripción:** no se aclara si el monto debe ser un entero en pesos colombianos o si admite decimales, ni cómo se redondea en ese caso. Un envío de $5.000,50 no tiene comportamiento definido.

**Impacto:** afecta la validación de los límites y puede generar descuadres contables por redondeo acumulado.

**Recomendación:** especificar que el monto es un número entero de pesos colombianos, o definir la regla de redondeo aplicable.

---

## BUG-06 — No se contempla el estado del usuario destinatario

| | |
| --- | --- |
| **Tipo** | Defecto de especificación — omisión |
| **Severidad** | Media |
| **Prioridad** | Media |
| **Regla afectada** | RN5 |

**Descripción:** el requerimiento asume que un usuario registrado siempre puede recibir dinero, pero no contempla cuentas inactivas, suspendidas o bloqueadas. RN5 indica que se incrementa el saldo del destinatario sin condicionarlo a su estado.

**Impacto:** podría acreditarse dinero a una cuenta bloqueada, dejando fondos inaccesibles para ambas partes.

**Recomendación:** definir qué estados de cuenta pueden recibir transferencias y el comportamiento cuando el destinatario no está habilitado.

---

## Resumen de hallazgos

| ID | Hallazgo | Tipo | Severidad | Prioridad |
| --- | --- | --- | --- | --- |
| BUG-01 | RN6 no es verificable objetivamente | Testabilidad | Media | Alta |
| BUG-02 | Sin límites acumulados por período | Regla faltante | Alta | Alta |
| BUG-03 | Concurrencia no definida | Regla faltante | Crítica | Alta |
| BUG-04 | Celular no registrado sin comportamiento definido | Omisión | Alta | Alta |
| BUG-05 | Decimales en el monto sin especificar | Ambigüedad | Media | Media |
| BUG-06 | Estado del destinatario no contemplado | Omisión | Media | Media |

---

## Formato para defectos de ejecución

El siguiente es el formato que se utilizaría para reportar un defecto detectado al ejecutar los casos de prueba sobre un ambiente desplegado. Se incluye como referencia del estándar de reporte, no como un hallazgo real.

### DEF-XX — Título breve y descriptivo del defecto

| | |
| --- | --- |
| **Caso de prueba** | MP-XX |
| **Severidad** | Crítica / Alta / Media / Baja |
| **Prioridad** | Alta / Media / Baja |
| **Ambiente** | Navegador, versión, sistema operativo, ambiente (QA / Staging) |
| **Versión** | Build en la que se detectó |

**Precondiciones:** estado necesario del sistema y de los datos antes de reproducir.

**Pasos para reproducir:**

1. Paso uno.
2. Paso dos.
3. Paso tres.

**Resultado esperado:** comportamiento definido por el requerimiento.

**Resultado obtenido:** comportamiento observado, con el dato concreto que evidencia la diferencia.

**Evidencia:** captura de pantalla, log o respuesta del servicio.
