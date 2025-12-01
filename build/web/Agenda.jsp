<%@page import="br.com.zenitgymsystem.model.Analise"%>
<%@page import="java.util.Map"%>
<%@page import="br.com.zenitgymsystem.model.Aula"%>
<%@page import="java.util.List"%>
<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="cabecalho.jsp"></jsp:include>
<%
    HttpSession sessao = request.getSession(false);
    Usuario usuario = (Usuario) sessao.getAttribute("usuario");
    if (usuario.getPerfilUsuario().equals("Aluno")) {
%>
<div class="page">
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        body {
            overflow-x: hidden;
            font-family: sans-serif;
        }

        .calendario {
            width: 100%;
            height: 700px;
            margin-left: 1rem;
            margin-top: 1rem;
        }

        .calendario a {
            color: black;
            text-decoration: none;
        }

        .fc-toolbar-title {
            text-transform: uppercase;
        }

        .custom-card {
            border: 1px solid #ccc;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .card-titulo {
            font-size: 1.2rem;
            font-weight: bold;
        }

        .antesletras {
            font-size: 12px;
            display: inline-block;
        }

        .card-valor,
        .card-musc {
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
        }

        .font-variavel {
            font-family: 'Afacad Flux', sans-serif;
        }

        .fc-daygrid-day-frame:hover {
            background-color: #feff00;
        }

        .card {
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            border: 2px;
        }

        /* Estilos do Modal */
        .modal {
            display: none;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* Estilos do lado direito para mostrar o evento */
        .evento-detalhes {
            background-color: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 1rem;
            margin-left: 1rem;
        }

        .evento-detalhes h3 {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .evento-detalhes p {
            font-size: 1.2rem;
        }

        /* Flexbox Layout */
        .container {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 2rem;
        }

        #calendar {
            width: 100%;
            height: 800px;
        }

        #eventoDetalhes {
            width: 100%;
            display: block;
        }
        /* Remover flex-direction no card */
        .card {
            display: grid;  /* Usando grid para estruturar as colunas */
            grid-template-columns: 70% 30%; /* 70% para o calendário, 30% para os detalhes */
            gap: 1rem;  /* Espaço entre as colunas */
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
                <a href="ListarEventoCal" class="nav-link py-3 active" title="Agenda" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-calendar-days "></i>
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
        <div class="container" style="width: 100%;">
            <div class="col-12">
                <div class="card">
                    <!-- Calendário -->
                    <div id="calendar" class="calendario"></div>

                    <!-- Detalhes do evento (inicialmente escondido) -->
                    <div id="eventoDetalhes" class="evento-detalhes" >
                        <h3 id="eventoTitulo"></h3>
                        <p><strong>Início:</strong> <span id="eventoInicio"></span></p>
                        <p><strong>Fim:</strong> <span id="eventoFim"></span></p>
                        <p><strong>Descrição:</strong> <span id="eventoDescricao"></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- Modal para exibir mais detalhes -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Detalhes do Evento</h2>
        <p><strong>Título:</strong> <span id="modalTitulo"></span></p>
        <p><strong>Descrição:</strong> <span id="modalDescricao"></span></p>
        <p><strong>Data de Início:</strong> <span id="modalInicio"></span></p>
        <p><strong>Data de Fim:</strong> <span id="modalFim"></span></p>
    </div>
</div>
<!-- Inicializando o calendário -->
<script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
                var eventos = [
    <%
            List<Map<String, String>> eventos = (List<Map<String, String>>) request.getAttribute("eventos");
            for (int i = 0; i < eventos.size(); i++) {
                Map<String, String> evento = eventos.get(i);
    %>
                {
                title: "<%= evento.get("title")%>",
                        start: "<%= evento.get("start")%>",
                        end: "<%= evento.get("end")%>",
                        description: "<%= evento.get("description")%>",
                        id: "<%= evento.get("id")%>"  // Adiciona um ID único ao evento
                }<%= (i < eventos.size() - 1) ? "," : ""%>
    <%
            }
    %>
                ];

        $('#calendar').fullCalendar({
            locale: 'pt-br',
            events: eventos, // eventos que você já tem
            eventClick: function (event) {
                // Exibe os detalhes do evento
                $('#eventoTitulo').text(event.title);
                $('#eventoInicio').text(event.start.format('DD/MM/YYYY HH:mm'));
                $('#eventoFim').text(event.end ? event.end.format('DD/MM/YYYY HH:mm') : 'Não definido');
                $('#eventoDescricao').text(event.description);
                $('#eventoDetalhes').show(); // Exibe a div de detalhes
            }
        });


        // Função para fechar o modal
        var modal = document.getElementById("myModal");
        var span = document.getElementsByClassName("close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    });

</script>

<%
} else if (usuario.getPerfilUsuario().equals("Personal")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Personal poderá vizualizar-->
<div class="page">
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        body {
            overflow-x: hidden;
            font-family: sans-serif;
        }

        .calendario {
            width: 100%;
            height: 700px;
            margin-left: 1rem;
            margin-top: 1rem;
        }

        .calendario a {
            color: black;
            text-decoration: none;
        }

        .fc-toolbar-title {
            text-transform: uppercase;
        }

        .custom-card {
            border: 1px solid #ccc;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .card-titulo {
            font-size: 1.2rem;
            font-weight: bold;
        }

        .antesletras {
            font-size: 12px;
            display: inline-block;
        }

        .card-valor,
        .card-musc {
            font-size: 1.4rem;
            margin-bottom: 0.5rem;
        }

        .font-variavel {
            font-family: 'Afacad Flux', sans-serif;
        }

        .fc-daygrid-day-frame:hover {
            background-color: #feff00;
        }

        .card {
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            border: 2px;
        }

        /* Estilos do Modal */
        .modal {
            display: none;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* Estilos do lado direito para mostrar o evento */
        .evento-detalhes {
            background-color: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 1rem;
            margin-left: 1rem;
        }

        .evento-detalhes h3 {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .evento-detalhes p {
            font-size: 1.2rem;
        }

        /* Flexbox Layout */
        .container {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 2rem;
        }

        #calendar {
            width: 100%;
            height: 800px;
        }

        #eventoDetalhes {
            width: 100%;
            display: block;
        }
        /* Remover flex-direction no card */
        .card {
            display: grid;  /* Usando grid para estruturar as colunas */
            grid-template-columns: 70% 30%; /* 70% para o calendário, 30% para os detalhes */
            gap: 1rem;  /* Espaço entre as colunas */
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
                <a href="ListarEventoCalPers" class="nav-link py-3 active" title="Agenda" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-calendar-days "></i>
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
                <a href="EnviarNotificacao" class="nav-link py-3 " title="FeedBack" data-bs-toggle="tooltip" data-bs-placement="right">
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
        <div class="container" style="width: 100%;">
            <div class="col-12">
                <div class="card">
                    <!-- Calendário -->
                    <div id="calendar" class="calendario"></div>

                    <!-- Detalhes do evento (inicialmente escondido) -->
                    <div id="eventoDetalhes" class="evento-detalhes" >
                        <h3 id="eventoTitulo"></h3>
                        <p><strong>Início:</strong> <span id="eventoInicio"></span></p>
                        <p><strong>Fim:</strong> <span id="eventoFim"></span></p>
                        <p><strong>Descrição:</strong> <span id="eventoDescricao"></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- Modal para exibir mais detalhes -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Detalhes do Evento</h2>
        <p><strong>Título:</strong> <span id="modalTitulo"></span></p>
        <p><strong>Descrição:</strong> <span id="modalDescricao"></span></p>
        <p><strong>Data de Início:</strong> <span id="modalInicio"></span></p>
        <p><strong>Data de Fim:</strong> <span id="modalFim"></span></p>
    </div>
</div>
<!-- Inicializando o calendário -->
<script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
                var eventos = [
    <%
            List<Map<String, String>> eventos = (List<Map<String, String>>) request.getAttribute("eventos");
            for (int i = 0; i < eventos.size(); i++) {
                Map<String, String> evento = eventos.get(i);
    %>
                {
                title: "<%= evento.get("title")%>",
                        start: "<%= evento.get("start")%>",
                        end: "<%= evento.get("end")%>",
                        description: "<%= evento.get("description")%>",
                        id: "<%= evento.get("id")%>"  // Adiciona um ID único ao evento
                }<%= (i < eventos.size() - 1) ? "," : ""%>
    <%
            }
    %>
                ];

        $('#calendar').fullCalendar({
            locale: 'pt-br',
            events: eventos, // eventos que você já tem
            eventClick: function (event) {
                // Exibe os detalhes do evento
                $('#eventoTitulo').text(event.title);
                $('#eventoInicio').text(event.start.format('DD/MM/YYYY HH:mm'));
                $('#eventoFim').text(event.end ? event.end.format('DD/MM/YYYY HH:mm') : 'Não definido');
                $('#eventoDescricao').text(event.description);
                $('#eventoDetalhes').show(); // Exibe a div de detalhes
            }
        });


        // Função para fechar o modal
        var modal = document.getElementById("myModal");
        var span = document.getElementsByClassName("close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    });

</script>

<%
    }
%>
<jsp:include page="rodape.jsp" ></jsp:include>