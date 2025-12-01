<%@page import="br.com.zenitgymsystem.model.Personal"%>
<%@page import="java.util.List"%>
<%@page import="br.com.zenitgymsystem.model.Aluno"%>
<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"></jsp:include>
    <div class="page">
        <style type="text/css">

            .botoesExpandido {
                display: none; /* Inicialmente escondidos */
                padding: 10px 0;
            }
            tr.linhaExpandida + tr.botoesExpandido {
                display: table-row; /* Exibe quando a linha está expandida */
            }
            /* Formulário geral */
            .styled-form {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            /* Títulos e rótulos */
            .form-label {
                display: block;
                font-size: 1rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 8px;
            }

            /* Campos de entrada */
            .form-input,
            .form-select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                font-size: 1rem;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
                box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .form-input:focus,
            .form-select:focus {
                border-color: #007bff;
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
                outline: none;
            }

            /* Botões */
            .btn-submit,
            .btn-reset {
                display: inline-block;
                padding: 10px 20px;
                font-size: 1rem;
                font-weight: 600;
                text-align: center;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.2s;
            }

            .btn-submit {
                background-color: #28a745;
                margin-right: 10px;
            }

            .btn-submit:hover {
                background-color: #218838;
                transform: scale(1.05);
            }

            .btn-reset {
                background-color: #dc3545;
            }

            .btn-reset:hover {
                background-color: #c82333;
                transform: scale(1.05);
            }

            /* Grupos de formulário */
            .form-group {
                margin-bottom: 20px;
            }

            /* Responsividade */
            @media (max-width: 768px) {
                .styled-form {
                    padding: 15px;
                }

                .btn-submit,
                .btn-reset {
                    width: 100%;
                    margin-bottom: 10px;
                }
            }
            .card{
                box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
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
                    <a href="ListarAlunoPersonal" class="nav-link py-3 active" title="Avaliação Física" data-bs-toggle="tooltip" data-bs-placement="right">
                        <i class="fa-solid fa-child "></i>
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
                    <div class="card-header d-flex justify-content-around align-items-center">
                        <h5 class="card-title">Análise Corporal</h5>
                        <!-- Botão para abrir o modal de agendamento -->
                        <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#agendamentoModal">
                            Agendar
                        </a>

                    </div>

                        <div class="card-body">
                            <!-- Tabela para listar as análises -->
                            <table class="table table-striped">
                                <thead>
                                    <tr >
                                        <th>Data e Horário</th>
                                        <th>Objetivo</th>
                                        <th>Aluno</th>
                                        <th>Avaliador</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Itera sobre a lista de análises -->
                                    <c:forEach var="analise" items="${analises}">
                                        <tr class="linhaAnalise" onclick="toggleLinha(this);">
                                            <td>${analise.dtAgendamentoAv} - ${analise.hrAgendamentoAv}</td>
                                            <td>${analise.objetivoAv}</td>
                                            <td>${analise.aluno.nomePessoa}</td>
                                            <td>${analise.personal.nomePessoa}</td>
                                            <td>${analise.statusAv ? 'Concluído' : 'Agendado'}</td>
                                        </tr>
                                        <tr class="botoesExpandido">
                                            <td colspan="6" style="text-align: center;">
                                                <a class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalAlterarEntrega" ><i class="fa-regular fa-clipboard"></i> Realizar </a> 
                                                <a class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalExclusaoEntrega"  title="Excluir entrega"><i class="fa-solid fa-trash"></i> Excluir</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Modal para Cadastro da Análise Corporal -->
    <div class="modal fade" id="cadastroAnaliseModal" tabindex="-1" aria-labelledby="cadastroAnaliseModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="cadastroAnaliseModalLabel">Cadastro de Análise Corporal</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="POST" action="CadastrarAnaliseServlet">
                        <!-- Campo oculto para codAv (chave primária) -->
                        <input type="hidden" name="codAv" value="${analise.codAv}">

                        <div class="row">
                            <!-- Data da Análise -->
                            <div class="col-md-6 mb-3">
                                <label for="dataAv" class="form-label">Data da Análise</label>
                                <input type="date" class="form-control" id="dataAv" name="dataAv" required>
                            </div>

                            <!-- Peso -->
                            <div class="col-md-6 mb-3">
                                <label for="pesoAv" class="form-label">Peso (kg)</label>
                                <input type="number" step="0.1" class="form-control" id="pesoAv" name="pesoAv" required>
                            </div>

                            <!-- Altura -->
                            <div class="col-md-6 mb-3">
                                <label for="alturaAv" class="form-label">Altura (m)</label>
                                <input type="number" step="0.01" class="form-control" id="alturaAv" name="alturaAv" required>
                            </div>

                            <!-- IMC -->
                            <div class="col-md-6 mb-3">
                                <label for="imcAv" class="form-label">IMC</label>
                                <input type="number" step="0.1" class="form-control" id="imcAv" name="imcAv" readonly>
                            </div>

                            <!-- Percentual de Gordura -->
                            <div class="col-md-6 mb-3">
                                <label for="percentGorduraAv" class="form-label">% Gordura</label>
                                <input type="number" step="0.1" class="form-control" id="percentGorduraAv" name="percentGorduraAv" required>
                            </div>

                            <!-- Massa Muscular -->
                            <div class="col-md-6 mb-3">
                                <label for="massaMuscularAv" class="form-label">Massa Muscular (kg)</label>
                                <input type="number" step="0.1" class="form-control" id="massaMuscularAv" name="massaMuscularAv" required>
                            </div>

                            <!-- Pressão Arterial -->
                            <div class="col-md-6 mb-3">
                                <label for="pressaoAv" class="form-label">Pressão Arterial</label>
                                <input type="text" class="form-control" id="pressaoAv" name="pressaoAv" required>
                            </div>

                            <!-- Frequência Cardíaca -->
                            <div class="col-md-6 mb-3">
                                <label for="freqCardiacaAv" class="form-label">Frequência Cardíaca (bpm)</label>
                                <input type="number" class="form-control" id="freqCardiacaAv" name="freqCardiacaAv" required>
                            </div>

                            <!-- Capacidade Aeróbica -->
                            <div class="col-md-6 mb-3">
                                <label for="capacidadeAerobicaAv" class="form-label">Capacidade Aeróbica (VO2 máx)</label>
                                <input type="number" step="0.1" class="form-control" id="capacidadeAerobicaAv" name="capacidadeAerobicaAv" required>
                            </div>

                            <!-- Objetivo da Avaliação -->
                            <div class="col-md-12 mb-3">
                                <label for="objetivoAv" class="form-label">Objetivo</label>
                                <textarea class="form-control" id="objetivoAv" name="objetivoAv" rows="2"></textarea>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Cadastrar Análise</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal para Agendamento -->
    <div class="modal fade" id="agendamentoModal" tabindex="-1" aria-labelledby="agendamentoModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="agendamentoModalLabel">Agendamento de Análise</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AgendarAnalise" method="POST">
                        <!-- Campo oculto para codAv (chave primária) -->
                        <input type="hidden" name="codAv" value="${analise.codAv == 0 ? '' :analise.codAv}">

                        <!-- Campos ocultos para os dados da análise -->
                        <input type="hidden" name="pesoAv" value="0">
                        <input type="hidden" name="alturaAv" value="0">
                        <input type="hidden" name="imcAv" value="0">
                        <input type="hidden" name="percentGorduraAv" value="0">
                        <input type="hidden" name="massaMuscularAv" value="0">
                        <input type="hidden" name="pressaoAv" value="0">
                        <input type="hidden" name="freqCardiacaAv" value="0">
                        <input type="hidden" name="capacidadeAerobicaAv" value="0">


                        <form class="styled-form">
                            <label for="objetivoAv" class="form-label">Objetivo:</label>
                            <input type="text" name="objetivoAv" class="form-input" required>

                            <!-- Dados de agendamento -->
                            <label for="dtAgendamentoAv" class="form-label">Data de Agendamento:</label>
                            <input type="date" id="dtAgendamentoAv" name="dtAgendamentoAv" value="${analise.dtAgendamentoAv}" class="form-input" required>

                            <label for="hrAgendamentoAv" class="form-label">Hora de Agendamento:</label>
                            <input type="time" id="hrAgendamentoAv" name="hrAgendamentoAv" class="form-input" required>

                            <!-- Selecionar o Aluno -->
                            <div class="form-group">
                                <label for="codAluno" class="form-label">Selecione o Aluno:</label>
                                <select name="codAluno" class="form-select" required>
                                    <option value="">Selecione o Aluno</option>
                                    <c:forEach var="aluno" items="${alunos}">
                                        <option value="${aluno.codAluno}">${aluno.nomePessoa}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Selecionar o Personal -->
                            <div class="form-group">
                                <label for="codPers" class="form-label">Selecione o Personal:</label>
                                <select name="codPers" class="form-select" required>
                                    <option value="">Selecione o Personal</option>
                                    <c:forEach var="personal" items="${personais}">
                                        <option value="${personal.codPers}">${personal.nomePessoa}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <button type="submit" class="btn-submit">Salvar</button>
                            <button type="reset" class="btn-reset">Limpar</button>
                        </form>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function toggleLinha(tr) {
        $(tr).toggleClass('linhaExpandida'); // Adiciona ou remove a classe para expandir a linha
        $(tr).next('.botoesExpandido').slideToggle(); // Alterna a exibição da linha de botões
    }
</script>

<jsp:include page="rodape.jsp"></jsp:include>