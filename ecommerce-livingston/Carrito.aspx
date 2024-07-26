 <%@ Page Title="Carrito de Compras" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Carrito.aspx.cs" Inherits="ecommerce_livingston.Carrito" %>


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
                                                <div class="input-group mb-3">
                                                    <asp:TextBox ID="txtCuponDescuento" type="text" class="form-control" placeholder="Código de descuento" aria-label="Código de descuento" aria-describedby="button-addon2" runat="server" />
                                                    <asp:Button Text="Aplicar" CssClass="btn btn-outline-secondary" ID="btnAplicarDescuento" OnClick="btnAplicarDescuento_Click" runat="server" />
                                                </div>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">Total artículos
                                                          <span><strong class="">$<%:subtotal.ToString() %></strong></span>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">Envío
                                                         <span>Gratis</span>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                                            Descuentos
                                                         <span><%:descuento.ToString() %>%</span>
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
                                                    <asp:Button Text="Cancelar" ID="btnEliminarListaCarrito" CssClass="btn btn-secondary ms-2" OnClientClick="return confirm('¿Seguro quiere cancelar la compra?');" OnClick="btnEliminarListaCarrito_Click" runat="server" />
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
                                                <h4 class="mb-0 "><strong>Resumen de Compra</strong></h4>
                                            </div>
                                            <table class="table">
                                                <thead class="fs-5">
                                                    <tr class="text-center">
                                                        <th scope="col">Imagen</th>
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
                                                                <td class="col-4"><img src="<%# Eval("ImagenUrl") %>" class="w-25" alt="img_producto" /></td>
                                                                <td class="pt-3 col-3"><%# Eval("Nombre") %></td>
                                                                <td class="pt-3 col-2"><%# Eval("Cantidad") %></td>
                                                                <td class="pt-2"><%# string.Format("{0:C2}", Eval("precio")) %></td>
                                                                <td class="pt-2"><%# Eval("TotalParcial") %></td>
                                                            </tr>
                                                        </tbody>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </table>
                                            <div class="card-header py-3 d-flex justify-content-end">
                                                <h5 class="mb-0 "><strong>Descuento Aplicado:  <span class="text-primary ms-5"><%:descuento.ToString() %>%</span></strong></h5>
                                            </div>
                                            <div class="card-header py-3 d-flex justify-content-end">
                                                <h4 class="mb-0 "><strong>Precio total:  <span class="text-primary ms-5">$<%:TotalAcumulado.ToString() %></span></strong></h4>
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

                                    <%--Metodos de pago--%>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div id="divMediosDePago" runat="server" style="margin-top: 100px; margin-bottom: 200px;">
                                                <h1>Elija un metodo de pago</h1>
                                                <div class="accordion mt-5" id="accordionPago">
                                                    <%--<div class="accordion-item ">
                                                        <h2 class="accordion-header">
                                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                                Mercado Pago
                                                            </button>
                                                        </h2>
                                                        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionPago">
                                                            <div class="accordion-body text-center">
                                                                <img src="https://logotipoz.com/wp-content/uploads/2021/10/version-horizontal-large-logo-mercado-pago.webp" alt="logo-MP" class="img-fluid w-25" />
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <div class="accordion-item">
                                                        <h2 class="accordion-header">
                                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDebito" aria-expanded="false" aria-controls="collapseDebito">
                                                                Tarjeta de débito
                                                            </button>
                                                        </h2>
                                                        <div id="collapseDebito" class="accordion-collapse collapse show" data-bs-parent="#accordionPago">
                                                            <div class="accordion-body">
                                                                <div class="row gy-3">
                                                                    <div class="col-md-6">
                                                                        <label for="nombreDebito" class="form-label">Nombre del titular</label>
                                                                        <input type="text" class="form-control" id="nombreDebito" placeholder="" runat="server">
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <label for="numeroDebito" class="form-label">Número de tarjeta</label>
                                                                        <input type="number" class="form-control" id="numeroDebito" placeholder="" runat="server">
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <label for="fechaVenDebito" class="form-label">Fecha de vencimiento</label>
                                                                        <input type="text" class="form-control" id="fechaVenDebito" placeholder="" runat="server">
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <label for="codSegDebito" class="form-label">CVV</label>
                                                                        <input type="number" class="form-control" id="codSegDebito" placeholder="" runat="server">
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label for="dniDebito" class="form-label">Número de documento</label>
                                                                        <input type="number" class="form-control" id="dniDebito" placeholder="" runat="server">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="accordion-item">
                                                        <h2 class="accordion-header">
                                                            <button id="btnCredito" class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCredito" aria-expanded="false" aria-controls="collapseCredito" onclick="MostrarCredito();">
                                                                Tarjeta de crédito
                                                            </button>
                                                        </h2>
                                                        <div id="collapseCredito" class="accordion-collapse collapse" data-bs-parent="#accordionPago">
                                                            <div class="accordion-body">
                                                                <div class="row gy-3">
                                                                    <div class="col-md-6">
                                                                        <label for="nombreCredito" class="form-label">Nombre del titular</label>
                                                                        <input type="text" class="form-control" id="nombreCredito" placeholder="" runat="server">
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <label for="numeroCredito" class="form-label">Número de tarjeta</label>
                                                                        <input type="number" class="form-control" id="numeroCredito" placeholder="" runat="server">
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <label for="fechaVenCredito" class="form-label">Fecha de vencimiento</label>
                                                                        <input type="text" class="form-control" id="fechaVenCredito" placeholder="" runat="server">
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <label for="codSegCredito" class="form-label">CVV</label>
                                                                        <input type="number" class="form-control" id="codSegCredito" placeholder="" runat="server">
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label for="dniCredito" class="form-label">Número de documento</label>
                                                                        <input type="number" class="form-control" id="dniCredito" placeholder="" runat="server">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="text-end">
                                                    <asp:Button ID="BtnPagar" Text="Pagar" CssClass="btn fs-3 bg-primary text-light p-3 mt-4 px-5" OnClientClick="return confirm('¿Seguro quiere realizar la compra?');" OnClick="btnConfirmarPedido_Click" runat="server" />
                                                </div>
                                            </div>
                                           
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                    
                                    
                                    <!-- Fin metodos de pago -->

                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

    </main>





</asp:Content>

