﻿<%@ Page Title="Error" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="ecommerce_livingston.Error" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container text-center min-vh-100">
        <div class="row" style="margin-top: 100px">
            <div class="col">
                <asp:Label Text="" ID="lblMensaje" runat="server" />
            </div>
            <div class="col">
                <asp:Label ID="lblErrorFuente" runat="server" />
            </div>
        </div>
        <div class="row">
            <div class="col">
                <asp:Label ID="lblErrorPath" runat="server" />
            </div>
        </div>
        <div class="row">
            <div class="col">
                <asp:Label ID="lblErrorCompleto" runat="server" />
            </div>
        </div>
        <div class="row">
            <div class="col">
                <h4>
                    <asp:Label ID="lblMensajeError" runat="server" /></h4>
            </div>
            <div class="row bg-white">
                <div class="col">
                    <div>
                        <p>
                            <a href='<%:Request.UrlReferrer != null? Request.UrlReferrer.ToString() : "#" %>' class="link-dark">Volver</a>
                        </p>
                    </div>
                    <div>
                        <p><a href="Default.aspx" class="link-dark">Volver al inicio</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>