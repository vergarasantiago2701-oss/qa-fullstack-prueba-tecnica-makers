# language: es

Característica: Envío de dinero entre usuarios de MakersPay
  Como usuario autenticado de MakersPay
  Quiero enviar dinero a otro usuario registrado usando su número de celular
  Para transferir fondos sin depender de datos bancarios

  Antecedentes:
    Dado que el usuario "Santiago" inició sesión en MakersPay
    Y su número de celular registrado es "3001234567"
    Y su saldo disponible es de 3000000 COP
    Y existe un usuario registrado con el celular "3009876543"

  @ESC-03 @RN1 @valores-limite @MP-07
  Escenario: Envío por el monto mínimo permitido
    Cuando envía 5000 COP al celular "3009876543"
    Entonces la transacción se procesa correctamente
    Y su saldo disponible pasa a ser 2995000 COP

  @ESC-03 @RN1 @RN2 @valores-limite
  Esquema del escenario: Validación de los límites de monto por transacción
    Cuando envía <monto> COP al celular "3009876543"
    Entonces el resultado de la transacción es "<resultado>"

    Ejemplos:
      | monto   | resultado |
      | 4999    | rechazada |
      | 5000    | aprobada  |
      | 2000000 | aprobada  |
      | 2000001 | rechazada |

  @ESC-04 @RN3 @MP-11
  Escenario: Rechazo por saldo insuficiente
    Dado que su saldo disponible es de 20000 COP
    Cuando envía 50000 COP al celular "3009876543"
    Entonces la transacción es rechazada
    Y se muestra el mensaje "Saldo insuficiente para realizar la transacción"
    Y su saldo disponible permanece en 20000 COP

  @ESC-04 @RN3 @valores-limite @MP-12
  Escenario: Envío por un monto exactamente igual al saldo disponible
    Dado que su saldo disponible es de 50000 COP
    Cuando envía 50000 COP al celular "3009876543"
    Entonces la transacción se procesa correctamente
    Y su saldo disponible pasa a ser 0 COP

  @ESC-05 @RN4 @MP-13
  Escenario: Rechazo del envío al propio número de celular
    Cuando envía 10000 COP al celular "3001234567"
    Entonces la transacción es rechazada
    Y se muestra el mensaje "No es posible enviar dinero a tu propio número"
    Y su saldo disponible no se modifica

  @ESC-05 @MP-14
  Escenario: Rechazo del envío a un celular no registrado
    Cuando envía 10000 COP al celular "3001111111"
    Entonces la transacción es rechazada
    Y se muestra un mensaje indicando que el número no está registrado
    Y su saldo disponible no se modifica

  @ESC-06 @RN5 @MP-15
  Escenario: Efectos de una transacción exitosa sobre ambos usuarios
    Dado que el destinatario con celular "3009876543" tiene un saldo de 10000 COP
    Cuando envía 25000 COP al celular "3009876543"
    Entonces su saldo disponible disminuye en 25000 COP
    Y el saldo del destinatario aumenta a 35000 COP
    Y el movimiento queda registrado en el historial de ambos usuarios

  @ESC-07 @RN6 @MP-16
  Escenario: Una transacción fallida no altera ningún saldo
    Dado que su saldo disponible es de 30000 COP
    Y el destinatario con celular "3009876543" tiene un saldo de 10000 COP
    Cuando envía 4000 COP al celular "3009876543"
    Entonces la transacción es rechazada
    Y se muestra un mensaje de error claro
    Y su saldo disponible permanece en 30000 COP
    Y el saldo del destinatario permanece en 10000 COP
