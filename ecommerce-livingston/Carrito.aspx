<%@ Page Title="Carrito de Compras" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="ecommerce_livingston.Carrito" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main aria-labelledby="title">
        <%--cuando está vacio--%>
        <div class="container-fluid min-vh-100 d-flex justify-content-center align-items-center" id="divCarritoVacio" runat="server">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-sm-12 text-center">
                        <img src="/Content/img/cart-shopping-solid.png" class="img-fluid mb-4 mr-3">
                        <h3><strong class="fs-1">Tu carrito esta vacío</strong></h3>
                        <h4 class="fs-3">¿Todavía no encontraste los lentes para vos?</h4>
                        <a href="Productos.aspx" class="btn btn-info fs-5 m-3 mt-5" data-abc="true">Encontralos acá</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

