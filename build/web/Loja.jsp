<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"></jsp:include>
<%
    HttpSession sessao = request.getSession(false);
    Usuario usuario = (Usuario) sessao.getAttribute("usuario");
    if (usuario.getPerfilUsuario().equals("Aluno")) {
%>
<div class="page">
    <style type="text/css">
        body {
            overflow-x: hidden; /* Impede a rolagem horizontal */
        }
        .pag{
            padding: 0;  
        }
        .carousel-item {
            width: 100%;
            height: 550px;
        }
        .carousel-item img {
            width: 100%;
            height: 100%;
        }

        .navbar{
            background-color: #131313;
        }

        .navbar a {
            color: yellow;
        }
        .card-img-top {
            width: 150px;
            height: 150px;

        }
        .card-h {
            text-align: center;
            padding: 10px;
        }

        .card:hover{
            transform: scale(1.05);
        }
        .custom-card {
            width: 100%;
            border: 0;
            border-radius: 20px;
        }

        .card-titulo {
            font-size: 16px;
            margin: 8px 0;
            font-weight: bold;
        }

        .card-body hr {
            opacity: 0.2;
        }

        .card-valor {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 16px;
        }

        .card-pix {
            font-size: 20px;
        }

        .pix-color {
            color: red;
            font-weight: bold;
        }

        .credit-color {
            font-size: 16px;
        }
        .fa-credit-card{
            color: red;
        }

        .card-qtd {
            font-size: 12px;
            margin-bottom: 16px;
        }
        p{
            margin: 0;
        }


        .group {
            display: flex;
            line-height: 28px;
            align-items: center;
            position: relative;
            max-width: 190px;
        }

        .input {
            width: 100%;
            height: 40px;
            line-height: 28px;
            padding: 0 1rem;
            padding-left: 2.5rem;
            border: 2px solid transparent;
            border-radius: 8px;
            outline: none;
            background-color: #f3f3f4;
            color: #0d0c22;
            transition: .3s ease;
        }

        .input::placeholder {
            color: #9e9ea7;
        }

        .input:focus, input:hover {
            outline: none;
            border-color: rgba(254,255,0,0.4);
            background-color: #fff;
            box-shadow: 0 0 0 4px rgb(234 76 137 / 10%);
        }

        .icon {
            position: absolute;
            left: 1rem;
            fill: #9e9ea7;
            width: 1rem;
            height: 1rem;
            cursor: pointer;
        }
        .cart{
            cursor: pointer;
            padding: 10px;
            color: #feff00;
        }
        .pesq{
            text-align: center;
            align-items: center;
        }
        .num-cart{
            font-size: 10px;
            color: white;
        }
        .nav-link:hover{
            cursor:pointer;
        }
        .iconsearch{
            position: absolute;
            margin-left: 12px;
            cursor: pointer;
        }
    </style>
    <div class="d-flex flex-column flex-shrink-0 sidebar" style="width: 4.5rem;">
        <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
            <li class="nav-item">
                <a href="home.jsp" class="nav-link  py-3" aria-current="page" title="Inicio" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house fa"></i>
                </a>
            </li>

            <li>
                <a href="ListarEventoCal" class="nav-link py-3 " title="Agenda" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-calendar-days fa"></i>
                </a>
            </li>
            <li>
                <a href="Loja.jsp" class="nav-link py-3  active" title="Loja & Produtos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-cart-shopping "></i>
                </a>
            </li>
            <li>
                <a href="Notificacao.jsp" class="nav-link py-3 " title="Notificações" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-bell fa"></i>
                </a>
            </li>
            <li>
                <a href="MensAluno.jsp" class="nav-link py-3 " title="Mensalidade" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-money-bill fa"></i>
                </a>
            </li>
        </ul>
        <div class="dropdown border-top">
            <a href="#" class="d-flex align-items-center justify-content-center p-3 link-dark text-decoration-none dropdown-toggle" id="dropdownUser3" data-bs-toggle="dropdown" aria-expanded="false">

                <%
                    // Recupera o usuário logado da sessão
                    Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
                    String urlImagem = usuarioLogado != null ? usuarioLogado.getImgUsuario() : "default.jpg";
                %>

                <!-- Exibe a imagem do usuário logado -->
                <img src="img/Fts-Perfil/<%= urlImagem%>" class="rounded-circle avatar">

            </a>
            <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser3">
                <li><a class="dropdown-item" href="config.jsp"> <i class="fa-solid fa-gear drop-icon"></i> Configurações</a></li>
                <li><a class="dropdown-item" href="PerfilAluno"><i class="fa-solid fa-user drop-icon"></i> Perfil</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="RealizarLogout"><i class="fa-solid fa-right-from-bracket drop-exit"></i> Sair</a></li>
            </ul>
        </div>
    </div>
    <div class="pag ">
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="img/Creative-banner.png" class="d-block w-100 img-fluid" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="img/Kit-suple-banner.png" class="d-block w-100 img-fluid" alt="...">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Prévia</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Próximo</span>
            </button>
        </div>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Início</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Suplementos</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Calçados</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Calças e Shorts</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Meias e Acessórios</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Camisetas</a>
                        </li>
                    </ul>
                    <form class="d-flex pesq" role="search">
                        <div class="group">

                            <input placeholder="Search" type="search" class="input" id="search" onkeyup="searchTable()">
                            <i class="fa-solid fa-magnifying-glass iconsearch"></i>
                        </div>
                        <i class="fa-solid fa-cart-shopping position-relative cart" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"><span class="position-absolute top-0 start-100 translate-middle p-2 bg-danger rounded-circle"><p class="num-cart"></p></span></i>
                    </form>
                </div>
            </div>
        </nav>

        <div class="row mt-4" style="margin-left: 0.5rem; margin-right: 0.5rem;">
            <%@ page import="java.util.List" %>
            <%@ page import="br.com.zenitgymsystem.model.Produto" %>
            <%@ page import="br.com.zenitgymsystem.dao.ProdutoDAO" %>
            <%
                ProdutoDAO produtoDAO = new ProdutoDAO();
                List<Object> lista = produtoDAO.listar();
                if (lista.isEmpty()) {
                    out.println("<p>Nenhum produto encontrado.</p>");
                } else {
                    for (Object objeto : lista) {
                        Produto produto = (Produto) objeto;
                        String urlImagemP = produto.getImgProduto(); // Obtém o caminho da imagem
            %>
            <div class="col-md-3 mb-4">
                <a href="ProdutoPage.jsp?codProduto=<%= produto.getCodProduto()%>" style="text-decoration: none; color: inherit;">
                    <div class="card text-center custom-card">
                        <div class="card-h">
                            <img src="img/Produtos/<%= urlImagemP%>" class="card-img-top" alt="<%= produto.getNomeProduto()%>">
                        </div>
                        <div class="card-body">
                            <h5 class="card-titulo"><%= produto.getNomeProduto()%></h5>
                            <hr>
                            <p class="card-valor">R$<%= produto.getValorProduto()%></p>
                            <p class="card-pix"><span class="pix-color"><i class="fa-brands fa-pix"></i> R$<%= String.format("%.2f", produto.getValorProduto() * 0.95)%></span> no PIX</p>
                            <p>ou</p>
                            <span class="credit-color"><i class="fa-regular fa-credit-card"></i> 6x de R$<%= String.format("%.2f", produto.getValorProduto() / 6)%></span> sem juros</span>
                            <p class="card-qtd">Quantidade no estoque: <%= produto.getQtdProduto()%></p>
                            <a class="btn btn-outline-success"><i class="fa-solid fa-cart-plus"></i></a>
                            <a class="btn btn-outline-success">Compre Agora</a>
                        </div>
                    </div>
                </a>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</div>

<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasRightLabel">Meu Carrinho</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        ...
    </div>
    <hr>
    <div class="offcanvas-footer">
        <a class="btn btn-outline-danger">Excluir</a>
        <a class="btn btn-outline-success">Pagar Agora</a>
    </div>
</div>

<script>
            function searchTable() {
            let input = document.getElementById('search').value.toLowerCase();
                    let cards = document.querySelectorAll('.card'); // Seleciona os cards de produtos
                    cards.forEach(card = > {
                    let title = card.querySelector('.card-titulo').textContent.toLowerCase();
                            card.style.display = title.includes(input) ? '' : 'none'; // Exibe ou esconde o card baseado na pesquisa
                    });
            }
</script>

<%
} else if (usuario.getPerfilUsuario().equals("Administrador")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Administrador poderá vizualizar-->
<div class="page">
    <style type="text/css">
        body {
            overflow-x: hidden; /* Impede a rolagem horizontal */
        }
        .pag{
            padding: 0;  
        }
        .carousel-item {
            width: 100%;
            height: 550px;
        }
        .carousel-item img {
            width: 100%;
            height: 100%;
        }

        .navbar{
            background-color: #131313;
        }

        .navbar a {
            color: yellow;
        }
        .card-img-top {
            width: 150px;
            height: 150px;

        }
        .card-h {
            text-align: center;
            padding: 10px;
        }
        .card:hover{
            transform: scale(1.05);
        }
        .custom-card {
            width: 100%;
            border: 0;
            border-radius: 20px;
        }

        .card-titulo {
            font-size: 16px;
            margin: 8px 0;
            font-weight: bold;
        }

        .card-body hr {
            opacity: 0.2;
        }

        .card-valor {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 16px;
        }

        .card-pix {
            font-size: 20px;
        }

        .pix-color {
            color: red;
            font-weight: bold;
        }

        .credit-color {
            font-size: 16px;
        }
        .fa-credit-card{
            color: red;
        }

        .card-qtd {
            font-size: 12px;
            margin-bottom: 16px;
        }
        p{
            margin: 0;
        }
        .group {
            display: flex;
            line-height: 28px;
            align-items: center;
            position: relative;
            max-width: 190px;
        }

        .input {
            width: 100%;
            height: 40px;
            line-height: 28px;
            padding: 0 1rem;
            padding-left: 2.5rem;
            border: 2px solid transparent;
            border-radius: 8px;
            outline: none;
            background-color: #f3f3f4;
            color: #0d0c22;
            transition: .3s ease;
        }

        .input::placeholder {
            color: #9e9ea7;
        }

        .input:focus, input:hover {
            outline: none;
            border-color: rgba(254,255,0,0.4);
            background-color: #fff;
            box-shadow: 0 0 0 4px rgb(234 76 137 / 10%);
        }

        .icon {
            position: absolute;
            left: 1rem;
            fill: #9e9ea7;
            width: 1rem;
            height: 1rem;
            cursor: pointer;
        }
        .cart{
            cursor: pointer;
            padding: 10px;
            color: #feff00;
        }
        .pesq{
            text-align: center;
            align-items: center;
        }
        .num-cart{
            font-size: 10px;
            color: white;
        }
        .nav-link:hover{
            cursor:pointer;
        }
        .iconsearch{
            position: absolute;
            margin-left: 12px;
            cursor: pointer;
        }



        .nvl:hover{
            color: white;
        }
    </style>
    <div class="d-flex flex-column flex-shrink-0 sidebar" style="width: 4.5rem;">
        <ul class="nav nav-pills nav-flush flex-column mb-auto text-center nav-config">
            <li class="nav-item">
                <a href="home.jsp" class="nav-link  py-3 " aria-current="page" title="Início" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house fa"></i>
                </a>
            </li>
            <li>
                <a href="DashBoard.jsp" class="nav-link py-3 " title="Dashboard" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-chart-pie fa"></i>
                </a>
            </li>
            <li>
                <a href="ListarFinancas" class="nav-link py-3 " title="Financeiro" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-coins fa"></i>
                </a>
            </li>
            <li>
                <a href="HistPag.jsp" class="nav-link py-3 " title="Pagamentos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-money-bill fa"></i>
                </a>
            </li>
            <li>
                <a href="Loja.jsp" class="nav-link py-3 active" title="Loja & Produtos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-cart-shopping "></i>
                </a>
            </li>
            <li>
                <a href="ListarEEF" class="nav-link py-3 " title="Fornecedores" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-truck-fast fa"></i>
                </a>
            </li>
            <li>
                <a href="ListarUsuarios" class="nav-link py-3 " title="Usuários" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-users fa"></i>
                </a>
            </li>
            <li>
                <a href="AulasCRUD.jsp" class="nav-link py-3 " title="Aulas" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-book fa"></i>
                </a>
            </li>

            <li>
                <a href="EnviarNotificacao" class="nav-link py-3 " title="Notificações" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-bell fa"></i>
                </a>
            </li>

        </ul>
        <div class="dropdown border-top nav-config">
            <a href="#" class="d-flex align-items-center justify-content-center p-3 link-dark text-decoration-none dropdown-toggle" id="dropdownUser3" data-bs-toggle="dropdown" aria-expanded="false">
                <%
                    // Recupera o usuário logado da sessão
                    Usuario usuarioLogado = (Usuario) session.getAttribute("usuario");
                    String urlImagem = usuarioLogado != null ? usuarioLogado.getImgUsuario() : "default.jpg";
                %>
                <!-- Exibe a imagem do usuário logado -->
                <img src="img/Fts-Perfil/<%= urlImagem%>" class="rounded-circle avatar">
            </a>
            <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser3">
                <li><a class="dropdown-item" href="config.jsp"> <i class="fa-solid fa-gear drop-icon"></i> Configurações</a></li>
                <li><a class="dropdown-item" href="PerfilAdm"><i class="fa-solid fa-user drop-icon"></i> Perfil</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="RealizarLogout"><i class="fa-solid fa-right-from-bracket drop-exit"></i> Sair</a></li>
            </ul>
        </div>
    </div>
    <div class="pag">

        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="img/Creative-banner.png" class="d-block w-100 img-fluid" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="img/Kit-suple-banner.png" class="d-block w-100 img-fluid" alt="...">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Prévia</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Próximo</span>
            </button>
        </div>
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Início</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Suplementos</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Calçados</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Calças e Shorts</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Meias e Acessórios</a>
                        </li>
                        <li class="nav-item ">
                            <a class="nav-link nvl" >Camisetas</a>
                        </li>
                    </ul>
                    <a class="btn btn-outline-success" style="color: green; margin-right: 5px;" href="NovoProduto" data-bs-toggle="modal" data-bs-target="#modalNovoProduto"><i class="fa-solid  fa-plus"></i></a>
                    <form class="d-flex pesq" role="search">
                        <div class="group">
                            <input placeholder="Pesquisar..." type="search" class="input" id="search" onkeyup="searchTable()">
                            <i class="fa-solid fa-magnifying-glass iconsearch"></i>
                        </div>
                    </form>
                </div>
            </div>
        </nav>
        <div class="row mt-4" style="margin-left: 0.5rem; margin-right: 0.5rem;">
            <%@ page import="java.util.List" %>
            <%@ page import="br.com.zenitgymsystem.model.Produto" %>
            <%@ page import="br.com.zenitgymsystem.dao.ProdutoDAO" %>
            <%
                ProdutoDAO produtoDAO = new ProdutoDAO();
                List<Object> lista = produtoDAO.listar();
                for (Object objeto : lista) {
                    Produto produto = (Produto) objeto;
                    String urlImagemP = produto.getImgProduto(); // Obtém o caminho da imagem
            %>
            <div class="col-md-3 mb-4">
                <div class="card text-center custom-card">
                    <div class="card-h">
                        <img src="img/Produtos/<%= urlImagemP%>" class="card-img-top">
                    </div>
                    <div class="card-body">
                        <h5 class="card-titulo"><%= produto.getNomeProduto()%></h5>
                        <hr>
                        <p class="card-valor">R$<%= produto.getValorProduto()%></p>
                        <p class="card-pix"><span class="pix-color"><i class="fa-brands fa-pix"></i> R$<%= String.format("%.2f", produto.getValorProduto() * 0.95)%></span> no PIX</p>
                        <p>ou</p>
                        <span class="credit-color"><i class="fa-regular fa-credit-card"></i> 6x de R$<%= String.format("%.2f", produto.getValorProduto() / 6)%></span> sem juros</span>
                        <p class="card-qtd">Quantidade no estoque: <%= produto.getQtdProduto()%></p>

                        <a href="#" class="btn btn-outline-primary" title="Alterar produto" data-bs-toggle="modal" data-bs-target="#modalAlterarProduto" data-codproduto="<%= produto.getCodProduto()%>"
                           data-nomeproduto="<%= produto.getNomeProduto()%>"
                           data-descproduto="<%= produto.getDescProduto()%>"
                           data-valorproduto="<%= produto.getValorProduto()%>"
                           data-qtdproduto="<%= produto.getQtdProduto()%>"
                           data-categoriaproduto="<%= produto.getCategoriaProduto()%>"
                           data-imgproduto="<%= produto.getImgProduto()%>"><i class="fa-solid fa-pencil"></i></a>

                        <a href="#" class="btn btn-outline-dark" title="Aplicar desconto"><i class="fa-solid fa-tag"></i></a>
                        <a class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModalToggle" 
                           data-codproduto="<%= produto.getCodProduto()%>" 
                           data-nomeproduto="<%= produto.getNomeProduto()%>">
                            <i class="fa-solid fa-trash"></i>
                        </a>
                    </div>
                </div>
            </div>

            <%
                }
            %>
        </div>
    </div>
</div>
<div class="modal fade" id="modalNovoProduto" tabindex="-1" aria-labelledby="modalNovoProdutoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalNovoProdutoLabel">Cadastrar Novo Produto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6 d-flex justify-content-center align-items-center" >
                        <div id="apresentar-imagem" class="mostrarimg d-flex justify-content-center align-items-center" style="width:300px; height: 300px; border: 2px solid #999; border-radius: 10px;">
                            <img id="imgPreview" src="img/upload-placeholder.png" alt="Imagem do Produto" style="width: 250px; height: 250px;">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <form id="CadastrarProdutoForm" action="CadastrarProduto" method="post">
                            <div class="mb-3">
                                <label for="nomeProduto" class="form-label">Nome do Produto</label>
                                <input type="text" class="form-control" id="nomeProduto" name="nomeProduto" required>
                            </div>
                            <div class="mb-3">
                                <label for="descProduto" class="form-label">Descrição</label>
                                <textarea class="form-control" id="descProduto" name="descProduto" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="valorProduto" class="form-label">Preço</label>
                                <input type="number" class="form-control" id="valorProduto" name="valorProduto" step="0.01" required>
                            </div>
                            <div class="mb-3">
                                <label for="qtdProduto" class="form-label">Quantidade</label>
                                <input type="number" class="form-control" id="qtdProduto" name="qtdProduto" required>
                            </div>
                            <div class="md-3">
                                <label for="categoriaProduto" class="form-label">Categoria</label>
                                <select class="form-select" name="categoriaProduto" id="categoriaProduto">
                                    <option value="Calçados" ${produto.categoriaProduto == 'Calçados' ? 'selected' : ''}>Calçados</option>
                                    <option value="Calças e Shorts" ${produto.categoriaProduto == 'Calças e Shorts' ? 'selected' : ''}>Calças e Shorts</option>
                                    <option value="Camisetas" ${produto.categoriaProduto == 'Camisetas' ? 'selected' : ''}>Camisetas</option>
                                    <option value="Meias e Acessórios" ${produto.categoriaProduto == 'Meias e Acessórios' ? 'selected' : ''}>Meias e Acessórios</option>
                                    <option value="Suplementos Alimentares" ${produto.categoriaProduto == 'Suplementos Alimentares' ? 'selected' : ''}>Suplementos Alimentares</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="imgProduto" class="form-label">Imagem</label>
                                <input type="file" class="form-control" id="imgProduto" name="imgProduto" onchange="carregarImagem();">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="CadastrarProdutoForm">Salvar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Alterar Produto -->
<div class="modal fade" id="modalAlterarProduto" tabindex="-1" aria-labelledby="modalAlterarProdutoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAlterarProdutoLabel">Alterar Produto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="AlterarProdutoForm" action="AlterarProduto" method="post">
                    <input type="hidden" name="codProduto" id="codProdutoAlterar" value="" />

                    <div class="row">
                        <div class="col-md-6 d-flex justify-content-center align-items-center">
                            <div id="apresentar-imagem" class="mostrarimg d-flex justify-content-center align-items-center" style="width:300px; height: 300px; border: 2px solid #999; border-radius: 10px;">
                                <img id="imgPreview" src="img/upload-placeholder.png" alt="Imagem do Produto" style="width: 250px; height: 250px;">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="nomeProduto" class="form-label">Nome do Produto</label>
                                <input type="text" class="form-control" id="nomeProduto" name="nomeProduto" required>
                            </div>

                            <div class="mb-3">
                                <label for="descProduto" class="form-label">Descrição</label>
                                <textarea class="form-control" id="descProduto" name="descProduto" rows="3" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="valorProduto" class="form-label">Preço</label>
                                <input type="number" class="form-control" id="valorProduto" name="valorProduto" step="0.01" required>
                            </div>

                            <div class="mb-3">
                                <label for="qtdProduto" class="form-label">Quantidade</label>
                                <input type="number" class="form-control" id="qtdProduto" name="qtdProduto" required>
                            </div>

                            <div class="mb-3">
                                <label for="categoriaProduto" class="form-label">Categoria</label>
                                <select class="form-select" name="categoriaProduto" id="categoriaProduto">
                                    <option value="Calçados">Calçados</option>
                                    <option value="Calças e Shorts">Calças e Shorts</option>
                                    <option value="Camisetas">Camisetas</option>
                                    <option value="Meias e Acessórios">Meias e Acessórios</option>
                                    <option value="Suplementos Alimentares">Suplementos Alimentares</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="imgProduto" class="form-label">Imagem</label>
                                <input type="file" class="form-control" id="imgProduto" name="imgProduto">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="AlterarProdutoForm">Salvar Alterações</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal de Confirmação de Exclusão -->
<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel">Confirmação de Exclusão</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="ExcluirProduto" method="post">
                <div class="modal-body">
                    <p>Tem certeza de que deseja excluir o produto (<span id="nomeProduto"></span>)?</p>
                    <input type="hidden" name="codProduto" id="codProduto">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger">Excluir</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Script para preencher o modal com o nome e código do produto -->
<script>

            // Function to set the codProduto when a product is clicked
                    function setCodProduto(codProduto) {
                    // Update the hidden input field with the clicked product's ID
                    document.getElementById("codProdutoAlterar").value = codProduto;
                    }


            var exampleModalToggle = document.getElementById('exampleModalToggle');
                    exampleModalToggle.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget; // Botão que acionou o modal
                            var codProduto = button.getAttribute('data-codproduto');
                            var nomeProduto = button.getAttribute('data-nomeproduto');
                            // Atualiza os elementos no modal
                            var modalTitle = exampleModalToggle.querySelector('.modal-title');
                            var modalBody = exampleModalToggle.querySelector('.modal-body #nomeProduto');
                            var modalInput = exampleModalToggle.querySelector('.modal-body #codProduto');
                            modalTitle.textContent = 'Confirmação de Exclusão';
                            modalBody.textContent = nomeProduto;
                            modalInput.value = codProduto;
                    });
                    function searchTable() {
                    let input = document.getElementById('search').value.toLowerCase();
                            let table = document.getElementById('userTable');
                            let tr = table.getElementsByTagName('tr');
                            for (let i = 1; i < tr.length; i++) {  // Start from 1 to skip the header row
                    let td = tr[i].getElementsByTagName('td');
                            let found = false;
                            for (let j = 0; j < td.length; j++) {
                    if (td[j].textContent.toLowerCase().includes(input)) {
                    found = true;
                            break;
                    }
                    }
                    tr[i].style.display = found ? '' : 'none';
                    }
                    }

            // Função para converter imagem para base64
            function carregarImagem() {
            const fileInput = document.getElementById('imgProduto');
                    const preview = document.getElementById('imgPreview');
                    const file = fileInput.files[0];
                    const reader = new FileReader();
                    reader.onloadend = function () {
                    preview.src = reader.result;
                    }

            if (file) {
            reader.readAsDataURL(file);
            } else {
            preview.src = "img/upload-placeholder.jpg";
            }
            }
            // Função para auto preencher os campos do modal de alterar produto
            var modalAlterarProduto = document.getElementById('modalAlterarProduto');
                    modalAlterarProduto.addEventListener('show.bs.modal', function (event) {
                    // Obtém o botão que acionou o modal
                    var button = event.relatedTarget;
                            // Recupera os dados do produto armazenados nos atributos data- do botão
                            var codProduto = button.getAttribute('data-codproduto');
                            var nomeProduto = button.getAttribute('data-nomeproduto');
                            var descProduto = button.getAttribute('data-descproduto');
                            var valorProduto = button.getAttribute('data-valorproduto');
                            var qtdProduto = button.getAttribute('data-qtdproduto');
                            var categoriaProduto = button.getAttribute('data-categoriaproduto');
                            var imgProduto = button.getAttribute('data-imgproduto'); // O caminho da imagem

                            // Preenche os campos do modal com os valores recuperados
                            var modalBodyInputCod = modalAlterarProduto.querySelector('#codProdutoAlterar');
                            var modalBodyInputNome = modalAlterarProduto.querySelector('#nomeProduto');
                            var modalBodyInputDesc = modalAlterarProduto.querySelector('#descProduto');
                            var modalBodyInputValor = modalAlterarProduto.querySelector('#valorProduto');
                            var modalBodyInputQtd = modalAlterarProduto.querySelector('#qtdProduto');
                            var modalBodyInputCategoria = modalAlterarProduto.querySelector('#categoriaProduto');
                            var modalBodyImg = modalAlterarProduto.querySelector('#imgPreview'); // Para mostrar a imagem no modal

                            // Preenche os campos do modal com as informações do produto
                            modalBodyInputCod.value = codProduto;
                            modalBodyInputNome.value = nomeProduto;
                            modalBodyInputDesc.value = descProduto;
                            modalBodyInputValor.value = valorProduto;
                            modalBodyInputQtd.value = qtdProduto;
                            // Preenche a categoria (o valor já vem como string, então é só setar)
                            modalBodyInputCategoria.value = categoriaProduto;
                            // Preenche a imagem (se houver uma imagem associada ao produto)
                            if (imgProduto) {
                    modalBodyImg.src = "img/Produtos/" + imgProduto; // Supondo que a imagem esteja na pasta "img/Produtos/"
                    } else {
                    modalBodyImg.src = "img/upload-placeholder.png"; // Imagem padrão caso não haja imagem para o produto
                    }
                    });



</script>


<%
    }
%>
<jsp:include page="rodape.jsp" ></jsp:include>
