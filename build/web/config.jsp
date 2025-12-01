<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"></jsp:include>
<%
    HttpSession sessao = request.getSession(false);
    Usuario usuario = (Usuario) sessao.getAttribute("usuario");
    if (usuario.getPerfilUsuario().equals("Aluno")) {
%>
<!--Dentro deste parametro colocar apenas o que deve conter para a view do Aluno-->

<div class="page">
    <style type="text/css">

        h1, h2 {
            color: #333; /* Cor escura para os títulos */
        }
        section {
            margin-bottom: 20px; /* Espaçamento entre seções */
            padding: 15px;
            background: #ffffff; /* Fundo branco para seções */
            border-radius: 8px; /* Bordas arredondadas nas seções */
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1); /* Sombra suave nas seções */
        }
        label {
            display: block;
            margin: 10px 0 5px; /* Margem para as labels */
        }
        input[type="checkbox"] {
            margin-right: 10px; /* Espaçamento entre checkbox e label */
        }
        select {
            width: 100%; /* Largura total para o seletor */
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
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
                <a href="Loja.jsp" class="nav-link py-3  " title="Loja & Produtos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-cart-shopping fa"></i>
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
        <main>
            <header>
                <h1>Configurações</h1>
            </header>

            <section>
                <h2>Preferências de Notificação</h2>
                <label><input type="checkbox"> Receber e-mails sobre promoções</label>
                <label><input type="checkbox"> Lembretes de treinos</label>
                <label><input type="checkbox"> Alertas de vencimento de matrícula</label>
            </section>

            <section>
                <h2>Configurações de Conta</h2>
                <button class=" btn btn-outline-danger">Desativar Conta</button>
                <button class="btn btn-outline-primary">Visualizar Histórico de Atividades</button>
            </section>

            <section>
                <h2>Configurações de Pagamento</h2>
                <label for="metodoPagamento">Método de pagamento:</label>
                <select id="metodoPagamento">
                    <option>Cartão de Crédito</option>
                    <option>Débito</option>
                    <option>Boleto</option>
                    <option>PIX</option>
                </select>
            </section>

            <section>
                <h2>Segurança</h2>
                <label><input type="checkbox"> Ativar autenticação em dois fatores</label>
                <button class="btn btn-outline-warning">Deslogar de todos os dispositivos</button>
            </section>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button class="btn btn-outline-success" id="sendButton" onclick="window.history.back();">Salvar Alterações</button>
            </div>
        </main>
    </div>
</div>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="myToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">Notificação</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <i class="fa-regular fa-circle-check" style="color: green;" ></i> Alterações realizadas com sucesso!
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#sendButton').click(function () {
            var toast = new bootstrap.Toast(document.getElementById('myToast'));
            toast.show();
        });
    });
</script>


<%
} else if (usuario.getPerfilUsuario().equals("Personal")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Personal poderá vizualizar-->
<div class="page">
    <style type="text/css">

        h1, h2 {
            color: #333; /* Cor escura para os títulos */
        }
        section {
            margin-bottom: 20px; /* Espaçamento entre seções */
            padding: 15px;
            background: #ffffff; /* Fundo branco para seções */
            border-radius: 8px; /* Bordas arredondadas nas seções */
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1); /* Sombra suave nas seções */
        }
        label {
            display: block;
            margin: 10px 0 5px; /* Margem para as labels */
        }
        input[type="checkbox"] {
            margin-right: 10px; /* Espaçamento entre checkbox e label */
        }
        select {
            width: 100%; /* Largura total para o seletor */
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
    </style>
    <div class="d-flex flex-column flex-shrink-0 sidebar" style="width: 4.5rem;">
        <ul class="nav nav-pills nav-flush flex-column mb-auto text-center nav-config">
            <li class="nav-item">
                <a href="home.jsp" class="nav-link py-3 " aria-current="page" title="Início" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house fa"></i>
                </a>
            </li>

            <li>
                <a href="ListarAlunosPers" class="nav-link py-3 " title="Alunos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-users fa"></i>
                </a>
            </li>
            <li>
                <a href="ListarEventoCalPers" class="nav-link py-3" title="Agenda" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-calendar-days fa"></i>
                </a>
            </li>
            <li>
                <a href="Treinos.jsp" class="nav-link py-3 " title="Treinos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-dumbbell fa"></i>
                </a>
            </li>
            <li>
                <a href="ListarAlunoAula" class="nav-link py-3 " title="Aulas" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-book fa"></i>
                </a>
            </li>
            <li>
                <a href="ListarAlunoPersonal" class="nav-link py-3 " title="Avaliação Física" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-child fa"></i>
                </a>
            </li>
            <li>
                <a href="Notificacao.jsp" class="nav-link py-3 " title="FeedBack" data-bs-toggle="tooltip" data-bs-placement="right">
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
                <li><a class="dropdown-item" href="PerfilPersonal"><i class="fa-solid fa-user drop-icon"></i> Perfil</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="RealizarLogout"><i class="fa-solid fa-right-from-bracket drop-exit"></i> Sair</a></li>
            </ul>
        </div>
    </div>
    <div class="pag">

        <main>
            <header>
                <h1>Configurações</h1>
            </header>

            <section>
                <h2>Preferências de Notificação</h2>
                <label><input type="checkbox"> Receber e-mails sobre promoções</label>
                <label><input type="checkbox"> Lembretes de treinos</label>
                <label><input type="checkbox"> Alertas de vencimento de matrícula</label>
            </section>

            <section>
                <h2>Configurações de Conta</h2>
                <button class=" btn btn-outline-danger">Desativar Conta</button>
                <button class="btn btn-outline-primary">Visualizar Histórico de Atividades</button>
            </section>

            <section>
                <h2>Configurações de Pagamento</h2>
                <label for="metodoPagamento">Método de pagamento:</label>
                <select id="metodoPagamento">
                    <option>Cartão de Crédito</option>
                    <option>Débito</option>
                    <option>Boleto</option>
                    <option>PIX</option>
                </select>
            </section>

            <section>
                <h2>Segurança</h2>
                <label><input type="checkbox"> Ativar autenticação em dois fatores</label>
                <button class="btn btn-outline-warning">Deslogar de todos os dispositivos</button>
            </section>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button class="btn btn-outline-success" id="sendButton" onclick="window.history.back();" >Salvar Alterações</button>
            </div>
        </main>

    </div>
    <div class="toast-container position-fixed top-0 end-0 p-3">
        <div id="myToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto">Notificação</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                <i class="fa-regular fa-circle-check" style="color: green;" ></i> Alterações realizadas com sucesso!
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#sendButton').click(function () {
            var toast = new bootstrap.Toast(document.getElementById('myToast'));
            toast.show();
            });
    });
</script>

<%
} else if (usuario.getPerfilUsuario().equals("Administrador")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Administrador poderá vizualizar-->
<div class="page">
    <style type="text/css">
        h1, h2 {
            color: #333; /* Cor escura para os títulos */
        }
        section {
            margin-bottom: 20px; /* Espaçamento entre seções */
            padding: 15px;
            background: #ffffff; /* Fundo branco para seções */
            border-radius: 8px; /* Bordas arredondadas nas seções */
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1); /* Sombra suave nas seções */
        }
        label {
            display: block;
            margin: 10px 0 5px; /* Margem para as labels */
        }
        input[type="checkbox"] {
            margin-right: 10px; /* Espaçamento entre checkbox e label */
        }
        select {
            width: 100%; /* Largura total para o seletor */
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn-action {
            background-color: #feff00;
            color: black;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .btn-action:hover {
            background-color: #131313;
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
                <a href="Loja.jsp" class="nav-link py-3 " title="Loja & Produtos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-cart-shopping fa"></i>
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
        <main>
            <header>
                <h1>Configurações do Administrador</h1>
            </header>

            <!-- Seção de Preferências de Notificação -->
            <section>
                <h2>Preferências de Notificação</h2>
                <label><input type="checkbox"> Notificar sobre novos registros de usuários (Aluno, Personal, Administrador)</label>
                <label><input type="checkbox"> Alertas de pagamentos pendentes</label>
                <label><input type="checkbox"> Notificar sobre novos fornecedores e entregas</label>
                <label><input type="checkbox"> Notificar sobre alterações na loja e produtos</label>
            </section>

            <!-- Seção de Gerenciamento de Usuários -->
            <section>
                <h2>Gerenciamento de Usuários</h2>
                <label><input type="checkbox"> Permitir envio de convites para novos usuários</label>
                <label><input type="checkbox"> Notificar sobre novos usuários registrados</label>
                <button class="btn btn-outline-primary">Gerenciar Usuários</button>
                <button class="btn btn-outline-info">Alterar Perfil do Administrador</button>
            </section>
            
            <!-- Seção de Configurações Financeiras -->
            <section>
                <h2>Gerenciamento Financeiro</h2>
                <button class="btn btn-outline-primary">Visualizar Relatórios Financeiros</button>
                <button class="btn btn-outline-warning">Gerenciar Pagamentos de Fornecedores</button>
                <button class="btn btn-outline-success">Alterar Configurações Financeiras</button>
            </section>

            <!-- Seção de Configurações de Loja -->
            <section>
                <h2>Gerenciamento da Loja</h2>
                <button class="btn btn-outline-primary">Gerenciar Produtos da Loja</button>
                <button class="btn btn-outline-info">Alterar Parâmetros de Preço</button>
                <button class="btn btn-outline-warning">Modificar Categorias de Produtos</button>
                <button class="btn btn-outline-success">Gerenciar Ofertas e Promoções</button>
            </section>

            <!-- Seção de Segurança -->
            <section>
                <h2>Segurança</h2>
                <label><input type="checkbox"> Ativar autenticação em dois fatores</label>
                <button class="btn btn-outline-warning">Deslogar de todos os dispositivos</button>
            </section>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button class="btn btn-outline-success" id="sendButton" onclick="window.history.back();">Salvar Alterações</button>
            </div>
        </main>
    </div>
</div>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="myToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">Notificação</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <i class="fa-regular fa-circle-check" style="color: green;"></i> Alterações realizadas com sucesso!
        </div>
    </div>
</div>-
<script>
    $(document).ready(function () {
        $('#sendButton').click(function () {
            var toast = new bootstrap.Toast(document.getElementById('myToast'));
            toast.show();
        });
    });
</script>

<%
    }
%>
<jsp:include page="rodape.jsp" ></jsp:include>