<%@ Page Title="Crear Nuevo Usuario" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="ecommerce_livingston.Registro" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <main aria-labelledby="title">
        <section class="d-flex justify-content-center align-items-center min-vh-100">
            <div class="container">
                
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <h2 class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-10">Nuevo usuario</h2>
                            <div class="row justify-content-center">
                                <div class="col-md-3">
                                    <div class="d-flex mb-4">
                                      <div class="input-group">
                                        <span class="input-group-text mb-1"><i class="bi bi-person-fill"></i></span>
                                        <div class="form-floating flex-fill mb-1">
                                          <asp:TextBox type="text" class="form-control" runat="server" ID="txtNombre" required="true"/>
                                          <label type="text" for="txtNombre" class="text-dark">Nombre</label>
                                        </div>
                                      </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="input-group">
                                            <span class="input-group-text mb-1"><i class="bi bi-person-fill"></i></span>
                                            <div class="form-floating flex-fill mb-1">
                                                <asp:TextBox type="text" class="form-control" runat="server" ID="txtApellido" required="true"/>
                                                <label type="text" for="txtApellido" class="text-dark">Apellido</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="input-group">
                                            <span class="input-group-text mb-1"><i class="bi bi-123"></i></span>
                                            <div class="form-floating mb-1">
                                                <asp:TextBox type="text" class="form-control" runat="server" ID="txtDni" required="true"/>
                                                <label type="text" for="txtDni" class="text-dark">DNI</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="input-group ">
                                            <span class="input-group-text mb-1"><i class="bi bi-envelope-at-fill"></i></span>
                                            <div class="form-floating flex-fill mb-1">
                                                <asp:TextBox type="email" class="form-control" runat="server" ID="txtMail" required="true"/>
                                                <label type="email" for="txtMail" class="text-dark">E-Mail</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="input-group ">
                                            <span class="input-group-text mb-1"><i class="bi bi-house-door-fill"></i></span>
                                            <div class="form-floating flex-fill mb-1">
                                                <asp:TextBox type="text" class="form-control" runat="server" ID="txtDomicilio" required="true"/>
                                                <label type="text" for="txtDomicilio" class="text-dark">Domicilio</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="input-group ">
                                            <span class="input-group-text mb-1"><i class="bi bi-key-fill"></i></span>
                                            <div class="form-floating flex-fill mb-1">
                                                <asp:TextBox type="password" class="form-control" runat="server" ID="txtPassword" required="true"/>
                                                <label type="text" for="txtPassword" class="text-dark">Contraseña</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class=" container justify-content-center ">
                                        <asp:Button Text="Registrarse" runat="server" ID="btnRegistroUsu" OnClick="btnRegistroUsu_Click"  CssClass="btn btn-primary btn-lg flex-fill" ValidationGroup="GuardarUsuario"/>
                                        <a href="Default.aspx" class="btn btn-secondary btn-lg flex-fill mr-5">Cancelar</a>
                                    </div>

                                    <%-- validaciones --%>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:ValidationSummary runat="server" ID="validationSummary" ValidationGroup="GuardarUsuario" CssClass="validation-summary fw-bold text-danger mt-5 col-form-label bg-light border rounded-3 " />
                                            <asp:CustomValidator runat="server" ID="customValidatorNombre" ControlToValidate="txtNombre" OnServerValidate="customValidatorNombre_ServerValidate" ValidationGroup="GuardarUsuario" ErrorMessage="El nombre es inválido" />
                                            <asp:CustomValidator runat="server" ID="customValidatorApellido" ControlToValidate="txtApellido" OnServerValidate="customValidatorApellido_ServerValidate" ValidationGroup="GuardarUsuario" ErrorMessage="El apellido es inválido" />
                                            <asp:CustomValidator runat="server" ID="customValidatorDocumento" ControlToValidate="txtDni" OnServerValidate="customValidatorDocumento_ServerValidate" ValidationGroup="GuardarUsuario" ErrorMessage="El número de documento es inválido" />
                                            <asp:CustomValidator runat="server" ID="customValidatorMail" ControlToValidate="txtMail" OnServerValidate="customValidatorMail_ServerValidate" ValidationGroup="GuardarUsuario" ErrorMessage="El correo electrónico es inválido" />
                                            <asp:CustomValidator runat="server" ID="customValidatorDomicilio" ControlToValidate="txtDomicilio" OnServerValidate="customValidatorDomicilio_ServerValidate" ValidationGroup="GuardarUsuario" ErrorMessage="El domicilio es inválido" />
                                            <asp:CustomValidator runat="server" ID="customValidatorPassword" ControlToValidate="txtPassword" OnServerValidate="customValidatorPassword_ServerValidate" ValidationGroup="GuardarUsuario" ErrorMessage="La contraseña es inválida" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                </ContentTemplate>
                            </asp:UpdatePanel>


                    </div>

        </section>
    </main>

</asp:Content>
