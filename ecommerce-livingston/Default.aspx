﻿<%@ Page Title="Ojo de Aguila" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ecommerce_livingston.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>

        <div class="container mt-5">
            <div id="carousel-1" class="carousel slide" data-bs-ride="true">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carousel-1" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carousel-1" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carousel-1" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    <button type="button" data-bs-target="#carousel-1" data-bs-slide-to="3" aria-label="Slide 4"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active" ><img class="w-100 d-block" src="/Content/img/banner/banner-01.jpg" alt="Slide Image" /></div>
                 <div class="carousel-item"><img class="w-100 d-block" src="/Content/img/banner/banner-02.jpg" alt="Slide Image" /></div>
                 <div class="carousel-item"><img class="w-100 d-block" src="/Content/img/banner/banner-03.jpg" alt="Slide Image" /></div>
                 <div class="carousel-item"><img class="w-100 d-block" src="/Content/img/banner/banner-04.jpg" alt="Slide Image" /></div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carousel-1" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carousel-1" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>

        <!-- categorias -->
         <div class="container mt-5 container-inicio rounded pb-5 mb-4">
             <div class="row">
                 <div class="col">
                     <h1 class="mt-4 fw-bold text-dark">Encontra todo lo que buscas</h1>
                     <div class="slider responsive">
                         <asp:Repeater runat="server" ID="rptCategorias">
                             <ItemTemplate>
                                 <div class="card text-center mb-3" style="width: 18rem;">
                                    <div class="div-inicio-img">
                                        <asp:ImageButton ImageUrl='<%# Eval("ImagenUrl") %>' class="card-img-top inicio-img" OnClick="btnImgCategoria_Click" CommandArgument='<%# Eval("Id") %>' runat="server" />
                                    </div>
                                  <div>
                                    <h5 class="card-header"><%#Eval("Descripcion") %></h5>
                                  </div>
                                </div>
                             </ItemTemplate>
                         </asp:Repeater>
                     </div>
                 </div>
             </div>
         </div>
         
        <!-- marcas -->
         <div class="container mt-5 container-inicio rounded pb-5 mb-4">
             <div class="row">
                 <div class="col">
                     <h1 class="mt-4 fw-bold text-dark">Las Mejores Marcas</h1>
                     <div class="slider responsive">
                         <asp:Repeater runat="server" ID="rptMarcas">
                             <ItemTemplate>
                                <div class="card div-inicio-img text-center">
                                    <asp:ImageButton ImageUrl='<%# Eval("ImagenUrl") %>' class="card-img" OnClick="btnImgMarca_Click" CommandArgument='<%# Eval("Id") %>' runat="server" style="max-height:170px; width:15rem;"/>
                                </div>
                             </ItemTemplate>
                         </asp:Repeater>
                     </div>
                 </div>
             </div>
         </div>
    </main>


</asp:Content>