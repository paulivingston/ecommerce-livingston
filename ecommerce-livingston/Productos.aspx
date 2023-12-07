<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="ecommerce_livingston.Productos" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5 pt-5 min-vh-100" >
        <h4 class="mb-5 text-center fs-3 text-bg-dark">Catalogo</h4>
        <div class="row g-0">

            <div class="col-md-3 bg-light border mb-3 p-1">
                <div class="p-5">
                    <asp:DropDownList id="ddlFiltroCategoria" CssClass="form-select h-1 mb-4" runat="server" AutoPostBack="false"></asp:DropDownList>
                    <asp:DropDownList id="ddlFiltroMarca" CssClass="form-select h-1 mb-4" runat="server" AutoPostBack="false"></asp:DropDownList>
                    <asp:Button CssClass="btn btn-primary btn-sm mb-5" Text="Aplicar" runat="server" id="btnFiltro" OnClick="btnFiltro_Click" />
                    <asp:Button CssClass="btn btn-info btn-sm mb-5" Text="Eliminar Filtros" runat="server" id="btnEliminarFilros" OnClick="btnEliminarFilros_Click" />
                </div>
            </div>

            <div class="col-md-1"></div>
            <div class="col-md-8 ">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:Repeater ID="repArticulos" runat="server">
                            <ItemTemplate>
                                <div class="card mb-3 ms-4" style="max-width: 740px;">
                                    <div class="row g-0 m-4">
                                        <div class="col-md-4">
                                            <img src="<%#Eval("ImagenUrl") %>" class="img-fluid rounded-start" alt="...">
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-body ">
                                                <h5 class="card-title fs-3"><%#Eval("Nombre") %></h5>
                                                <p class="card-text text-primary fs-4 mt-4">$ <%#Eval("Precio")%></p>
                                                <asp:Button Text="🛒  Agregar" type="button" runat="server" ID="btnAgregar" CssClass="btn btn-warning mt-4" CommandArgument='<%# Eval("Id")%>' OnClick="btnAgregar_Click" />
                                                <asp:Button Text="ℹ Detalles" type="button" runat="server" ID="btnDetalles" CssClass="btn btn-primary mt-4" CommandArgument='<%# Eval("Id")%>' OnClick="btnDetalles_Click" />
                                               
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <div class="container text-center bg-white border rounded-3 p-3">
        <div class="row aling-items-center">
            <div class="col">
                <div>
                    <p><a href='<%:Request.UrlReferrer != null? Request.UrlReferrer.ToString() : "/" %>' class="link-dark">Volver</a></p>
                </div>
                <div>
                    <p><a href="Default.aspx" class="link-dark">Volver al inicio</a></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>