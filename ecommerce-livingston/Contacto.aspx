<%@ Page Title="Contacto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contacto.aspx.cs" Inherits="ecommerce_livingston.Contacto" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your contact page.</h3>
    
    <div class="form row g-3">
      <div class="col-12">
        <label for="inputNombre" class="form-label">Nombre</label>
        <input type="email" class="form-control" id="inputNombre">
      </div>
      <div class="col-12">
        <label for="inputApellido" class="form-label">Apellido</label>
        <input type="text" class="form-control" id="inputApellido">
      </div>
      <div class="col-12">
        <label for="inputEmail" class="form-label">Email</label>
        <input type="email" class="form-control" id="inputEmail">
      </div>
      <div class="col-12">
        <label for="inputTelefono" class="form-label">Telefono</label>
        <input type="text" class="form-control" id="inputTelefono">
      </div>
      <div class="col-12">
        <button type="submit" class="btn btn-primary">Enviar</button>
      </div>
    </div>

</asp:Content>
