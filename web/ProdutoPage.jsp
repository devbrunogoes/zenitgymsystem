<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page import="br.com.zenitgymsystem.dao.ProdutoDAO"%>
<%@page import="br.com.zenitgymsystem.model.Produto"%>
<%@ page import="javax.servlet.jsp.JspWriter" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"/>
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
        

        /* Estilos para a seção de detalhes do produto */
        .produto-details {
            display: flex; /* Usar Flexbox para disposição lado a lado */
            margin-top: 50px;
            justify-content: center;
        }
        .produto-details img {
            max-width: 500px; /* Largura máxima da imagem */
            height: auto; /* Altura automática para manter a proporção */
            border-radius: 8px; /* Bordas arredondadas para a imagem */
            margin-right: 20px; /* Espaço entre a imagem e o texto */
        }
        .produto-info {
            display: flex;
            flex-direction: column; /* Informações em coluna */
            justify-content: center; /* Centraliza verticalmente */
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
                <a href="home.jsp" class="nav-link  py-3 " aria-current="page" title="Inicio" data-bs-toggle="tooltip" data-bs-placement="right">
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
                            <a href="Loja.jsp" class="nav-link nvl"><i class="fa-solid fa-chevron-left"></i> Voltar</a>
                        </li>
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
       
        <%
            // Captura o código do produto da URL
            String codProduto = request.getParameter("codProduto");
            Produto produto = null; // Define fora do bloco try para ser acessível depois

            if (codProduto != null) {
                try {
                    int codProdutoInt = Integer.parseInt(codProduto); // Converte o código para int
                    ProdutoDAO produtoDAO = new ProdutoDAO();
                    produto = (Produto) produtoDAO.consultar(codProdutoInt); // Consulta o produto pelo código
                } catch (NumberFormatException e) {
                    out.println("<p>Formato inválido para o código do produto.</p>");
                }
            } else {
                out.println("<p>Código do produto não fornecido.</p>");
            }
        %>

        <% if (produto != null) {%>
        <!-- Exibe os detalhes do produto -->
        <div class="produto-details">
            <img src="img/Produtos/<%= produto.getImgProduto()%>" alt="<%= produto.getNomeProduto()%>" />
            <div class="produto-info">
                <h1><%= produto.getNomeProduto()%></h1>
                <p>Preço: R$ <%= produto.getValorProduto()%></p>
                <p>Descrição: <%= produto.getDescProduto()%></p>
                <p>Quantidade no estoque: <%= produto.getQtdProduto()%></p>
                <a href="carrinho.jsp?add=<%= produto.getCodProduto()%>" class="btn btn-success">Adicionar ao Carrinho</a>
            </div>
        </div>
        <% } else { %>
        <p>Produto não encontrado.</p>
        <% }%>
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
        cards.forEach(card => {
            let title = card.querySelector('.card-titulo').textContent.toLowerCase();
            card.style.display = title.includes(input) ? '' : 'none'; // Exibe ou esconde o card baseado na pesquisa
        });
    }
</script>
<jsp:include page="rodape.jsp"/>
