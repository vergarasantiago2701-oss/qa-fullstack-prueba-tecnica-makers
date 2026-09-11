import LoginPage from '../pages/LoginPage';

describe('Smoke Test - Inicio de sesión en SauceDemo', () => {
  let datos;

  before(() => {
    cy.fixture('datosLogin').then((contenido) => {
      datos = contenido;
    });
  });

  beforeEach(() => {
    LoginPage.visitar();
  });

  it('CP-01 | Permite iniciar sesión con credenciales válidas', () => {
    LoginPage.iniciarSesion(datos.usuarioValido.usuario, datos.usuarioValido.password);

    cy.url().should('include', '/inventory.html');
    cy.get('[data-test="title"]').should('have.text', 'Products');
  });

  it('CP-02 | Rechaza el inicio de sesión con contraseña incorrecta', () => {
    LoginPage.iniciarSesion(datos.usuarioValido.usuario, datos.passwordIncorrecta);

    LoginPage.mensajeError()
      .should('be.visible')
      .and('have.text', datos.mensajesError.credencialesInvalidas);
    cy.url().should('not.include', '/inventory.html');
  });

  it('CP-03 | Exige el campo usuario cuando el formulario está vacío', () => {
    LoginPage.clickBotonLogin();

    LoginPage.mensajeError()
      .should('be.visible')
      .and('have.text', datos.mensajesError.usuarioRequerido);
  });

  it('CP-04 | Exige el campo contraseña cuando solo se ingresa el usuario', () => {
    LoginPage.escribirUsuario(datos.usuarioValido.usuario);
    LoginPage.clickBotonLogin();

    LoginPage.mensajeError()
      .should('be.visible')
      .and('have.text', datos.mensajesError.passwordRequerida);
  });

  it('CP-05 | Rechaza el inicio de sesión de un usuario bloqueado', () => {
    LoginPage.iniciarSesion(datos.usuarioBloqueado.usuario, datos.usuarioBloqueado.password);

    LoginPage.mensajeError()
      .should('be.visible')
      .and('have.text', datos.mensajesError.usuarioBloqueado);
  });
});