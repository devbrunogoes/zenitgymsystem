
<%@page import="br.com.zenitgymsystem.model.Aluno"%>
<%@page import="br.com.zenitgymsystem.dao.AlunoDAO"%>
<%@page import="br.com.zenitgymsystem.dao.ExercicioDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="br.com.zenitgymsystem.model.Exercicio"%>
<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"></jsp:include>
<!--Dentro deste parametro colocar apenas as atribuições que o Personal poderá vizualizar-->
<div class="page">
    <style type="text/css">


        .card {
            width: 100%;
            height: 100%;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            background-color: white;
        }

        .col-left, .col-right {
            padding: 20px;
        }

        .col-left {
            overflow-y: auto;
        }

        .modelo-treino {
            padding: 15px;
        }
        .exercise-details {
            background-color: #f0f0f0;
            padding: 10px;
            border-radius: 5px;
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
                <a href="Treinos.jsp" class="nav-link py-3 active" title="Treinos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-dumbbell "></i>
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
        <div class="card">
            <div class="row d-flex" style="height: 100%;">
                <form action="CadastrarTreino" method="POST" class="d-flex flex-wrap">
                    <!-- Coluna Esquerda: Exercícios -->
                    <div class="col-md-7 col-left">
                        <div class="d-flex justify-content-between">
                            <h6>Exercícios Disponíveis</h6>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#novoExercicioModal" class="btn btn-link" style="font-size: 0.8em;">+ Novo Exercício</a>
                        </div>
                        <hr>

                        <!-- Listar Exercícios -->
                        <%
                            ExercicioDAO exercicioDAO = new ExercicioDAO();
                            List<Exercicio> listaExercicios = exercicioDAO.listar();
                            if (listaExercicios.isEmpty()) {
                        %>
                        <p>Nenhum exercício encontrado.</p>
                        <%
                        } else {
                            for (Exercicio exercicio : listaExercicios) {
                        %>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" name="exerciciosSelecionados" 
                                   value="<%= exercicio.getCodEx()%>" id="exercicio<%= exercicio.getCodEx()%>" 
                                   onclick="toggleDetails('<%= exercicio.getCodEx()%>')">
                            <label class="form-check-label" for="exercicio<%= exercicio.getCodEx()%>">
                                <%= exercicio.getNomeEx()%>
                            </label>

                            <!-- Detalhes do exercício -->
                            <div id="details<%= exercicio.getCodEx()%>" class="exercise-details" style="display: none;">
                                <input type="hidden" name="codET_<%= exercicio.getCodEx()%>" value="<%= exercicio.getCodEx()%>">

                                <label>Tipo do Exercício:</label>
                                <input type="text" name="tipoET_<%= exercicio.getCodEx()%>" class="form-control mb-2" placeholder="Ex: Força">

                                <label>Séries:</label>
                                <input type="number" name="seriesET_<%= exercicio.getCodEx()%>" class="form-control mb-2" placeholder="Ex: 3">

                                <label>Repetições:</label>
                                <input type="number" name="repeticoesET_<%= exercicio.getCodEx()%>" class="form-control mb-2" placeholder="Ex: 12">

                                <label>Carga (kg):</label>
                                <input type="number" name="pesoET_<%= exercicio.getCodEx()%>" step="0.1" class="form-control mb-2" placeholder="Ex: 20.5">

                                <label>Descanso (s):</label>
                                <input type="number" name="descansoET_<%= exercicio.getCodEx()%>" class="form-control mb-2" placeholder="Ex: 30">

                                <label>Duração (min):</label>
                                <input type="number" name="duracaoET_<%= exercicio.getCodEx()%>" class="form-control mb-2" placeholder="Ex: 15">

                                <label>Observações:</label>
                                <textarea name="obsET_<%= exercicio.getCodEx()%>" class="form-control" rows="2"></textarea>
                            </div>
                        </div>
                        <% }
                            } %>
                    </div>


                    <!-- Coluna Direita: Detalhes do Treino -->
                    <div class="col-md-5 col-right" style="background-color: #f8f9fa; padding: 20px;">
                        <h5>Criar Treino do Aluno</h5>
                        <!-- Campo oculto para o código do treino -->
                        <input type="hidden" class="form-control" name="codTreino" id="codTreino"
                               value="${treino.codTreino == 0 ? '' : treino.codTreino}">



                        <!-- Nome do Treino -->
                        <div class="mb-3">
                            <label for="nomeTreino" class="form-label">Nome do Treino</label>
                            <input type="text" class="form-control" id="nomeTreino" name="nomeTreino" 
                                   placeholder="Ex: Treino de Força" value="${Treino.nomeTreino}" required>
                        </div>

                        <!-- Descrição do Treino -->
                        <div class="mb-3">
                            <label for="descricaoTreino" class="form-label">Descrição do Treino</label>
                            <textarea class="form-control" id="descricaoTreino" name="descricaoTreino" rows="3" 
                                      placeholder="Ex: Treino focado em membros superiores">${Treino.descricaoTreino}</textarea>
                        </div>

                        <!-- Selecionar Aluno -->
                        <div class="mb-3">
                            <label for="codAluno" class="form-label">Selecionar Aluno</label>
                            <select class="form-select" name="codAluno" id="codAluno" required>
                                <option value="">Selecione o aluno...</option>
                                <%
                                    AlunoDAO alunoDAO = new AlunoDAO();
                                    List<Object> lista = alunoDAO.listar();
                                    if (!lista.isEmpty()) {
                                        for (Object obj : lista) {
                                            if (obj instanceof Aluno) {
                                                Aluno aluno = (Aluno) obj;
                                %>
                                <option value="<%= aluno.getCodAluno()%>"><%= aluno.getNomePessoa()%></option>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <!-- Data de Início -->
                        <div class="mb-3">
                            <label for="dtTreino" class="form-label">Data do Treino</label>
                            <input type="date" class="form-control" id="dtTreino" name="dtTreino" required>
                        </div>

                        <!-- Status do Treino -->
                        <div class="mb-3">
                            <div class="form-label">Status do Treino:</div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="statusTreino" id="statusTreinoAtivo" value="true" checked>
                                <label class="form-check-label" for="statusTreinoAtivo">Ativo</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="statusTreino" id="statusTreinoInativo" value="false">
                                <label class="form-check-label" for="statusTreinoInativo">Inativo</label>
                            </div>
                        </div>

                        <!-- Botão para salvar -->
                        <button type="submit" class="btn btn-primary w-100">Salvar Treino</button>
                    </div>


                </form>
            </div>
        </div>
    </div>



</div>





<!-- Modal para Criar Novo Exercício -->
<div class="modal fade" id="novoExercicioModal" tabindex="-1" aria-labelledby="novoExercicioModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="CadastrarExercicio" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="novoExercicioModalLabel">Criar Novo Exercício</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="codEx" id="codEx" value="${exercicio.codEx == 0 ? '' : exercicio.codEx}">
                    <div class="mb-3">
                        <label for="nomeEx" class="form-label">Nome do Exercício</label>
                        <input type="text" class="form-control" id="nomeEx" name="nomeEx" required>
                    </div>
                    <div class="mb-3">
                        <label for="grupoEx" class="form-label">Grupo do Exercício</label>
                        <!-- Campo de autocompletar para selecionar grupo -->
                        <input type="text" class="form-control" id="grupoEx" name="grupoEx" placeholder="Filtrar grupo" onkeyup="filtrarGrupos()" required>
                        <ul id="grupoExList" class="list-group mt-2" style="max-height: 150px; overflow-y: auto; display: none;"></ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Salvar Exercício</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

// Função para filtrar e exibir os grupos conforme o que é digitado
    function filtrarGrupos() {
        var input = document.getElementById("grupoEx").value;
        var lista = document.getElementById("grupoExList");

        // Lista de grupos musculares
        var grupos = [
            "Abdômen", "Peito", "Costas", "Bíceps", "Tríceps",
            "Perna", "Ombro", "Glúteos", "Trapézio", "Panturrilha", "Antebraço"
        ];

        // Limpa a lista de resultados
        lista.innerHTML = "";
        if (input.length > 0) {
            // Filtra os grupos com base no que foi digitado
            var gruposFiltrados = grupos.filter(function (grupo) {
                return grupo.toLowerCase().includes(input.toLowerCase());
            });

            // Exibe os grupos filtrados
            if (gruposFiltrados.length > 0) {
                lista.style.display = "block"; // Mostra a lista
                gruposFiltrados.forEach(function (grupo) {
                    var item = document.createElement("li");
                    item.classList.add("list-group-item");
                    item.textContent = grupo;
                    item.onclick = function () {
                        document.getElementById("grupoEx").value = grupo;
                        lista.style.display = "none"; // Oculta a lista após selecionar
                    };
                    lista.appendChild(item);
                });
            } else {
                lista.style.display = "none"; // Oculta a lista se não houver correspondência
            }
        } else {
            lista.style.display = "none"; // Oculta a lista se o campo estiver vazio
        }
    }

    // Função para fechar a lista se o usuário clicar fora
    document.addEventListener("click", function (event) {
        var lista = document.getElementById("grupoExList");
        var input = document.getElementById("grupoEx");
        if (!input.contains(event.target) && !lista.contains(event.target)) {
            lista.style.display = "none";
        }
    });

    function toggleDetails(codEx) {
        const checkbox = document.getElementById('exercicio' + codEx);
        const detailsDiv = document.getElementById('details' + codEx);

        // Mostrar ou ocultar os detalhes com base na seleção
        if (checkbox.checked) {
            detailsDiv.style.display = 'block';
        } else {
            detailsDiv.style.display = 'none';
        }

        // Atualizar a lista de exercícios selecionados
        atualizarListaExercicios();
    }

    function atualizarListaExercicios() {
        const listaUl = document.getElementById('listaExerciciosSelecionados');
        listaUl.innerHTML = '';

        // Obter todos os checkboxes marcados
        const checkboxes = document.querySelectorAll('input[name="exerciciosSelecionados"]:checked');
        checkboxes.forEach(checkbox => {
            const label = document.querySelector(`label[for=${checkbox.id}]`).innerText;
            const li = document.createElement('li');
            li.textContent = label;
            listaUl.appendChild(li);
        });
    }
</script>

<jsp:include page="rodape.jsp" ></jsp:include>