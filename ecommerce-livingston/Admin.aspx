<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ecommerce_livingston.Admin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid" >
        <div class="row flex-nowrap">
            
            <!-- menu admin -->
             <div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
                <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">
                    <a href="/" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none"></a>
                    <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start mt-5" id="menu">

                    </ul>
                </div>
            </div>

            <div class="col-md-8 mt-5" background-image: url(https://img3.wallspic.com/crops/9/3/0/4/6/164039/164039-banner_de_contraccion_de_la_galaxia-contraccion_nerviosa-banner_web-streaming_de_medios_de_comunicacion-gamer-3840x2160.png)">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>

                        <!-- estadisticas -->
                        <div class="container-fluid p-0" style="margin-top:100px;" runat="server" id="divEstadisticas">
                            <h1 class="h3 rounded-3 mb-5 pt-3 pb-3 mt-5 fs-1 text-center text-bg-dark text-light" ><strong >Estadísticas generales</strong></h1>
                            <div class="row">
                                <div class="col-12 d-flex mt-5" >
                                    <div class="w-100">
                                        <div class="row">
                                            <div class="col-3 ">
                                                <div class="card col bg-primary text-light mb-5">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Pedidos realizados</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-primary">
                                                                    <i class="align-middle" data-feather="truck"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblCantPedidos" CssClass="fs-1 mb-2" runat="server" />
                                                        </div>
                                                        <div class="mb-0 badge bg-light fs-6">
                                                            <asp:Label ID="lblCantidadPedidosMesAnterior" runat="server" />
                                                            <span class="text-muted">Respecto al mes pasado</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                                
                        <!-- falta pedidos, recaudacion? usuarios? -->
                                
                        <!-- listado pedidos -->
                        <div class="row">
                                <div class="col-12 d-flex">
                                    <div class="card flex-fill">
                                        <div class="card-header bg-warning text-center">
                                            <h5 class="card-title mb-0 fs-3 fw-bold pb-2 pt-2">Pedidos Realizados</h5>
                                        </div>
                                        <table class="table table-hover border-warning my-0 text-center">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>ID Pedido</th>
                                                    <th>ID Cliente</th>
                                                    <th>Nombre</th>
                                                    <th>Fecha de compra</th>
                                                    <th>Domicilio de entrega</th>
                                                    <th>Estado</th>
                                                    <th>Precio Facturado</th>
                                                    <th>Ir</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptListaPedidosPanel" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="d-none d-md-table-cell"><%# Eval("IdPedido") %></td>
                                                            <td class="d-none d-md-table-cell"><%# Eval("IdUsuario") %></td>
                                                            <td class="d-none d-xl-table-cell"><%# Eval("Usuario") %></td>
                                                            <td class="d-none d-md-table-cell"><%# Eval("Fecha") %></td>
                                                            <td class="d-none d-xl-table-cell"><%# Eval("DireccionEntrega") %></td>
                                                            <td><asp:Label ID="lblEstadoPedidoPanel" Text='<%# Eval("Estado") %>' runat="server" /></td>
                                                            <td class="d-none d-md-table-cell"><%# string.Format("{0:C2}", Eval("precioTotal")) %></td>
                                                            <td class="text-center">
                                                                <asp:Button ID="btnVerDetallePedido" CssClass="btn btn-secondary" Text="Ver detalle" OnClick="btnVerDetallePedido_Click" CommandArgument='<%# Eval("IdPedido") %>' runat="server" />
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- listado usuarios -->
                        <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2" style="margin-top: 100px;" id="lblAdministracionUsuarios" visible="false" runat="server"><strong>Administración de Usuarios</strong></h1>
                        <div class="row d-flex justify-content-center align-items-center bg-warning pb-2 pt-1"  id="filtrosUsuarios" visible="false" runat="server">
                            <div class="col-2">
                                <h2>Filtros:</h2>
                            </div>
                            <div class="col-2">
                                <div class="dropend">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Estado</button>
                                    <ul class="dropdown-menu">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <li><asp:Button CssClass="btn" Text="ACTIVO" CommandName="ACTIVO" OnClick="btnFiltrarEstadoUsuarios_Click" runat="server" /></li>
                                                <li><asp:Button CssClass="btn" Text="INACTIVO" CommandName="INACTIVO" OnClick="btnFiltrarEstadoUsuarios_Click" runat="server" /></li>
                                                </ItemTemplate>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-1">
                                <label for="txtFiltroIdUser_Pedido" class="form-label">Id Usuario</label>
                                <asp:TextBox ID="txtIdFiltro_Usuario" TextMode="Number" CssClass="form-control" runat="server"/>
                            </div>
                            <div class="col-1">
                                <label for="txtFiltroIdPedido_Pedido" class="form-label">DNI</label>
                                <asp:TextBox ID="txtDNIFiltro_Usuario" Text="Id Pedido" TextMode="Number" CssClass="form-control" runat="server" />
                            </div>
                            <div class="col-1">
                                <label for="txtFiltroNombreUsuario_Pedido" class="form-label">Nombre</label>
                                <asp:TextBox ID="txtNombreFiltro_Usuario" placeholder="Nombre" CssClass="form-control" runat="server" />
                            </div>
                            <div class="col-1">
                                <label for="txtApellidoFiltro_Usuario" class="form-label">Apellido</label>
                                <asp:TextBox ID="txtApellidoFiltro_Usuario" placeholder="Apellido" CssClass="form-control" runat="server" />
                            </div>
                            <div class="col-2">
                                <div class="row">
                                    <div class="col">
                                        <asp:Button ID="btnFiltrarUsuarios" Text="Filtrar" CssClass="btn btn-dark" OnClick="btnFiltrarUsuarios_Click" runat="server" />
                                    </div>
                                    <div class="col">
                                        <asp:Button ID="btnLimpiarFiltrosUsuarios" Text="Limpiar Filtros" CssClass="btn btn-dark" OnClick="btnLimpiarFiltrosUsuarios_Click" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:GridView ID="dgvAdminUsuario" runat="server" CssClass="table table-striped mt-5 " AutoGenerateColumns="False">
                           
                        </asp:GridView>
                        
                        <!-- agregar controles usuarios -->
                        <asp:UpdatePanel ID="updatePanelModificarUsuario" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col py-3"></div>
        </div>
    </div>
    
</asp:Content>