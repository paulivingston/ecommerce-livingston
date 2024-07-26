<%@ Page Language="C#" Title="Mis Pedidos" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisPedidos.aspx.cs" Inherits="ecommerce_livingston.MisPedidos" EnableEventValidation="false" %>


<asp:Content ID="MisPedidos" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="container-lg min-vh-100">

            <%-- cuando NO tiene pedidos --%>
        <div class="container-fluid min-vh-100 d-flex justify-content-center align-items-center" id="divSinPedidos" runat="server">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-sm-12 text-center">
                        <img src="/Content/img/shopping-bag.png" class="img-fluid mb-4 mr-3" width="300px">
                        <h3><strong class="fs-1">Todavía no tienes pedidos realizados</strong></h3>
                        <h4 class="fs-3 mt-2">¿Qué estás esperando?</h4>
                        <a href="Productos.aspx" class="btn btn-info fs-5 m-3 mt-5" data-abc="true">Encontralos los mejores lentes acá</a>
                    </div>
                </div>
            </div>
        </div>

            <asp:Panel ID="panelPedidosUsuario" runat="server" Visible="false">
                            
                <%-- filtros --%>
                <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2" style="margin-top: 100px;" runat="server"><strong>Mis Pedidos</strong></h1>
                <div class="row d-flex justify-content-center align-items-center pb-3 pt-2" style="background-color: #cec3e2;" runat="server">
                    <div class="col-1">
                        <h2>Filtros:</h2>
                    </div>
                    <div class="col-2">
                        <div class="dropend">
                            <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Ordenar
                            </button>
                            <ul class="dropdown-menu">
                                <li>
                                    <asp:Button ID="btnOrdenarMayorPrecioPedidos" OnClick="btnOrdenarPrecioPedidos_Click" CommandName="MAYOR" CssClass="btn" Text="Mayor precio" runat="server" />
                                </li>
                                <li>
                                    <asp:Button ID="btnOrdenarMenorPrecioPedidos" OnClick="btnOrdenarPrecioPedidos_Click" CommandName="MENOR" CssClass="btn" Text="Menor precio" runat="server" />
                                </li>
                            </ul>
                            <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Estado
                            </button>
                            <ul class="dropdown-menu">
                                <li>
                                    <asp:Button OnClick="btnEstadosPedidosFiltros_Click" CssClass="btn" Text="Iniciado" CommandName="btnIniciado" runat="server" />
                                </li>
                                <li>
                                    <asp:Button OnClick="btnEstadosPedidosFiltros_Click" CssClass="btn" Text="Finalizado" CommandName="btnTerminado" runat="server" />
                                </li>
                                <li>
                                    <asp:Button OnClick="btnEstadosPedidosFiltros_Click" CssClass="btn" Text="Cancelado" CommandName="btnCancelado" runat="server" />
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-1">
                        <label for="txtFiltroIdPedido_Pedido" class="form-label">Id Pedido</label>
                        <asp:TextBox ID="txtFiltroIdPedido_Pedido" Text="Id Pedido" TextMode="Number" CssClass="form-control" runat="server" />
                    </div>
                    <div class="col-2">
                        <label for="txtFiltroFechaDesde" class="form-label">Desde:</label>
                        <asp:TextBox ID="txtFiltroFechaDesde" TextMode="Date" CssClass="form-control" placeholder="" runat="server" />
                    </div>
                    <div class="col-2">
                        <label for="txtFiltroFechaHasta" class="form-label">Hasta:</label>
                        <asp:TextBox ID="txtFiltroFechaHasta" TextMode="Date" CssClass="form-control" placeholder="" runat="server" />
                    </div>
                    <div class="col-3">
                        <div class="row text-center">
                            <div class="col">
                                <asp:Button ID="btnFiltrarPedidos" OnClick="btnFiltrosPersonalizados_Click" Text="Filtrar" CssClass="btn btn-dark" runat="server" />
                            </div>
                            <div class="col">
                                <asp:Button ID="btnLimpiarFiltrosPedidos" OnClick="btnLimpiarFiltrosPedidos_Click" Text="Limpiar Filtros" CssClass="btn btn-dark" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>

                <%-- tabla --%>
                <asp:GridView ID="dgvPedidosUsuario" runat="server" CssClass="table table-striped table-bordered mt-5 text-center" AutoGenerateColumns="false">
                    <Columns>
                    <asp:TemplateField HeaderText="ID Pedido">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("IdPedido") %>' CssClass="mt-3"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cantidad de items">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Cantidad") %>' CssClass="mt-3"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fecha">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Fecha", "{0:dd/MM/yyyy}") %>' CssClass="mt-3"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Estado") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Direccion de entrega">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("DireccionEntrega") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Descuento">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# Eval("Descuento") %>' CssClass="mt-3"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Monto Total">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%# string.Format("{0:C2}", Eval("precioTotal")) %>'  CssClass="mt-3"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cancelar">
                        <ItemTemplate>
                            <asp:Button Text="❌" CssClass="btn btn-outline-danger mt-2" ID="btnCancelarPedido" CommandName="Cancelar" CommandArgument='<%#Eval("IdPedido") %>' OnClick="btnCancelarTerminarPedido" runat="server" OnClientClick="return confirm('¿Desea cancelar el pedido seleccionado?');" Visible='<%# Eval("Estado").ToString() == "INICIADO" ? true :false %>'/>
                            <asp:Button Text="❌" CssClass="btn btn-danger mt-2" ID="btnPedidoCancelado" runat="server" Visible='<%# Eval("Estado").ToString() == "CANCELADO" ? true :false %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Detalle">
                        <ItemTemplate>
                            <asp:Button Text="👁" CssClass="btn btn-outline-info mt-2" ID="ibtModificarPedido" CommandName="editar_btn" CommandArgument='<%#Eval("IdPedido") %>' OnClick="ibtModificarPedido_Click" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                </asp:GridView>
            </asp:Panel>
            
                        
            <%-- panel editar pedidos --%>
            <div class="row d-flex my-5" id="seccionVerPedidoUsuario" visible="false" runat="server">
                <div class="card rounded-4 mt-5" style="background-color: #cec3e2;" runat="server">
                    <div class=" card-header text-center">
                        <asp:Label CssClass="h1" ID="lblModificarPedido"  runat="server"/>
                    </div>  
                    <div class="row p-4">
                        <div class="col-6 mt-3">
                            <label for="txtIdUsuarioModificarPedido" class="form-label">Numero de Usuario<span class="text-danger">*</span></label>
                            <asp:TextBox CssClass="form-control" ID="txtIdUsuarioModificarPedido" runat="server" disabled/>
                        </div>
                        <div class="col-6 mt-3">
                            <label for="txtEstadoModificarPedido" class="form-label">Estado <span class="text-danger">*</span></label>
                            <asp:TextBox CssClass="form-control" ID="txtEstadoModificarPedido" placeholder="Pendiente" runat="server" disabled/>
                        </div>
                        <div class="col-6 mt-3">
                            <div class="col">
                                <label for="txtCantidadTotalModificarPedido" class="form-label">Cantidad total</label>
                                <asp:TextBox CssClass="form-control" ID="txtCantidadTotalModificarPedido" placeholder="Cantidad Total" runat="server" disabled/>
                            </div>
                        </div>
                        <div class="col-6 mt-3">
                            <label for="txtFechaModificarPedido" class="form-label">Fecha de Inicio</label>
                            <asp:TextBox CssClass="form-control" ID="txtFechaModificarPedido" placeholder="Fecha de Inicio" runat="server" disabled/>
                        </div>
                        <div class="col-6 mt-3">
                            <label for="txtDescuentoModificarPedido" class="form-label" >Descuento</label>
                            <asp:TextBox CssClass="form-control" ID="txtDescuentoModificarPedido" placeholder="Descuento" runat="server" disabled/>
                        </div>
                        <div class="col-6 mt-3">
                            <label for="txtTotalModificarPedido" class="form-label">Total</label>
                            <asp:TextBox CssClass="form-control" ID="txtTotalModificarPedido" placeholder="Total" runat="server" disabled/>
                        </div>
                        <div id="lblAlertUsuarioNoEncontrado" class="row justify-content-center" runat="server" visible="false">
                            <div class="alert alert-warning align-items-center col-10 mt-3" role="alert">
                                <p>El usuario no encontrado en la base de datos, se debe crear un nuevo usuario para poder registrar el pedido.</p>
                            </div>
                        </div>

                        <div class="col-12 mt-3">
                            <div class="d-flex justify-content-center align-items-center">
                                <asp:Button Text="Volver a Mis Pedidos" CssClass="btn btn-dark text-light mt-3 mb-3 fs-6" ID="btnVolverMisPedidos" CommandName="btnVolverMisPedidos_Click" OnClick="btnVolverMisPedidos_Click" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container text-center mt-5">                                      
                    <div class="row d-flex justify-content-center aling-items-center">
                        <div class="col-4 align-self-center border rounded-3 p-3" style="background-color: #cec3e2;" >
                            <h4>Importe: 
                                <span class="badge bg-secondary">
                                    <asp:Label CssClass="h4" ID="txtNuevoTotal"  runat="server"/>
                                </span>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>

            <%-- panel articulos por pedido --%>
            <asp:GridView ID="dgvArticulosPedido" AutoGenerateColumns="false" CssClass="table table-striped table-bordered mt-5" runat="server">
                <Columns>

                    <asp:BoundField HeaderText="Id Articulo" DataField="Id" />
                    <asp:BoundField HeaderText="Articulo" DataField="Nombre"/>
                    <asp:BoundField HeaderText="Descripcion" DataField="Descripcion"/>
                    <asp:BoundField HeaderText="Marca" DataField="Marca"/>
                    <asp:BoundField HeaderText="Categoria" DataField="Categoria" />

                    <asp:TemplateField HeaderText="Precio Unitario">
                        <ItemTemplate>
                            <asp:Label Text='<%#string.Format("{0:C2}", Eval("Precio"))%>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Precio Total">
                        <ItemTemplate>
                            <asp:Label Text='<%#string.Format("{0:C2}", Convert.ToInt32(Eval("Precio"))*Convert.ToInt32(Eval("Cantidad")))%>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" />

                </Columns>
            </asp:GridView>
        </section>
    </main>

</asp:Content>