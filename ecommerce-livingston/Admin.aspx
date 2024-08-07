﻿<%@ Page Title="Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ecommerce_livingston.Admin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid" >
        <div class="row flex-nowrap">
            
            <!-- menu admin -->
             <div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0" style="background-color: #cec3e2;">
                <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">
                    <a href="/" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none"></a>
                    <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start mt-5 text-black" id="menu">
                        <li class="nav-item mt-5">
                            <a href="Admin.aspx" class="nav-link align-middle px-0 text-black">
                                <i class="fs-3 bi-house text-black"></i><span class="ms-1 d-none d-sm-inline fs-5 ms-2">Inicio</span>
                            </a>
                        </li>
                        <li> <!-- pedidos -->
                            <a href="#submenu2" data-bs-toggle="collapse" class="nav-link px-0 align-middle text-black">
                                <i class="fs-3 bi-table text-warning"></i><span class="ms-1 d-none d-sm-inline fs-5 ms-2">Pedidos</span></a>
                            <ul class="collapse nav flex-column ms-1 " id="submenu2" data-bs-parent="#menu">
                                <li class="w-100 ">
                                    <asp:Button ID="btnPedidosTodos" Text="Todos los Pedidos" CssClass="nav-link px-0 d-none d-sm-inline text-black ms-4" OnClick="btnPedidosTodos_Click" runat="server" />
                                </li>
                                <li class="w-100 ">
                                    <asp:Button ID="btnDescuentos" Text="Cupones de Descuento" CssClass="nav-link px-0 d-none d-sm-inline text-black ms-4" OnClick="btnDescuentos_Click" runat="server" />
                                </li>
                            </ul>
                        </li>
                        <li> <!-- articulos -->
                            <a href="#submenu3" data-bs-toggle="collapse" class="nav-link px-0 align-middle text-black">
                                <i class="fs-3 bi-grid text-warning"></i><span class="ms-1 d-none d-sm-inline fs-5 ms-2">Artículos</span> </a>
                            <ul class="collapse nav flex-column ms-1 text-black" id="submenu3" data-bs-parent="#menu">
                                <li class="w-100 ">
                                    <asp:Button ID="btnArticulosTodos" Text="Todos los Articulos" CssClass="nav-link px-0 d-none d-sm-inline ms-4 text-black" OnClick="btnArticulosTodos_Click" runat="server" />
                                </li>
                                <li class="w-100">
                                    <asp:Button ID="btnNuevoArticulo" Text="Nuevo Articulo" CssClass="nav-link px-0 d-none d-sm-inline ms-4 text-black" OnClick="btnNuevoArticulo_Click" runat="server" />
                                </li>
                                <li>
                                    <asp:Button ID="btnMarcas" Text="Marcas" CssClass="nav-link px-0 d-none d-sm-inline ms-4 text-black" OnClick="btnMarcas_Click" runat="server" />
                                </li>
                                <li>
                                    <asp:Button ID="btnCategorias" Text="Categorias" CssClass="nav-link px-0 d-none d-sm-inline ms-4 text-black" OnClick="btnCategorias_Click" runat="server" />
                                </li>
                            </ul>
                        </li> <!-- usuarios -->
                        <li>
                            <a href="#submenu4" data-bs-toggle="collapse" class="nav-link px-0 align-middle text-black">
                                <i class="fs-3 bi-people text-warning"></i><span class="ms-1 d-none d-sm-inline fs-5 ms-2">Usuarios</span> </a>
                            <ul class="collapse nav flex-column ms-1 " id="submenu4" data-bs-parent="#menu">
                                <li class="w-100 ">
                                    <asp:Button ID="btnUsuariosTodos" Text="Todos los Usuarios" CssClass="nav-link px-0 d-none d-sm-inline ms-4 text-black" OnClick="btnUsuariosTodos_Click" runat="server" />
                                </li>
                                <li>
                                    <asp:Button Text="Crear Nuevo Usuario" ID="btnAgregarNuevoUsuario" OnClick="btnAgregarNuevoUsuario_Click" CssClass="nav-link px-0 d-none d-sm-inline text-black ms-4" runat="server" />
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>


            <div class="col-md-9 mt-5" style="margin-left:40px">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>

                        <%-- ESTADISTICAS --%>
                        
                        <div class="container-fluid p-0" style="margin-top:100px;" runat="server" id="divEstadisticas">
                            <h1 class="h3 rounded-3 mb-5 pt-3 pb-3 mt-5 fs-1 text-center text-bg-dark text-light" ><strong >Estadísticas</strong></h1>
                            <div class="row">
                                <div class="col-12 d-flex mt-5" >
                                    <div class="w-100">
                                        <div class="row"> <!-- pedidos -->
                                            <div class="col-3"> 
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Pedidos realizados</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="truck"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblCantPedidos" CssClass="fs-1 mb-2" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3"> 
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Pedidos completados</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="users"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblPedidosCompletados" CssClass="fs-1" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Pedidos pendientes</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="dollar-sign"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblPedidosPendientes" CssClass="fs-1" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Pedidos cancelados</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="dollar-sign"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblPedidosCancelados" CssClass="fs-1" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 d-flex mt-5" >
                                    <div class="w-100">
                                        <div class="row">
                                            <div class="col-3"> <!-- recaudacion -->
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Recaudación total</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="shopping-cart"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblRecaudacionPedidos" CssClass="fs-3 mt-1 mb-3" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Recaudación promedio</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="truck"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblRecaudacionProm" CssClass="fs-3 mt-1 mb-3" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Recaudación mes en curso</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="truck"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblRecaudacionMes" CssClass="fs-3 mt-1 mb-3" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Recaudación mes anterior</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="truck"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblRecaudacionMesAnterior" CssClass="fs-3 mt-1 mb-3" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 d-flex mt-5" >
                                    <div class="w-100">
                                        <div class="row">
                                            <div class="col-3"> <!-- usuarios -->
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Usuarios Activos</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="users"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblCantidadUsuarios" CssClass="fs-1 mt-1 mb-3" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3"> <!-- articulos -->
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Artículos Activos</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="dollar-sign"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblArtRegistrados" CssClass="fs-1 mt-1 mb-3" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3"> <!-- marcas -->
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="col mt-0">
                                                                <h5 class="card-title fw-bold">Marcas Activas</h5>
                                                            </div>
                                                            <div class="col-auto">
                                                                <div class="stat text-secondary">
                                                                    <i class="align-middle" data-feather="shopping-cart"></i>
                                                                </div>
                                                            </div>
                                                            <asp:Label ID="lblCantMarcas" CssClass="fs-1 mt-1 mb-3" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <div class="card col bg-secondary text-light mb-5 h-75">
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class="col mt-0">
                                                                    <h5 class="card-title fw-bold">Categorias Activas</h5>
                                                                </div>
                                                                <div class="col-auto">
                                                                    <div class="stat text-secondary">
                                                                        <i class="align-middle" data-feather="truck"></i>
                                                                    </div>
                                                                </div>
                                                                <asp:Label ID="lblCantCategorias" CssClass="fs-1 mt-1 mb-3" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         

                        
                        <%-- SUBMENU PEDIDOS --%>

                        <asp:Panel ID="sectionAdminPedidos" runat="server" Visible="false">

                        <%-- panel filtros y todos los pedidos --%>
                        <asp:Panel ID="sectionAdminPedidosTodos" runat="server" Visible="false">
                            
                            <%-- filtros --%>
                            <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2" style="margin-top: 100px;" runat="server"><strong>Administración de Pedidos</strong></h1>
                            <div class="row d-flex justify-content-center align-items-center bg-info pb-3 pt-2" runat="server">
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
                                    <label for="txtFiltroIdUser_Pedido" class="form-label">Id Usuario</label>
                                    <asp:TextBox ID="txtFiltroIdUser_Pedido" TextMode="Number" CssClass="form-control"  runat="server"/>
                                </div>
                                <div class="col-1">
                                    <label for="txtFiltroIdPedido_Pedido" class="form-label">Id Pedido</label>
                                    <asp:TextBox ID="txtFiltroIdPedido_Pedido" Text="Id Pedido" TextMode="Number" CssClass="form-control" runat="server" />
                                </div>
                                <div class="col-1">
                                    <label for="txtFiltroNombreUsuario_Pedido" class="form-label">Usuario</label>
                                    <asp:TextBox ID="txtFiltroNombreUsuario_Pedido" placeholder="Nombre" CssClass="form-control" runat="server" />
                                </div>
                                <div class="col-1">
                                    <label for="txtFiltroFecha" class="form-label">Fecha</label>
                                    <asp:TextBox ID="txtFiltroFecha" TextMode="Date" CssClass="form-control" placeholder="" runat="server" />
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
                            <asp:GridView ID="dgvAdminPedidos" runat="server" CssClass="table table-striped table-bordered mt-5 text-center" AutoGenerateColumns="false">
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
                                <asp:TemplateField HeaderText="ID Usuario">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("IdUsuario") %>' CssClass="mt-3"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Usuario">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Usuario") %>' CssClass="mt-3"></asp:Label>
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
                                <asp:TemplateField HeaderText="Enviado">
                                    <ItemTemplate>
                                        <asp:Button Text="✔" CssClass="btn btn-outline-success mt-2" ID="btnTerminarPedido" CommandName="Finalizar" CommandArgument='<%#Eval("IdPedido") %>' OnClick="btnCancelarTerminarPedido" runat="server" OnClientClick="return confirm('¿Desea finalizar el pedido seleccionado?');" Visible='<%# Eval("Estado").ToString() == "INICIADO" ? true : false %>'/>
                                        <asp:Button Text="✔" CssClass="btn btn-success mt-2" ID="btnPedidoTerminado" runat="server" Visible='<%# Eval("Estado").ToString() == "FINALIZADO" ? true : false %>'/>
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

                        <%-- panel pedido individual --%>
                        <asp:Panel ID="sectionAdminPedidoIndividual" runat="server">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgvAdminPedido" runat="server" CssClass="table table-striped table-bordered mt-5" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:TemplateField HeaderText="ID Pedido">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("IdPedido") %>' CssClass="mt-3"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cantidad solicitada">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("Cantidad") %>' CssClass="mt-3"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ID Usuario">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("IdUsuario") %>' CssClass="mt-3"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Usuario">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("Usuario") %>' CssClass="mt-3"></asp:Label>
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
                                            <asp:TemplateField HeaderText="Monto">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# string.Format("{0:C2}", Eval("PrecioTotal")) %>'  CssClass="mt-3"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>

                        
                        <%-- panel editar pedidos --%>
                        <asp:Panel ID="seccionEditarPedidos" Visible="false" runat="server" UpdateMode="Conditional">
                                  
                                    <div class="row d-flex justify-content-center align-items-center">
                                        <div class="card rounded-4 col-10 bg-info ms-5" style="margin-top: 100px; margin-bottom: 100px;" id="Div1" runat="server">
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
                                                        <asp:Button Text="Volver a Lista Pedidos" CssClass="btn btn-dark text-light mt-3 mb-3 fs-6" ID="btnVolverListaPedidos" CommandName="btnPedidosTodos_Click" OnClick="btnPedidosTodos_Click" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="container text-center">                                      
                                            <div class="row d-flex justify-content-center aling-items-center">
                                                  <div class="col-4 align-self-center bg-info border rounded-3 p-3">
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

                            </asp:Panel>

                        
                        <%-- panel descuentos --%>
                        <asp:Panel ID="panelCuponDescuento" runat="server" Visible="false">

                        <div class="row">
                            <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2" style="margin-top: 100px;" id="H1" runat="server"><strong>Cupones de Descuento</strong></h1>
                            <div class="col-10 mt-5" id="sectionCuponDescuento" runat="server">
                                <asp:Button ID="btnAgregarDescuento" Text="Agregar nuevo Cupon" CssClass="fs-5 m-3 btn btn-primary btn-lg m-3" runat="server" OnClick="btnAgregarDescuento_Click" />
                            </div>
                            <asp:GridView ID="dgvDescuentos" AutoGenerateColumns="false" CssClass="table table-striped table-bordered mt-5" runat="server">
                                <Columns>
                                    <asp:BoundField HeaderText="Id Cupón" DataField="Id" />
                                    <asp:BoundField HeaderText="Codigo" DataField="Codigo"/>
                                    <asp:TemplateField HeaderText="Porcentaje">
                                        <ItemTemplate>
                                            <asp:Label Text='<%#string.Format("{0:P0}", Convert.ToInt32(Eval("Porcentaje"))*0.01)%>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Estado">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Convert.ToBoolean(Eval("Estado")) ? "ACTIVO" : "INACTIVO" %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cambiar Estado" >
                                        <ItemTemplate>
                                            <asp:Button Text="ALTA" ID="btnDarAltaCupon" CssClass="btn btn-outline-success" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="true" OnClick="btnCambiarEstadoCupon_Click" Visible='<%# Convert.ToBoolean(Eval("Estado")) ? false : true %>' />
                                            <asp:Button Text="BAJA TEMPORAL" ID="btnDarBajaCupon" CssClass="btn btn-outline-danger" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="false" OnClick="btnCambiarEstadoCupon_Click" Visible='<%# Convert.ToBoolean(Eval("Estado")) ? true : false %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Eliminar">
                                        <ItemTemplate>
                                            <asp:Button Text="ELIMINAR" ID="btnEliminarCupon" CssClass="btn btn-outline-danger" runat="server" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('¿Desea eliminar el cupon seleccionado?');" OnClick="btnEliminarCupon_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </div>
                        
                        <%-- panel nuevo cupon descuento --%>
                        <div class="row d-flex justify-content-center align-items-center" id="sectionNuevoCupon" visible="false" runat="server">
                            <div class="card rounded-4 col-8 bg-light ms-3" style="margin-top: 100px; margin-bottom: 100px;">
                                <div class=" card-header text-center">
                                    <h1> Agregar Cupon de Descuento </h1>
                                </div>
                                <div class="row p-2">
                                    <div class="col-6 mt-3">
                                        <label for="txtCodigoCupon" class="form-label">Codigo <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="txtCodigoCupon" runat="server" />
                                    </div>
                                    <div class="col-8 mt-3">
                                        <label for="txtPorcentajeCupon" class="form-label">Porcentaje de descuento<span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" type="number" ID="txtPorcentajeCupon" runat="server" />
                                    </div>

                                    <div class="col-12 mt-3">
                                        <div class="d-flex justify-content-center align-items-center">
                                            <asp:Button Text="Guardar Descuento" ID="btnGuardarNuevoCupon" CssClass="btn btn-dark px-4 mb-3 p-2 fs-4 text-center" runat="server" OnClick="btnGuardarNuevoCupon_Click" />
                                        </div>
                                        <div class="d-flex justify-content-center align-items-center">
                                            <asp:LinkButton Text="Volver a Cupones de Descuento" CssClass="link-body-emphasis m-3" ID="btnVolverDescuento" OnClick="btnVolverDescuento_Click" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        </asp:Panel>
                        </asp:Panel>



                        <%-- SUBMENU ARTICULOS --%>

                        
                        <%-- panel articulos --%>

                        <asp:Panel ID="sectionAdminArticulos" runat="server" Visible="false">

                        <%-- filtros --%>
                        <div class="row">
                            <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2" style="margin-top: 100px;" id="lblAdministracionArticulos"><strong>Administración de Articulos</strong></h1>
                            <div id="divFiltrosArticulos" class="col-2 p-3 mt-3" runat="server">
                                <div class="dropend">
                                    <button class="btn dropdown-toggle " type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Marcas
                                    </button>
                                    <ul class="dropdown-menu ">
                                        <asp:Repeater runat="server" ID="rptMarcas">
                                            <ItemTemplate>
                                                <li>
                                                    <asp:Button CssClass="btn" Text='<%#Eval("Descripcion") %>' runat="server" ID="btnFiltroMarca" OnClick="btnFiltroMarca_Click" CommandArgument='<%#Eval("Id") %>' />
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                                <div class="dropend ">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Categorias
                                    </button>
                                    <ul class="dropdown-menu">
                                        <asp:Repeater runat="server" ID="rptCategorias">
                                            <ItemTemplate>
                                                <li>
                                                    <asp:Button CssClass="btn" Text='<%#Eval("Descripcion") %>' runat="server" ID="btnFiltroCate" OnClick="btnFiltroCate_Click" CommandArgument='<%#Eval("Id") %>' />
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                                <div class="dropend">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Ordenar
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <asp:Button CssClass="btn" Text="Mayor precio" runat="server" ID="btnFiltroPrecioAsc" OnClick="btnFiltroPrecioDesc_Click" />
                                        </li>
                                        <li>
                                            <asp:Button CssClass="btn" Text="Menor precio" runat="server" ID="btnFiltroPrecioDesc" OnClick="btnFiltroPrecioAsc_Click" />
                                        </li>
                                    </ul>
                                </div>
                                <div class="dropend mb-4">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Estado    
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <asp:Button ID="btnFiltroEstadoAlta" CssClass="btn" Text="Alta" CommandArgument="Activo" OnClick="btnFiltroEstadoAlta_Click"  runat="server"/>
                                        </li>
                                        <li>
                                            <asp:Button ID="btnFiltroEstadoBaja" CssClass="btn" Text="Baja" CommandArgument="Inactivo" OnClick="btnFiltroEstadoBaja_Click" runat="server"/>
                                        </li>
                                    </ul>
                                </div>

                                <%--<asp:DropDownList ID="ddlFiltroCategoria" CssClass="form-select h-1 mb-4" runat="server" AutoPostBack="false"></asp:DropDownList>
                                <asp:DropDownList ID="ddlFiltroMarca" CssClass="form-select h-1 mb-4" runat="server" AutoPostBack="false"></asp:DropDownList>
                                <asp:Button CssClass="btn btn-primary btn-sm mb-5" Text="Aplicar" runat="server" ID="btnFiltro" OnClick="btnFiltro_Click" />--%>
                                <asp:Button CssClass="btn btn-info btn-sm mb-5" Text="Eliminar Filtros" runat="server" ID="btnBorrarFilros" OnClick="btnBorrarFilros_Click" />
                            </div>

                            <%-- lista --%>
                            <div class="col-10">
                                <asp:GridView ID="dgvAdminArticulo" runat="server" CssClass="table table-striped mt-5 text-center align-content-center h-100" AutoGenerateColumns="false" OnPageIndexChanging="dgvAdmin_PageIndexChanging">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Imagen">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ImageUrl='<%#Eval("ImagenUrl") %>' onerror="this.src='./Content/img/image-not-found.png'" Width="100px" CssClass="ml-2" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Nombre">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Nombre") %>' CssClass="mt-3"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Descripción">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Descripcion") %>' CssClass="mt-3"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Marca">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Marca.Descripcion") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Categoría">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Categoria.Descripcion") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Precio" ItemStyle-CssClass="col-1">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# string.Format("{0:C2}", Eval("Precio")) %>' CssClass="mt-3"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Stock">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Stock") %>' CssClass="mt-3"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Estado">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Convert.ToBoolean(Eval("Estado")) ? "Activo" : "Inactivo" %>' CssClass="mt-3 h-100 align-self-center"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Acción" ItemStyle-CssClass=" col-2">
                                            <ItemTemplate>
                                                <asp:Button Text="ALTA" ID="btnDarAltaArticulo" CssClass="btn btn-outline-success mt-3" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="ALTA" OnClick="btnCambiarEstadoArticulo_Click" OnClientClick="return confirm('¿Seguro quiere cambiar el estado del articulo?');" Visible='<%# Convert.ToBoolean(Eval("Estado")) ? false : true %>'/>
                                                <asp:Button Text="BAJA" ID="btnDarBajaArticulo" CssClass="btn btn-outline-danger mt-3" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="BAJA" OnClick="btnCambiarEstadoArticulo_Click" OnClientClick="return confirm('¿Seguro quiere cambiar el estado del articulo?');" Visible='<%# Convert.ToBoolean(Eval("Estado")) ? true : false %>'/>
                                                <asp:Button Text="✏" ID="btnEditarArticulo" CssClass="btn btn-outline-secondary mt-3" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="editar_btn" OnClick="btnEditarArticulo_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                        </asp:Panel>

                        <%-- panel articulo individual --%>
                        <asp:GridView ID="dgvAdminArticuloIndividual" Visible="false" runat="server" CssClass="table table-striped mt-5" AutoGenerateColumns="False"
                            AllowPaging="true"
                            PageSize="10"
                            OnPageIndexChanging="dgvAdmin_PageIndexChanging">
                            <PagerSettings Mode="NumericFirstLast"/>
                            <Columns>
                                <asp:TemplateField HeaderText="Imagen">
                                    <ItemTemplate>
                                        <asp:Image runat="server" ImageUrl='<%#Eval("ImagenUrl") %>' onerror="this.src='./Content/image-not-found.png'" Width="70px" Height="70px" CssClass="ml-2" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Nombre") %>' CssClass="mt-3"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Descripción">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Descripcion") %>' CssClass="mt-3"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Marca">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Marca") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Categoría">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Categoria") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Precio">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# string.Format("{0:C2}", Eval("precio")) %>' CssClass="mt-3"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Estado" DataField="EstadoStr"/>
                            </Columns>
                        </asp:GridView>


                        <%-- panel crear o modificar articulo --%>
                        <div class="row d-flex justify-content-center align-items-center">
                            <div class="card rounded-4 col-10 bg-info m-5" id="sectionNuevoArticulo" visible="false" runat="server">
                                <div class=" card-header text-center">
                                    <h1 id="tituloEditarArticulo" runat="server">Editar Artículo</h1>
                                    <h1 id="tituloNuevoArticulo" runat="server">Nuevo Artículo</h1>
                                </div>
                                <div class="row p-2">
                                    <div class="col-6 mt-3">
                                        <label for="IdArticulo" class="form-label">Número de ID <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control w-100" ID="tbIdArt" placeholder="ID Articulo" runat="server" Width="380px"/>
                                    </div>
                                    <div class="col-6 mt-3">
                                        <label for="Nombre" class="form-label">Nombre <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="tbNombreArt" runat="server" Width="280px"/>
                                    </div>
                                </div>
                                <div class="row p-2">
                                    <div class="col-6 mt-3">
                                        <div class="row">
                                            <label for="ddlMarca" class="form-label">Marca<span class="text-danger">*</span></label>
                                        </div>
                                        <div class="row ps-2">
                                            <asp:DropDownList runat="server" ID="ddlMarca" CssClass="btn btn-light dropdown-toggle" Width="280px" ></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-6 mt-3">
                                        <div class="row">
                                            <label for="ddlCategoria" class="form-label">Categoría <span class="text-danger">*</span></label>
                                        </div>
                                        <div class="row ps-2">
                                            <asp:DropDownList runat="server" ID="ddlCategoria" CssClass="btn btn-light dropdown-toggle" Width="280px" ></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="row p-2">
                                    <div class="col-6 mt-3">
                                        <label for="Stock" class="form-label">Stock <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="tbStockArt" runat="server"/>
                                    </div>
                                    <div class="col-6 mt-3">
                                        <label for="Precio" class="form-label">Precio <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="tbPrecioArt" runat="server" Width="380px"/>
                                    </div>
                                </div>
                                <div class="row p-2 mb-3">
                                    <div class="col-4 mt-3 text-center align-content-center">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Image ID="imgNuevoArt" runat="server" ImageUrl="~/Content/img/agregar-img.png" Width="300px" CssClass="mt-3 ms-5" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="col-6 my-3">
                                        <div class="row p-2">
                                            <div class="col-6 mt-3">
                                                <label for="img" class="form-label">URL imágen <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control" ID="tbImgArt" runat="server" AutoPostBack="true" OnTextChanged="tbImgArt_TextChanged" />
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-8 mt-3">
                                                <label for="Descripcion" class="form-label">Descripcion <span class="text-danger">*</span></label>
                                                <asp:TextBox CssClass="form-control pb-4" ID="tbDescripArt" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row justify-content-center aling-items-center">
                                        <hr />
                                    </div>
                                    <div class="col-12 mt-3">
                                        <div class="d-flex justify-content-center align-items-center">
                                            <asp:Button Text="Guardar Cambios" ID="btnAgregar" CssClass="btn btn-dark text-light mb-3 ps-5 pe-5 fs-4" runat="server" OnClick="btnAgregar_Click" OnClientClick="return confirm('¿Seguro de Continuar?');" />
                                        </div>
                                        <div class="d-flex justify-content-center align-items-center">
                                            <asp:Button Text="Eliminar" ID="btnEliminarArticulo" CssClass="btn btn-danger mb-3 ps-5 pe-5 fs-4" OnClick="btnEliminarArticulo_Click" OnClientClick="return confirm('¿Seguro de Eliminar?');" runat="server" />
                                        </div>
                                        <div class="d-flex justify-content-center">
                                            <asp:LinkButton Text="Volver a Lista Articulos" CssClass="link-body-emphasis mt-2" ID="linkButtonVolverListaArticulos" OnClick="btnLinkVolverListaArticulos_Click"  runat="server" />
                                        </div>
                                        <div class="d-flex justify-content-center">
                                            <p id="lblErrorArticulos" visible="false" runat="server">
                                                <span class="badge text-bg-danger text-light me-2">
                                                    <asp:Label ID="lblRespuestaError" runat="server" />
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        



                        <%-- panel marcas --%>

                        <asp:Panel ID="panelAdminMarcas" runat="server" Visible="false">

                        <div class="row">
                            <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2" style="margin-top: 100px;" id="titleMarcas" runat="server"><strong>Administración de Marcas</strong></h1>
                            <div class="col-10 mt-5" id="sectionAgregarMarca" runat="server">
                                <asp:Button ID="btnAgregarMarca" Text="Agregar nueva Marca" CssClass="fs-5 m-3 btn btn-primary btn-lg m-3" runat="server" OnClick="btnAgregarMarca_Click" />
                            </div>
                            <asp:Repeater ID="dgvAdminMarca" runat="server">
                                <ItemTemplate>
                                    <div class="col-3 mt-2 mb-3 text-center">
                                        <div class="card h-100 m-3 bg-light border-primary " runat="server" id="cardMarca">
                                            <div class="card-header">
                                                <asp:Label runat="server" ID="lblIdMarca" Text='<%# Eval("Id") %>' CssClass="mt-3"></asp:Label>
                                            </div>
                                            <div class="d-flex justify-content-center align-items-center h-100 mt-5">
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <asp:Image ID="imgMarca" runat="server" ImageUrl='<%#Eval("ImagenUrl") %>' onerror="this.src='./Content/img/image-not-found.png'" Width="250px" CssClass="ml-2" />
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <asp:Label runat="server" ID="lblMarca" Text='<%# Eval("Descripcion") %>'></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtMarca" Visible="false" CssClass="form-control"></asp:TextBox>
                                                </h5>
                                                <p class="card-text">
                                                    <asp:Label ID="lblCambiarImgMarca" Text="URL Imágen" runat="server" Visible="false" CssClass="mt-5" />
                                                    <asp:Label runat="server" ID="lblUrlMarca" Text='<%# Eval("ImagenUrl") %>' CssClass="mt-3" Visible="false"></asp:Label>
                                                    <asp:TextBox runat="server" ID="tbUrlImgMarca" AutoPostBack="true" Visible="false" CssClass="form-control mt-3" OnTextChanged="tbUrlImgMarca_TextChanged"></asp:TextBox>
                                                </p>
                                            </div>
                                            <div class="col-12 bg-danger text-center">
                                                <i class="bi bi-trash-fill fs-5"></i>
                                                <asp:Button runat="server" ID="btnEliminarMarca" Text="Eliminar" Font-Bold="true" CssClass="btn" OnClick="btnEliminarMarca_Click" OnClientClick="return confirm('¿Estás seguro de que deseas eliminar esta marca? Todos los articulos de esta marca seran dados de baja temporalmente');"/>
                                            </div>
                                            <div class="col-12 card-footer text-center bg-primary">
                                                <i class="bi bi-pencil-fill fs-5"></i>
                                                <asp:Button runat="server" ID="btnEditarMarca" Text="Editar" Font-Bold="true" Visible="true" CssClass="btn btn-primary" OnClick="btnEditarMarca_Click"/>
                                                <asp:Button runat="server" ID="btnGuardarMarca" Text="Guardar" Font-Bold="true" Visible="false" CssClass="btn btn-success" OnClick="btnGuardarMarca_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        
                        </asp:Panel>

                        <%-- panel nueva marca--%>
                        <div class="row d-flex justify-content-center align-items-center vh-100" id="sectionNuevaMarca" visible="false" runat="server">
                            <div class="card rounded-4 col-8 bg-light ms-5" style="margin-top: 100px; margin-bottom: 100px;">
                                <div class=" card-header text-center">
                                    <h1> Agregar Marca </h1>
                                </div>
                                <div class="row p-2">
                                    <div class="col-6 mt-3">
                                        <label for="Nombre" class="form-label">Nombre <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="tbNombreMarca" runat="server" />
                                    </div>
                                    <div class="col-8 mt-3">
                                        <label for="img" class="form-label">URL imágen <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="tbUrlImgNuevaMarca" runat="server" AutoPostBack="true" OnTextChanged="tbUrlImgNuevaMarca_TextChanged" />
                                    </div>
                                    <div class="col-4 mt-3">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Image ID="imgNuevaMarca" runat="server" ImageUrl="~/Content/img/agregar-img.png" Width="200px" CssClass="mt-3 ms-5" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>

                                    <div class="col-12 mt-3">
                                        <div class="d-flex justify-content-center align-items-center">
                                            <asp:Button Text="Guardar Marca" ID="Button1" CssClass="btn btn-dark mb-3 ps-5 pe-5 fs-4" runat="server" OnClick="btnGuardarNewMarca_Click" />
                                        </div>
                                        <div class="d-flex justify-content-start align-items-start">
                                            <asp:LinkButton Text="Volver a Marcas" CssClass="link-body-emphasis m-3" ID="btnVolverMarca" OnClick="btnVolverMarca_Click" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        
                        <%-- panel categorias --%>

                         <asp:Panel ID="panelAdminCategorias" runat="server" Visible="false">

                        <div class="row">
                            <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2" style="margin-top: 100px;" id="titleCategoria" runat="server"><strong>Administración de Categorias</strong></h1>
                            <div class="col-10 mt-5" id="sectionAgregarCategoria" runat="server">
                                <asp:Button ID="btnAgregarCategoria" Text="Agregar nueva Categoria" CssClass="fs-5 m-3 btn btn-primary btn-lg m-3" runat="server" OnClick="btnAgregarCategoria_Click" />
                            </div>
                            <asp:Repeater ID="dgvAdminCate" runat="server">
                                <ItemTemplate>
                                    <div class="col-3 mt-2 mb-3 text-center">
                                        <div class="card h-100 m-3 bg-light border-primary " runat="server" id="cardCategoria">
                                            <div class="card-header">
                                                <asp:Label runat="server" ID="lblIdCategoria" Text='<%# Eval("Id") %>' CssClass="mt-3"></asp:Label>
                                            </div>
                                            <div class="d-flex justify-content-center align-items-center h-100 mt-5">
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <asp:Image ID="imgCategoria" runat="server" ImageUrl='<%#Eval("ImagenUrl") %>' onerror="this.src='./Content/img/image-not-found.png'" Width="250px"  CssClass="ml-2" />
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <asp:Label runat="server" ID="lblCategoria" Text='<%# Eval("Descripcion") %>'></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtCategoria" Visible="false" CssClass="form-control"></asp:TextBox>
                                                </h5>
                                                <p class="card-text">
                                                    <asp:Label ID="lblCambiarImgCategoria" Text="URL Imágen" runat="server" Visible="false" CssClass="mt-5" />
                                                    <asp:Label runat="server" ID="lblUrlCategoria" Text='<%# Eval("ImagenUrl") %>' CssClass="mt-3" Visible="false"></asp:Label>
                                                    <asp:TextBox runat="server" ID="tbUrlImgCategoria" AutoPostBack="true" Visible="false" CssClass="form-control mt-3" OnTextChanged="tbUrlImgCate_TextChanged"></asp:TextBox>
                                                </p>
                                            </div>
                                            <div class="col-12 bg-danger text-center">
                                                <i class="bi bi-trash-fill fs-5"></i>
                                                <asp:Button runat="server" ID="btnEliminarCategoria" Text="Eliminar" Font-Bold="true" CssClass="btn" OnClick="btnEliminarCategoria_Click" OnClientClick="return confirm('¿Estás seguro de que deseas eliminar esta categoria? Todos los articulos de esta categoría seran dados de baja temporalmente');"/>
                                            </div>
                                            <div class="col-12 card-footer text-center bg-primary">
                                                <i class="bi bi-pencil-fill fs-5"></i>
                                                <asp:Button runat="server" ID="btnEditarCategoria" Text="Editar" Font-Bold="true" Visible="true" CssClass="btn btn-primary" OnClick="btnEditarCategoria_Click"/>
                                                <asp:Button runat="server" ID="btnGuardarCategoria" Text="Guardar" Font-Bold="true" Visible="false" CssClass="btn btn-success" OnClick="btnGuardarCategoria_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        
                        </asp:Panel>

                        <%-- panel nueva categoria--%>
                        <div class="row d-flex justify-content-center align-items-center" id="sectionNuevaCategoria" visible="false" runat="server">
                            <div class="card rounded-4 col-8 bg-light ms-5" style="margin-top: 100px; margin-bottom: 100px;">
                                <div class=" card-header text-center">
                                    <h1>Nueva Categoria</h1>
                                </div>
                                <div class="row p-2">
                                    <div class="col-6 mt-3">
                                        <label for="Nombre" class="form-label">Nombre <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="tbNombreCate" runat="server" />
                                    </div>
                                    <div class="col-8 mt-3">
                                        <label for="img" class="form-label">URL imágen <span class="text-danger">*</span></label>
                                        <asp:TextBox CssClass="form-control" ID="tbUrlImgCate" runat="server" AutoPostBack="true" OnTextChanged="tbUrlImgNuevaCategoria_TextChanged" />
                                    </div>
                                    <div class="col-4 mt-3">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Image ID="imgNuevaCate" runat="server" ImageUrl="~/Content/img/agregar-img.png" Width="200px" CssClass="mt-3 ms-5" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>

                                    <div class="col-12 mt-3">
                                        <div class="d-flex justify-content-center align-items-center">
                                            <asp:Button Text="Guardar categoría" ID="btnAgregarCate" CssClass="btn btn-dark mb-3 ps-5 pe-5 fs-4" runat="server" OnClick="btnGuardarNewCategoria_Click" />
                                        </div>
                                        <div class="d-flex justify-content-start align-items-start">
                                            <asp:LinkButton Text="Volver a categorías" CssClass="link-body-emphasis m-3" ID="volverCate" OnClick="volverCategoria_Click" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        

                        <!-- SUBMENU USUARIOS -->

                         <%-- panel filtros y todos los pedidos --%>
                        <asp:Panel ID="sectionAdminUsuarios" runat="server" Visible="false">

                        <!-- filtros -->
                        <h1 class="text-light text-center bg-dark border border-light rounded-2 p-2 mb-2" style="margin-top: 100px;" id="lblAdministracionUsuarios" runat="server"><strong>Administración de Usuarios</strong></h1>
                        <div class="row d-flex text-center align-items-center bg-info p-2 m-2 px-4 mt-4"  id="filtrosUsuarios" runat="server">
                            <div class="col-2">
                                <h2>Filtros:</h2>
                            </div>
                            <div class="col-1">
                                <div class="dropend">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Estado
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <asp:Button CssClass="btn" Text="ACTIVO" CommandName="ACTIVO" OnClick="btnFiltrarEstadoUsuarios_Click" runat="server" />
                                        </li>
                                        <li>
                                            <asp:Button CssClass="btn" Text="INACTIVO" CommandName="INACTIVO" OnClick="btnFiltrarEstadoUsuarios_Click" runat="server" />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-1">
                                <div class="dropend">
                                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Nivel
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <asp:Button CssClass="btn" Text="CLIENTE" CommandName="C" OnClick="btnFiltrarNivelUsuarios_Click" runat="server" />
                                        </li>
                                        <li>
                                            <asp:Button CssClass="btn" Text="EMPLEADO" CommandName="E" OnClick="btnFiltrarNivelUsuarios_Click" runat="server" />
                                        </li>
                                        <li>
                                            <asp:Button CssClass="btn" Text="ADMINISTRADOR" CommandName="A" OnClick="btnFiltrarNivelUsuarios_Click" runat="server" />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-1">
                                <label for="txtFiltroIdUser_Pedido" class="form-label">Id Usuario</label>
                                <asp:TextBox ID="txtIdFiltro_Usuario" placeholder="Id" TextMode="Number" CssClass="form-control" runat="server"/>
                            </div>
                            <div class="col-1">
                                <label for="txtFiltroIdPedido_Pedido" class="form-label">DNI</label>
                                <asp:TextBox ID="txtDNIFiltro_Usuario" placeholder="DNI" TextMode="Number" CssClass="form-control" runat="server" />
                            </div>
                            <div class="col-1">
                                <label for="txtFiltroNombreUsuario_Pedido" class="form-label">Nombre</label>
                                <asp:TextBox ID="txtNombreFiltro_Usuario" placeholder="Nombre" CssClass="form-control" runat="server" />
                            </div>
                            <div class="col-1">
                                <label for="txtApellidoFiltro_Usuario" class="form-label">Apellido</label>
                                <asp:TextBox ID="txtApellidoFiltro_Usuario" placeholder="Apellido" CssClass="form-control" runat="server" />
                            </div>
                            <div class="col-3">
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

                        <!-- tabla -->
                        <asp:GridView ID="dgvAdminUsuario" runat="server" CssClass="table table-striped mt-5 p-1 text-center" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nombre">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Nombre") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Apellido">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Apellido") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DNI">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("DNI") %>' CssClass="mt-3"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mail">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Mail") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Direccion" DataField="Direccion" />
                                <asp:BoundField HeaderText="Activo" DataField="MostrarActivo" />
                                <asp:BoundField HeaderText="Nivel" DataField="NivelUpper" />
                                <asp:TemplateField HeaderText="Editar">
                                    <ItemTemplate>
                                        <asp:Button Text="✏" CssClass="btn btn-outline-info mt-1" ID="ibtEditarUsuario" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="editar_btn" OnClick="ibtEditarUsuario_Click"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cambiar Activo">
                                    <ItemTemplate>
                                        <asp:Button Text="Baja" CssClass="btn btn-danger mt-1" CommandName="false" OnClick="btnCambiarEstadoUsuario_Click" CommandArgument='<%#Eval("Id") %>' runat="server" Visible='<%# Convert.ToBoolean(Eval("Activo")) ? true : false %>' OnClientClick="return confirm('¿Seguro quiere cambiar el estado del usuario?');"/>
                                        <asp:Button Text="Alta" CssClass="btn btn-info mt-1" CommandName="true" OnClick="btnCambiarEstadoUsuario_Click" CommandArgument='<%#Eval("Id") %>' runat="server" Visible='<%# Convert.ToBoolean(Eval("Activo")) ? false : true %>' OnClientClick="return confirm('¿Seguro quiere cambiar el estado del usuario?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        </asp:Panel>

                        <%-- panel agregar o modificar usuario --%>
                        <div id="updatePanelModificarUsuario" runat="server">
                            <div class="row d-flex justify-content-center align-items-center mt-5" runat="server" id="sectionModificarUsuario" visible="false">
                                <div class="col col-lg-10 mb-4 mb-lg-0 mt-5">
                                    <div class="card mb-3" style="border-radius: .5rem;">
                                        <div class="row g-0">
                                            <div class="col-md-4  text-center bg-info text-white"
                                                style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
                                                <asp:Image ID="userImg" runat="server" ImageUrl="~/Content/img/avatar.png" Width="120px" CssClass="img-fluid my-5" />
                                                <h6>
                                                    <strong class="fs-5 text-dark">ID
                                                        <asp:Label runat="server" ID="txtId" />
                                                    </strong>
                                                </h6>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="card-body p-4">
                                                    <h6>Información del usuario</h6>
                                                    <hr class="mt-0 mb-4">
                                                    <div class="row pt-1">
                                                        <div class="col-6 mb-3">
                                                            <h6>Nombre/s</h6>
                                                            <asp:TextBox type="text" runat="server" ID="txtNombre" CssClass="text-muted form-control" pattern="[A-Za-z]+"/>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Apellido/s</h6>
                                                            <asp:TextBox type="text" runat="server" ID="txtApellido" CssClass="text-muted form-control" pattern="^[A-Za-z\\s]+$"/>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Email</h6>
                                                            <asp:TextBox type="email" runat="server" ID="txtEmail" CssClass="text-muted form-control" pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"/>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Nro. Documento</h6>
                                                            <asp:TextBox type="number" runat="server" ID="txtDni" CssClass="text-muted form-control" pattern="^\d+$"/>
                                                        </div>
                                                        <h6 class="mt-2">Contacto</h6>
                                                        <hr class="mt-0 mb-4">
                                                        <div class="row pt-1">
                                                            <div class="col-6 mb-3">
                                                                <h6>Contraseña</h6>
                                                                <asp:TextBox runat="server" TextMode="Password" ID="txtClave" CssClass="text-muted form-control" />
                                                            </div>
                                                            <div class="col-6 mb-3">
                                                                <h6>Dirección</h6>
                                                                <asp:TextBox type="text" runat="server" ID="txtDomicilio" CssClass="text-muted form-control"  />
                                                            </div>
                                                            <div class="col-6 mb-3">
                                                                <h6>Nivel de usuario</h6>
                                                                <asp:DropDownList ID="ddlTipoUsuario" runat="server" CssClass="form-select">
                                                                    <asp:ListItem Text="C - Cliente" Value="C"></asp:ListItem>
                                                                    <asp:ListItem Text="A - Administrador" Value="A"></asp:ListItem>
                                                                    <asp:ListItem Text="E - Empleado" Value="E"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="d-flex justify-content-end">
                                                                <asp:Button Text="Eliminar" runat="server" ID="btnEliminarUsuario" OnClientClick="return confirm('¿Desea eliminar definitivamente el usuario seleccionado?');" OnClick="btnEliminarUsuario_Click" CssClass="btn btn-danger mt-3 me-3" />
                                                                <asp:Button Text="Guardar Cambios" runat="server" ID="btnGuardarUsuario" OnClientClick="return confirm('¿Confirma guardar?');" OnClick="btnGuardarUsuario_Click" CssClass="btn btn-dark mt-3" />
                                                            </div>
                                                            <div class="d-flex justify-content-center">
                                                                <asp:LinkButton Text="Volver a Lista Usuarios" CssClass="link-body-emphasis" ID="lnkVolverListaUsuarios" CommandName="btnVolverListaUsuarios" OnClick="lnkVolverListaUsuarios_Click" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>




                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
            <div class="col py-3"></div>
        </div>
    </div>
    
</asp:Content>