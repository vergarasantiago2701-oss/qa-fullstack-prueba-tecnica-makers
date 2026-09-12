# Escenarios de Prueba — MakersPay

Un **escenario de prueba** describe *qué* se va a probar, a alto nivel, sin entrar en datos ni pasos concretos. Cada escenario se descompone luego en uno o varios **casos de prueba**, que sí especifican precondiciones, pasos, datos y resultado esperado.

Los escenarios se derivaron de las tres funcionalidades del producto y de las seis reglas de negocio del requerimiento.

## Escenarios identificados

| ID | Escenario | Funcionalidad | Reglas | Casos derivados |
| --- | --- | --- | --- | --- |
| ESC-01 | Inicio de sesión en la billetera | Iniciar sesión | — | MP-01, MP-02, MP-03 |
| ESC-02 | Consulta del saldo disponible | Ver saldo | — | MP-04 |
| ESC-03 | Envío de dinero con montos dentro y fuera del rango permitido | Enviar dinero | RN1, RN2 | MP-07, MP-08, MP-09, MP-10, MP-17 |
| ESC-04 | Envío de dinero frente al saldo disponible | Enviar dinero | RN3 | MP-11, MP-12 |
| ESC-05 | Envío de dinero según el destinatario indicado | Enviar dinero | RN4 | MP-13, MP-14, MP-18 |
| ESC-06 | Efectos de una transacción exitosa sobre saldos e historial | Enviar dinero / Ver saldo | RN5 | MP-05, MP-06, MP-15 |
| ESC-07 | Comportamiento del sistema ante una transacción fallida | Enviar dinero | RN6 | MP-16 |

## Cobertura de las reglas de negocio

| Regla | Descripción | Escenario |
| --- | --- | --- |
| RN1 | Monto mínimo de $5.000 COP | ESC-03 |
| RN2 | Monto máximo de $2.000.000 COP | ESC-03 |
| RN3 | No se puede enviar más del saldo disponible | ESC-04 |
| RN4 | No se permiten envíos al propio número de celular | ESC-05 |
| RN5 | Transacción exitosa: descuenta, acredita y registra historial | ESC-06 |
| RN6 | Transacción fallida: mensaje claro y saldo sin afectar | ESC-07 |

Las seis reglas del requerimiento quedan cubiertas por al menos un escenario.

## Especificación en Gherkin

Los escenarios del requerimiento central (envío de dinero) se expresan además en formato Gherkin en el archivo `01-escenarios-de-prueba.feature`, de modo que funcionen como especificación ejecutable y como base directa para automatizarlos bajo un enfoque BDD.

Los escenarios de inicio de sesión y consulta de saldo se documentan únicamente como casos de prueba, por ser funcionalidades habilitantes y no el requerimiento bajo análisis.
