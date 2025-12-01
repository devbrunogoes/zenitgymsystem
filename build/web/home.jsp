
<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<jsp:include page="cabecalho.jsp"></jsp:include>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Feito essa condição para saber se o usuario é Cliente ou funcionário e qual View ele vai entrar -->
<%
    HttpSession sessao = request.getSession(false);
    Usuario usuario = (Usuario) sessao.getAttribute("usuario");
    if (usuario.getPerfilUsuario().equals("Aluno")) {
%>
<!--Dentro deste parametro colocar apenas o que deve conter para a view do Aluno-->
<div class="page">
    <style type="text/css">
        .pag {
            background-attachment: fixed;
            background-size: cover;
            background-image: url(img/backgroud-home.jpg);
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;

        }

        .welcome-container {
            background-color: #131313; /* Faixa preta */
            color: white; /* Texto branco */
            width: 100%; /* Ocupa toda a largura */
            padding: 30px 20px;
            text-align: center;
            border-radius: 10px;
        }

        .welcome-message h1 {
            color: #feff00; /* Texto com destaque amarelo */
            font-size: 2.5rem;
            font-weight: bold;
            margin: 10px 0;
        }

        .welcome-message p {
            font-size: 1.2rem;
            margin: 15px 0;
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
        <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
            <li class="nav-item">
                <a href="home.jsp" class="nav-link  py-3 active" aria-current="page" title="Inicio" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house "></i>
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
        <div class="welcome-container">
            <div class="welcome-message">
                <h1>Olá, <%= usuarioLogado.getNomeUsuario()%>!</h1>
                <p>Bem-vindo(a) ao seu painel de aluno. Estamos felizes em ter você com a gente em sua jornada de saúde e bem-estar.</p>
                <p>Aqui você pode acessar suas aulas, verificar a agenda de treinos, consultar suas mensalidades, explorar a loja e muito mais!</p>
                <p>Que tal começar com sua agenda de treinos? Clique abaixo para conferir os horários das aulas e organizar seus treinos.</p>
                <a href="ListarEventoCal" class="btn-action">Ver minha agenda</a>
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
        .pag {
            background-attachment: fixed;
            background-size: cover;
            background-image: url(img/backgroud-home.jpg);
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .welcome-container {
            background-color: #131313; /* Faixa preta */
            color: white; /* Texto branco */
            width: 100%; /* Ocupa toda a largura */
            padding: 30px 20px;
            text-align: center;
            border-radius: 10px;
        }

        .welcome-message h1 {
            color: #feff00; /* Texto com destaque amarelo */
            font-size: 2.5rem;
            font-weight: bold;
            margin: 10px 0;
        }

        .welcome-message p {
            font-size: 1.2rem;
            margin: 15px 0;
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
                <a href="home.jsp" class="nav-link active py-3 " aria-current="page" title="Início" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house"></i>
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
        <div class="welcome-container">
            <div class="welcome-message">
                <h1>Olá, <%= usuarioLogado.getNomeUsuario()%>!</h1>
                <p>Bem-vindo(a) ao seu painel de personal trainer! Nosso sistema foi desenvolvido para proporcionar uma experiência fluida e eficiente, ajudando você a gerenciar seus alunos e treinamentos de forma prática e organizada. Com ferramentas simples e poderosas, você pode monitorar o progresso de cada aluno, planejar treinos personalizados e otimizar o seu tempo para oferecer um atendimento de alta qualidade.</p>
                <p>A plataforma é pensada para facilitar a sua interação com os alunos, permitindo um acompanhamento detalhado e constante das metas de cada um. Ela também oferece recursos que tornam o agendamento e a organização das aulas muito mais fáceis, garantindo que você tenha mais tempo para focar no que realmente importa: a evolução dos seus alunos.</p>
                <p>Com o nosso sistema, você tem em mãos a capacidade de transformar o acompanhamento de seus alunos, promovendo resultados incríveis e alcançando novos patamares de excelência no seu trabalho como personal trainer.</p>
            </div>
        </div>
    </div>
</div>



<%
} else {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Administrador poderá vizualizar-->
<div class="page">
    <style type="text/css">
        .pag {
            background-attachment: fixed;
            background-size: cover;
            background-image: url(img/backgroud-home.jpg);
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .welcome-container {
            background-color: #131313; /* Faixa preta */
            color: white; /* Texto branco */
            width: 100%; /* Ocupa toda a largura */
            padding: 30px 20px;
            text-align: center;
            border-radius: 10px;
        }

        .welcome-message h1 {
            color: #feff00; /* Texto com destaque amarelo */
            font-size: 2.5rem;
            font-weight: bold;
            margin: 10px 0;
        }

        .welcome-message p {
            font-size: 1.2rem;
            margin: 15px 0;
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
                <a href="home.jsp" class="nav-link active py-3 " aria-current="page" title="Início" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house"></i>
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
        <div class="welcome-container">
            <div class="welcome-message">
                <h1>Olá, <%= usuarioLogado.getNomeUsuario()%>!</h1>
                <p>Bem-vindo(a) ao sistema de gestão da plataforma! Este sistema foi desenvolvido para fornecer a você, como administrador, todas as ferramentas necessárias para garantir uma operação eficiente e sem falhas. Com uma interface intuitiva e fácil de usar, você tem o controle total sobre a administração de usuários, recursos e dados financeiros.</p>
                <p>A plataforma permite um gerenciamento centralizado, onde você pode tomar decisões rápidas e informadas, com o suporte de relatórios detalhados, controle de recursos e comunicação eficaz com os demais usuários. Seu papel aqui é essencial para manter a qualidade e o sucesso da nossa operação, promovendo uma experiência excepcional para todos os usuários.</p>
                <p>Estamos aqui para apoiar você no gerenciamento de todas as áreas da plataforma e ajudá-lo(a) a alcançar o melhor desempenho possível para a organização. Vamos começar sua jornada de administração com todas as ferramentas certas ao seu alcance!</p>
            </div>
        </div>
    </div>
</div>





<%
    }
%>

<jsp:include page="rodape.jsp" ></jsp:include>