const SELECTORES = {
  campoUsuario: '[data-test="username"]',
  campoPassword: '[data-test="password"]',
  botonLogin: '[data-test="login-button"]',
  mensajeError: '[data-test="error"]',
};

class LoginPage {
  visitar() {
    cy.visit('/');
  }

  escribirUsuario(usuario) {
    cy.get(SELECTORES.campoUsuario).type(usuario);
  }

  escribirPassword(password) {
    cy.get(SELECTORES.campoPassword).type(password);
  }

  clickBotonLogin() {
    cy.get(SELECTORES.botonLogin).click();
  }

  iniciarSesion(usuario, password) {
    this.escribirUsuario(usuario);
    this.escribirPassword(password);
    this.clickBotonLogin();
  }

  mensajeError() {
    return cy.get(SELECTORES.mensajeError);
  }
}

export default new LoginPage();