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
        .card {
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }
        .notification {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .notification.new {
            background-color: #f1f1f1;
        }
        .notification .icon {
            font-size: 1.5rem;
            margin-right: 10px;
        }
        .notification .content {
            display: inline-block;
        }
        .notification .content p {
            margin: 0;
        }
        .notification .content small {
            color: #888;
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
                <a href="Notificacao.jsp" class="nav-link py-3 active" title="Notificações" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-bell "></i>
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
        <div class="container" style="width: 100%;">
            <div class="col-12 mt-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-around">
                        <h3>Histórico de Notificações</h3>
                    </div>
                    <div class="card-body">
                        <!-- Exemplo de Notificação: Compras de Produtos -->
                        <div class="notification new">
                            <div class="icon">
                                <i class="fa-solid fa-cart-shopping"></i>
                            </div>
                            <div class="content">
                                <p><strong>Compra realizada!</strong></p>
                                <p>Você comprou um par de tênis para o treino.</p>
                                <small>1 hora atrás</small>
                            </div>
                        </div>

                        <!-- Exemplo de Notificação: Agendamento -->
                        <div class="notification">
                            <div class="icon">
                                <i class="fa-solid fa-calendar-check"></i>
                            </div>
                            <div class="content">
                                <p><strong>Agendamento confirmado!</strong></p>
                                <p>Seu agendamento para análise física foi confirmado para amanhã às 10h.</p>
                                <small>3 horas atrás</small>
                            </div>
                        </div>

                        <!-- Exemplo de Notificação: Treino próximo -->
                        <div class="notification">
                            <div class="icon">
                                <i class="fa-solid fa-dumbbell"></i>
                            </div>
                            <div class="content">
                                <p><strong>Treino próximo!</strong></p>
                                <p>Seu treino de hoje está agendado para as 18h. Prepare-se!</p>
                                <small>6 horas atrás</small>
                            </div>
                        </div>

                        <!-- Exemplo de Notificação: Vencimento de mensalidade -->
                        <div class="notification">
                            <div class="icon">
                                <i class="fa-solid fa-money-bill-wave"></i>
                            </div>
                            <div class="content">
                                <p><strong>Mensalidade vencida!</strong></p>
                                <p>Sua mensalidade de novembro está vencida. Por favor, efetue o pagamento.</p>
                                <small>1 dia atrás</small>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%
} else if (usuario.getPerfilUsuario().equals("Personal")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Personal poderá vizualizar-->
<div class="page">
    <style type="text/css">
        .notifications {
            background-color: #f9f9f9; /* Fundo claro */
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            overflow-y: auto;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .notification-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 10px 0;
            border-bottom: 1px solid #eaeaea;
        }

        .notification-item:last-child {
            border-bottom: none;
        }

        .notification-icon {
            font-size: 1.5rem;
        }

        .notification-item p {
            margin: 0;
            color: #2c3e50;
            font-size: 1rem;
        }

        .notification-time {
            margin-left: auto;
            font-size: 0.875rem;
            color: #7f8c8d;
            font-style: italic;
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
                <a href="ListarEventoCalPers" class="nav-link py-3 " title="Agenda" data-bs-toggle="tooltip" data-bs-placement="right">
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
                <a href="Notificacao.jsp" class="nav-link py-3 active" title="Notificações" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-bell "></i>
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
        <h2>Notificações</h2>
        <div class="notifications">
            <!-- Notificação de aluno adicionado à aula -->
            <div class="notification-item">
                <i class="fa-solid fa-user-plus notification-icon" style="color: #1abc9c;"></i>
                <p>O aluno <strong>João Silva</strong> foi adicionado à aula de <strong>Yoga</strong>.</p>
                <span class="notification-time">2 minutos atrás</span>
            </div>

            <div class="notification-item">
                <i class="fa-solid fa-user-plus notification-icon" style="color: #1abc9c;"></i>
                <p>O aluno <strong>Carla Santos</strong> foi adicionado à aula de <strong>Crossfit</strong>.</p>
                <span class="notification-time">5 minutos atrás</span>
            </div>

            <!-- Notificação de análise agendada -->
            <div class="notification-item">
                <i class="fa-solid fa-calendar-check notification-icon" style="color: #f39c12;"></i>
                <p>Uma análise foi agendada para o aluno <strong>Maria Oliveira</strong> no dia <strong>25/11 às 14h</strong>.</p>
                <span class="notification-time">10 minutos atrás</span>
            </div>

            <div class="notification-item">
                <i class="fa-solid fa-calendar-check notification-icon" style="color: #f39c12;"></i>
                <p>Uma análise foi agendada para o aluno <strong>Thiago Costa</strong> no dia <strong>26/11 às 10h</strong>.</p>
                <span class="notification-time">15 minutos atrás</span>
            </div>

            <!-- Notificação de treino criado -->
            <div class="notification-item">
                <i class="fa-solid fa-dumbbell notification-icon" style="color: #3498db;"></i>
                <p>Um novo treino foi criado para o aluno <strong>Lucas Mendes</strong>.</p>
                <span class="notification-time">30 minutos atrás</span>
            </div>

            <div class="notification-item">
                <i class="fa-solid fa-dumbbell notification-icon" style="color: #3498db;"></i>
                <p>Um novo treino foi criado para o aluno <strong>Fernanda Lima</strong>.</p>
                <span class="notification-time">35 minutos atrás</span>
            </div>

            <!-- Notificação de novo aluno -->
            <div class="notification-item">
                <i class="fa-solid fa-star notification-icon" style="color: #e74c3c;"></i>
                <p>Você ganhou um novo aluno: <strong>Ana Costa</strong>.</p>
                <span class="notification-time">1 hora atrás</span>
            </div>

            <div class="notification-item">
                <i class="fa-solid fa-star notification-icon" style="color: #e74c3c;"></i>
                <p>Você ganhou um novo aluno: <strong>Ricardo Almeida</strong>.</p>
                <span class="notification-time">2 horas atrás</span>
            </div>
        </div>
    </div>


</div>

<%
} else if (usuario.getPerfilUsuario().equals("Administrador")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Administrador poderá vizualizar-->
<div class="page">
    <style type="text/css">
        .fa {
            color: yellow;
        }

        .fa:hover {
            color: #ffffff;
        }

        .nav-pills .nav-link.active {
            background-color: #feff00;
            color: black;
        }

        .page {
            display: flex;
            height: 100%;
        }

        .pag {
            display: block;
            width: 100%;
            padding: 15px;
            margin-left: 4.5rem;
            min-height: 100vh;
            background-color: #1B1C1D;

        }

        .sidebar {
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #131313;
        }

        .dropdown-item .drop-icon,
        .dropdown-item .drop-exit {
            color: black;
            transition: color 0.3s ease;
        }

        .dropdown-item:hover .drop-exit {
            color: red;
        }

        .dropdown-item:hover .drop-icon {
            color: #feff00;
        }

        .avatar {
            width: 25px;
            height: 25px;
            border: 0;
            padding: 0;
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
                <a href="Notificacao.jsp" class="nav-link py-3 active" title="Notificações" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-bell "></i>
                </a>
            </li>

        </ul>
        <div class="dropdown border-top nav-config" >
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

    </div>
</div>
<%
    }
%>
<jsp:include page="rodape.jsp" ></jsp:include>