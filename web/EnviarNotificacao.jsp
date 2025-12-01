<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"/>
<style type="text/css">
    .card{
        box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
    }
</style>

<div class="page">
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
                <a href="EnviarNotificacao" class="nav-link py-3 active " title="Notificações" data-bs-toggle="tooltip" data-bs-placement="right">
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
                <li><a class="dropdown-item" href="PerfilAdm"><i class="fa-solid fa-user drop-icon"></i> Perfil</a></li>
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
                        <h3>Enviar Notificações</h3>
                        <a class="btn btn-outline-info" href="" data-bs-toggle="modal" data-bs-target="#ModalConfirm" data-emailpessoa="${aluno.emailPessoa}">Enviar</a>
                    </div>
                    <div class="card-body">
                        <table class="table table-striped table-hover p-3">
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Celular</th>
                                    <th>E-mail</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="aluno" items="${alunos}">
                                    <tr>
                                        <td>${aluno.nomePessoa}</td>
                                        <td>${aluno.celularPessoa}</td>
                                        <td>${aluno.emailPessoa}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Confirmação -->
<div class="modal fade" id="ModalConfirm" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalToggleLabel">Enviar Mensagem</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Qual meio de comunicação deseja enviar uma mensagem?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#Modalcel" data-bs-whatever="cel"><i class="fa-brands fa-whatsapp"></i></button>
                <button type="button" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#Modalemail" data-bs-whatever="email"><i class="fa-regular fa-envelope"></i></button>
            </div>
        </div>
    </div>
</div>
<!-- Este modal é utilizado para exibir a caixa de mensagem para celulares -->
<div class="modal fade" id="Modalcel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mensagem via Whatsapp</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="recipient-name" class="col-form-label">Para:</label>
                        <input type="text" id="searchcel" class="form-control mb-2" placeholder="Pesquisar aluno...">
                        <div class="d-flex flex-column mb-2">
                            <span id="selectAllcel" style="cursor: pointer; margin-bottom: 5px;">
                                <i class="fa-solid fa-check" style="color: green;"></i> Selecionar Todos
                            </span>
                            <span id="deselectAllcel" style="cursor: pointer;">
                                <i class="fa-solid fa-xmark" style="color:red;"></i> Desmarcar Todos
                            </span>
                        </div>
                        <div class="list-group" style="max-height: 200px; overflow-y: scroll;">
                            <c:forEach var="aluno" items="${alunos}">
                                <label class="list-group-item">
                                    <input type="checkbox" class="form-check-input me-1 cel-checkbox" value="${aluno.celularPessoa}">
                                    ${aluno.nomePessoa} - ${aluno.celularPessoa}
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="message-text" class="col-form-label">Mensagem:</label>
                        <textarea class="form-control" id="message-text"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-between">
                <button type="button" class="btn btn-outline-danger" data-bs-target="#ModalConfirm" data-bs-toggle="modal" data-bs-dismiss="modal"><i class="fa-solid fa-arrow-right-from-bracket"></i> Voltar</button>
                <button type="button" class="btn btn-outline-success" id="btnzap" data-bs-dismiss="modal">Enviar</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="Modalemail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mensagem via E-mail</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="recipient-name" class="col-form-label">Para:</label>
                        <input type="text" id="search" class="form-control mb-2" placeholder="Pesquisar aluno...">
                        <div class="d-flex flex-column mb-2">
                            <span id="selectAllemail" style="cursor: pointer; margin-bottom: 5px;">
                                <i class="fa-solid fa-check" style="color: green;"></i> Selecionar Todos
                            </span>
                            <span id="deselectAllemail" style="cursor: pointer;">
                                <i class="fa-solid fa-xmark" style="color:red;"></i> Desmarcar Todos
                            </span>
                        </div>
                        <div class="list-group" style="max-height: 200px; overflow-y: scroll;">
                            <c:forEach var="aluno" items="${alunos}">
                                <label class="list-group-item">
                                    <input type="checkbox" class="form-check-input me-1 email-checkbox" value="${aluno.emailPessoa}">
                                    ${aluno.nomePessoa} - ${aluno.emailPessoa}
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="message-text" class="col-form-label">Mensagem:</label>
                        <textarea class="form-control" id="message-text"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer d-flex justify-content-between">
                <button type="button" class="btn btn-outline-danger" data-bs-target="#ModalConfirm" data-bs-toggle="modal" data-bs-dismiss="modal"><i class="fa-solid fa-arrow-right-from-bracket"></i> Voltar</button>
                <button type="button" class="btn btn-outline-success" id="btnemail" data-bs-dismiss="modal">Enviar</button>
            </div>
        </div>
    </div>
</div>
<!-- Janela de mensagem -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 11">
    <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">Mensagem</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <c:if test="${mensagem != null}">
                <div class="alert alert-success" role="alert">
                    ${mensagem}
                </div>
            </c:if>
        </div>
    </div>
</div>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="myToastzap" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">Notificação</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <i class="fa-regular fa-circle-check" style="color: green;"></i> Mensagem por whatsapp enviada com sucesso!
        </div>
    </div>
</div>
<div class="toast-container position-fixed top-0 end-0 p-3">
    <div id="myToastemail" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">Notificação</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
            <i class="fa-regular fa-circle-check" style="color: green;"></i> Mensagem por E-mail enviada com sucesso!
        </div>
    </div>
</div>

<script>
    // Função para filtrar a lista de alunos com base na pesquisa de nomes e números
    function filterCheckboxes(inputId, checkboxClass) {
        document.getElementById(inputId).addEventListener('input', function () {
            var searchValue = this.value.toLowerCase();
            var checkboxes = document.querySelectorAll('.' + checkboxClass);
            checkboxes.forEach(function (checkbox) {
                var label = checkbox.parentElement;
                var text = label.textContent.toLowerCase();
                label.style.display = text.includes(searchValue) ? '' : 'none';
            });
        });
    }

    // Função para selecionar todos os checkboxes de uma classe específica
    function selectAllCheckboxes(buttonId, checkboxClass) {
        document.getElementById(buttonId).addEventListener('click', function () {
            var checkboxes = document.querySelectorAll('.' + checkboxClass);
            checkboxes.forEach(function (checkbox) {
                checkbox.checked = true;
            });
        });
    }

    // Função para desmarcar todos os checkboxes de uma classe específica
    function deselectAllCheckboxes(buttonId, checkboxClass) {
        document.getElementById(buttonId).addEventListener('click', function () {
            var checkboxes = document.querySelectorAll('.' + checkboxClass);
            checkboxes.forEach(function (checkbox) {
                checkbox.checked = false;
            });
        });
    }
    // Aplicando as funções de filtro e seleção aos modais existentes
    filterCheckboxes('searchcel', 'cel-checkbox');
    selectAllCheckboxes('selectAllcel', 'cel-checkbox');
    deselectAllCheckboxes('deselectAllcel', 'cel-checkbox');

    filterCheckboxes('search', 'email-checkbox');
    selectAllCheckboxes('selectAllemail', 'email-checkbox');
    deselectAllCheckboxes('deselectAllemail', 'email-checkbox');

    $(document).ready(function () {
        $('#btnzap').click(function () {
            var toast = new bootstrap.Toast(document.getElementById('myToastzap'));
            toast.show();
        });
    });
    $(document).ready(function () {
        $('#btnemail').click(function () {
            var toast = new bootstrap.Toast(document.getElementById('myToastemail'));
            toast.show();
        });
    });
</script>
<jsp:include page="rodape.jsp"/>
