﻿<%@ Page Title="Carrito de Compras" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="ecommerce_livingston.Carrito" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main aria-labelledby="title">
        <%-- cuando NO tiene items --%>
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

        <!-- cuando SI tiene items -->
        <div class="container" runat="server" id="divCarrito">
            <div class="row">
                <div class="col">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="container py-5 mt-5">
                                <div class="row d-flex justify-content-center my-4">
                                    <div class="col-md-8">
                                        <div class="card mb-4">
                                            <div class="card-header py-3 bg-info text-light d-flex">
                                                <h5 class="mb-0 ">Carrito de compras</h5>
                                            </div>
                                            <asp:Repeater runat="server" ID="dgvCarrito">
                                                <ItemTemplate>
                                                    <div class="card-body mt-4">
                                                        <div class="row">
                                                            <div class="col-lg-3 col-md-12 mb-4 mb-lg-0">
                                                                <img src="<%# Eval("ImagenUrl") %>"
                                                                    class="w-100" alt="..." />
                                                            </div>

                                                            <div class="col-lg-5 col-md-6 mb-4 mb-lg-0">
                                                                <p><strong><%# Eval("Nombre") %></strong></p>
                                                                <p class="text-start ">
                                                                    <strong><%# string.Format("{0:C2}", Eval("precio")) %></strong>
                                                                </p>
                                                                <asp:Button ID="btnEliminar" CssClass="btn btn-outline-danger mt-5" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="btnEliminarFila" OnClick="btnEliminar_Click" Text="❌" Width="45px" />
                                                                <asp:Button ID="btnDetalles" CssClass="btn btn-outline-info mt-5" runat="server" CommandArgument='<%# Eval("Id")%>' OnClick="btnDetalles_Click" Text="ℹ" Width="45px"/>
                                                            </div>

                                                            <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
                                                                <div class="d-flex mb-4 justify-content-around" style="max-width: 300px">
                                                                    <label for="lblCantidad" class="m-2">Cantidad: </label>
                                                                    <asp:Button ID="btnRestar" runat="server" CommandArgument='<%#Eval("Id")%>' OnClick="btnRestar_Click" CommandName="btnRestar" Height="35px" Text="➖" Width="35px" />
                                                                    <asp:Label runat="server" ID="lblCantidad" Text='<%# Eval("Cantidad") %>' CssClass="ms-3 me-3 mt-1 fs-5"></asp:Label>
                                                                    <asp:Button ID="btnSumar"  runat="server" CommandArgument='<%#Eval("Id")%>' OnClick="btnSumar_Click" CommandName="btnSumar" Height="35px" Text="➕" Width="35px" />
                                                                </div>
                                                                <p class="m-5 fs-5 text-center">
                                                                    Total
                                                                    <label class="fs-5 text-primary"><%# Eval("TotalParcial") %></label>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <hr class="" />
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card mb-4">
                                            <div class="card-header py-3 bg-info text-light">
                                                <h5 class="mb-0">Resumen</h5>
                                            </div>
                                            <div class="card-body">
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">Total artículos
                                                          <span><strong class="">$<%:TotalAcumulado.ToString() %></strong></span>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">Envío
                                                         <span>Gratis</span>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                                            Descuentos
                                                         <span>0%</span>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
                                                        <div>
                                                            <strong>Monto total</strong>
                                                            <strong><p class="mb-0">(IVA Incluido)</p></strong>
                                                        </div>
                                                        <span><strong class="fs-5">$<%:TotalAcumulado.ToString() %></strong></span>
                                                    </li>
                                                </ul>
                                                
                                                <div class="d-flex justify-content-end">
                                                    <asp:Button Text="Cancelar" ID="btnEliminarListaCarrito" CssClass="btn btn-secondary ms-2" OnClick="btnEliminarListaCarrito_Click" runat="server" />
                                                    <button type="button" class="btn btn-success btn-block ms-2" id="btnContinuarCompra" onserverclick="btnContinuarCompra_Click" runat="server">
                                                        Continuar compra
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <!-- resumen compra -->
        <div class="container" runat="server" id="divResumen">
            <div class="row">
                <div class="col">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="container py-5 mt-5">
                                <div class="row d-flex justify-content-center my-4">
                                    <div class="col-md-12">
                                        <div class="card mb-4">
                                            <div class="card-header py-3 bg-info">
                                                <h4 class="mb-0 "><strong>Finalizar reserva</strong></h4>
                                            </div>
                                            <table class="table">
                                                <thead class="fs-5">
                                                    <tr class="text-center">
                                                        <th scope="col">Imágen</th>
                                                        <th scope="col">Producto</th>
                                                        <th scope="col">Cantidad</th>
                                                        <th scope="col">Precio</th>
                                                        <th scope="col">Total</th>
                                                    </tr>
                                                </thead>
                                                <asp:Repeater runat="server" ID="rptCarrito">
                                                    <ItemTemplate>
                                                        <tbody>
                                                            <tr class="text-center fs-5 ">
                                                                <td class=""><img src="<%# Eval("ImagenUrl") %>" class="w-25" alt="img_producto" /></td>
                                                                <td class="pt-5"><%# Eval("Nombre") %></td>
                                                                <td class="pt-5"><%# Eval("Cantidad") %></td>
                                                                <td class="pt-5"><%# string.Format("{0:C2}", Eval("precio")) %></td>
                                                                <td class="pt-5"><%# Eval("TotalParcial") %></td>
                                                            </tr>
                                                        </tbody>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </table>
                                            <div class="card-header py-3 d-flex justify-content-end">
                                                <h4 class="mb-0 "><strong>Precio total:  <span class="text-primary ms-5">$<%:TotalAcumulado.ToString() %></span></strong></h4>
                                            </div>
                                        </div>
                                        <div id="divBtnConfirmarReserva" runat="server">
                                            <div class="card text-center mt-5 justify-content-center">
                                                <asp:Button ID="btnConfirmarPedido" Text="Confirmar Reserva" CssClass="btn fs-3 bg-black text-light p-3" OnClientClick="return confirm('¿Seguro de Confirmar?');" OnClick="btnConfirmarPedido_Click" runat="server" />
                                            </div>
                                        </div>
                                    </div>

                                    <!-- login -->
                                    <div class="col-12 card text-center mt-5" id="divRegistroOLoginNecesario" runat="server">
                                        <p class="fs-4 card-title pt-4 pb-1">
                                            <strong>Para completar la compra necesitas 
                                            <button type="button" class="btn fs-4 bg-black text-light p-1" data-bs-toggle="modal" data-bs-target="#modalLogin"><b>iniciar sesión.</b></button>
                                                No tenes una cuenta?
                                            <a href="Registro.aspx?text=registroCompra" class="link-secondary text-decoration-none">
                                                <button type="button" class="btn btn-success fs-5 p-1" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="bi bi-person-add">Crear cuenta</i></button>
                                            </a>
                                            </strong>
                                        </p>
                                    </div>

                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

    </main>



</asp:Content>

