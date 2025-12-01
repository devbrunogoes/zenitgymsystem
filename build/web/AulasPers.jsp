<%@page import="br.com.zenitgymsystem.model.Aluno"%>
<%@page import="br.com.zenitgymsystem.model.Aluno"%>
<%@page import="java.util.List"%>
<%@page import="br.com.zenitgymsystem.dao.AulaDAO"%>
<%@page import="br.com.zenitgymsystem.model.Aula"%>
<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"></jsp:include>
    <div class="page">
        <style type="text/css">

            .card {
                border-radius: 8px;
                margin-bottom: 20px;
                box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            }
            .card-aula{
                height: 400px;
                border-radius: 8px;
            }
            .card-body {
                border-radius: 8px;
                padding: 20px;
            }

            .card-title {
                font-weight: bold;
            }
            .card-header{
                background-color: #2c2f33;
            }

            .btn-warning {
                background-color: #feff00;
                color: black;
                transition: all 0.3s ease;
            }

            .btn-warning:hover {
                background-color: #ffd700;
                color: white;
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
                    <a href="ListarAlunoAula" class="nav-link py-3 active" title="Aulas" data-bs-toggle="tooltip" data-bs-placement="right">
                        <i class="fa-solid fa-book "></i>
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
        <div class="container" style="width: 100%;">
            <div class="col-12 mt-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-around">
                        <h2 class="text-white">Aulas Disponíveis</h2>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Coluna da esquerda: Listagem de Aulas -->
                            <div class="col-md-12">
                                <div class="row row-cols-1 row-cols-md-4 g-4">
                                    <%
                                        // Realizando o casting para as listas específicas
                                        List<Aula> aulas = (List<Aula>) request.getAttribute("aulas");
                                        List<Aluno> listaAlunos = (List<Aluno>) request.getAttribute("listaAlunos");

                                        if (aulas != null && !aulas.isEmpty()) {
                                            for (Aula aula : aulas) {
                                    %>
                                    <div class="col">
                                        <div class="card-aula bg-dark text-white">
                                            <div class="card-body" style="height: 80%;">
                                                <h5 class="card-title"><%= aula.getNomeAula()%></h5>
                                                <p class="card-text"><%= aula.getDescAula()%></p>
                                                <p class="card-text"><small>Data: <%= aula.getDtAula()%></small></p>
                                                <p class="card-text"><small>Horário: <%= aula.getHorarioAula()%></small></p>
                                                <p class="card-text">Professor: <%= aula.getPersonal().getNomePessoa()%></p>

                                            </div>
                                            <div class="card-footer">
                                                <!-- Botão para abrir o formulário -->
                                                <a href="#formAssociacao<%= aula.getCodAula()%>" class="btn btn-warning" data-bs-toggle="collapse">Associar</a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Formulário de Associação: Exibe o formulário quando o botão é clicado -->
                                    <div id="formAssociacao<%= aula.getCodAula()%>" class="collapse">
                                        <form action="AssociarAlunoAula" method="post">
                                            <input type="hidden" name="codAula" value="<%= aula.getCodAula()%>">

                                            <!-- Selecionar o Aluno -->
                                            <div class="mb-3">
                                                <label for="codAluno" class="form-label text-white">Selecione o Aluno</label>
                                                <select name="codAluno" class="form-select" required>
                                                    <option value="">Selecione o Aluno</option>
                                                    <%
                                                        for (Aluno aluno : listaAlunos) {
                                                    %>
                                                    <option value="<%= aluno.getCodAluno()%>"><%= aluno.getNomePessoa()%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>

                                            <button type="submit" class="btn btn-warning">Associar Aluno</button>
                                        </form>
                                    </div>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <p>Nenhuma aula cadastrada.</p>
                                    <% }%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="rodape.jsp"></jsp:include>