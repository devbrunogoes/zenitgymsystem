<%@page import="br.com.zenitgymsystem.dao.UsuarioDAO"%>
<%@page import="java.util.List"%>
<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %> 
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
                <a href="ListarUsuarios" class="nav-link py-3 active" title="Usuários" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-users "></i>
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
        <c:if test="${mensagem != null}">
            <div class="alert alert-primary" role="alert">
                ${mensagem}
            </div>
        </c:if>
        <div class="container" style="width: 100%;">
            <div class="col-12 mt-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-around">
                        <h3>Usuários</h3>
                        <a class="btn btn-outline-primary" href="#" data-bs-toggle="modal" data-bs-target="#modalNovoAluno">Novo Aluno</a>
                        <a class="btn btn-outline-primary" href="#" data-bs-toggle="modal" data-bs-target="#modalNovoPersonal">Novo Personal</a>
                        <a class="btn btn-outline-primary" href="#" data-bs-toggle="modal" data-bs-target="#modalNovoAdministrador">Novo Administrador</a>
                        <form class="d-flex" role="search">
                            <input class="form-control me-2" type="search" placeholder="Pesquisar Usuário..." aria-label="Search" id="search" name="search" onkeyup="searchTable()">
                        </form>
                    </div>
                    <div class="card-body ">
                        <table class="table table-striped table-hover p-3 text-center" id="userTable">
                            <thead>
                                <tr>
                                    <th>Foto</th>
                                    <th>Código</th>
                                    <th>Nome</th>
                                    <th>CPF</th>
                                    <th>Senha</th>
                                    <th>Perfil</th>
                                    <th colspan="2">Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="usuario" items="${usuarios}">
                                    <tr>
                                        <td class="text-center">
                                            <img src="img/Fts-Perfil/${usuario.imgUsuario != null ? usuario.imgUsuario : 'default.jpg'}" class="rounded-circle" style="width: 30px; height: 30px;" alt="Imagem do Usuário">
                                        </td>
                                        <td>${usuario.codUsuario}</td>
                                        <td>${usuario.nomeUsuario}</td>
                                        <td>${usuario.cpfUsuario}</td>
                                        <td>******</td>
                                        <td>${usuario.perfilUsuario}</td>
                                        <td><a class="btn btn-outline-dark" href="ConsultarUsuario?codUsuario=${usuario.codUsuario}"><i class="fa-solid fa-pencil"></i></a></td>
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
<!-- Modal para novo Aluno -->
<div class="modal fade" id="modalNovoAluno" tabindex="-1" aria-labelledby="modalNovoAlunoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalNovoAlunoLabel">Cadastrar Novo Aluno</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="CadastrarAlunoForm" class="row g-3" action="CadastrarAluno" method="POST" enctype="multipart/form-data">

                    <!-- Imagem do Aluno -->
                    <div class="col-12 d-flex justify-content-around text-center">
                        <div class="col-6 d-flex justify-content-center align-items-center">
                            <img id="imgPreviewA" src="#" alt="Imagem do Aluno" class="img-thumbnail rounded-circle" style="width: 150px; height: 150px; object-fit: cover; display: none;">
                        </div>
                        <div class="col-6">
                            <label for="imgPessoaA" class="form-label">Foto do Aluno</label>
                            <input type="file" class="form-control" id="imgPessoaA" name="imgPessoaA" onchange="converterImagemAluno();">
                        </div>
                    </div>

                    <input type="hidden" class="form-control" name="codAluno" id="codAluno" value="${aluno.codAluno == 0 ? "" : aluno.codAluno}">
                    <input type="hidden" class="form-control" name="codPessoa" id="codPessoa" value="${aluno.codPessoa == 0 ? "" : aluno.codPessoa}">

                    <div class="col-md-6">
                        <label for="nomePessoa" class="form-label">Nome</label>
                        <input type="text" class="form-control" name="nomePessoa" id="nomePessoa" value="${aluno.nomePessoa}">
                    </div>

                    <div class="col-md-6">
                        <label for="emailPessoa" class="form-label">E-mail</label>
                        <input type="email" class="form-control" name="emailPessoa" id="emailPessoa" value="${aluno.emailPessoa}">
                    </div>

                    <div class="col-md-4">
                        <label for="senhaPessoa" class="form-label">Senha</label>
                        <input type="password" class="form-control" name="senhaPessoa" id="senhaPessoa" value="${aluno.senhaPessoa}">
                    </div>

                    <div class="col-md-4">
                        <label for="dtnascPessoa" class="form-label">Data de Nascimento</label>
                        <input type="date" class="form-control" name="dtnascPessoa" id="dtnascPessoa" value="${aluno.dtnascPessoa}">
                    </div>

                    <div class="col-md-4">
                        <label for="cpfPessoa" class="form-label">CPF</label>
                        <input type="text" class="form-control" name="cpfPessoa" id="cpfPessoa" value="${aluno.cpfPessoa}" onkeypress="$(this).mask('000.000.000-00')">
                    </div>

                    <div class="col-md-4">
                        <label for="rgPessoa" class="form-label">RG</label>
                        <input type="text" class="form-control" name="rgPessoa" id="rgPessoa" value="${aluno.rgPessoa}" onkeypress="$(this).mask('00.000.000-0')">
                    </div>

                    <div class="col-md-4">
                        <label for="sexoPessoa" class="form-label">Sexo</label>
                        <select class="form-select" name="sexoPessoa" id="sexoPessoa">
                            <option value="Masculino" ${aluno.sexoPessoa == 'Masculino' ? 'selected' : ''}>Masculino</option>
                            <option value="Feminino" ${aluno.sexoPessoa == 'Feminino' ? 'selected' : ''}>Feminino</option>
                            <option value="Outro" ${aluno.sexoPessoa == 'Outro' ? 'selected' : ''}>Outro</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label for="celularPessoa" class="form-label">Celular</label>
                        <input type="text" class="form-control" name="celularPessoa" id="celularPessoa" value="${aluno.celularPessoa}" onkeypress="$(this).mask('(00) 00000-0000')" placeholder="Informe o Celular..." required>
                    </div>

                    <div class="col-md-4">
                        <label for="cepPessoa" class="form-label">CEP</label>
                        <input type="text" class="form-control" name="cepPessoa" id="cepPessoa" value="${aluno.cepPessoa}" onkeypress="$(this).mask('00000-000')">
                    </div>

                    <div class="col-md-4">
                        <label for="cidadePessoa" class="form-label">Cidade</label>
                        <input type="text" class="form-control" name="cidadePessoa" id="cidadePessoa" value="${aluno.cidadePessoa}">
                    </div>
                    <div class="col-md-4">
                        <label for="bairroPessoa" class="form-label">Bairro</label>
                        <input type="text" class="form-control" name="bairroPessoa" id="bairroPessoa" value="${aluno.bairroPessoa}">
                    </div>
                    <div class="col-md-8">
                        <label for="endPessoa" class="form-label">Endereço</label>
                        <input type="text" class="form-control" name="endPessoa" id="endPessoa" value="${aluno.endPessoa}">
                    </div>



                    <div class="col-md-2">
                        <label for="numeroPessoa" class="form-label">Número</label>
                        <input type="number" class="form-control" name="numeroPessoa" id="numeroPessoa" value="${aluno.numeroPessoa}">
                    </div>



                    <div class="col-md-2">
                        <label for="ufPessoa" class="form-label">UF</label>
                        <select class="form-select" name="ufPessoa" id="ufPessoa">
                            <option value="AC" ${aluno.ufPessoa == 'AC' ? 'selected' : ''}>AC</option>
                            <option value="AL" ${aluno.ufPessoa == 'AL' ? 'selected' : ''}>AL</option>
                            <option value="AP" ${aluno.ufPessoa == 'AP' ? 'selected' : ''}>AP</option>
                            <option value="AM" ${aluno.ufPessoa == 'AM' ? 'selected' : ''}>AM</option>
                            <option value="BA" ${aluno.ufPessoa == 'BA' ? 'selected' : ''}>BA</option>
                            <option value="CE" ${aluno.ufPessoa == 'CE' ? 'selected' : ''}>CE</option>
                            <option value="DF" ${aluno.ufPessoa == 'DF' ? 'selected' : ''}>DF</option>
                            <option value="ES" ${aluno.ufPessoa == 'ES' ? 'selected' : ''}>ES</option>
                            <option value="GO" ${aluno.ufPessoa == 'GO' ? 'selected' : ''}>GO</option>
                            <option value="MA" ${aluno.ufPessoa == 'MA' ? 'selected' : ''}>MA</option>
                            <option value="MT" ${aluno.ufPessoa == 'MT' ? 'selected' : ''}>MT</option>
                            <option value="MS" ${aluno.ufPessoa == 'MS' ? 'selected' : ''}>MS</option>
                            <option value="MG" ${aluno.ufPessoa == 'MG' ? 'selected' : ''}>MG</option>
                            <option value="PA" ${aluno.ufPessoa == 'PA' ? 'selected' : ''}>PA</option>
                            <option value="PB" ${aluno.ufPessoa == 'PB' ? 'selected' : ''}>PB</option>
                            <option value="PR" ${aluno.ufPessoa == 'PR' ? 'selected' : ''}>PR</option>
                            <option value="PE" ${aluno.ufPessoa == 'PE' ? 'selected' : ''}>PE</option>
                            <option value="PI" ${aluno.ufPessoa == 'PI' ? 'selected' : ''}>PI</option>
                            <option value="RJ" ${aluno.ufPessoa == 'RJ' ? 'selected' : ''}>RJ</option>
                            <option value="RN" ${aluno.ufPessoa == 'RN' ? 'selected' : ''}>RN</option>
                            <option value="RS" ${aluno.ufPessoa == 'RS' ? 'selected' : ''}>RS</option>
                            <option value="RO" ${aluno.ufPessoa == 'RO' ? 'selected' : ''}>RO</option>
                            <option value="RR" ${aluno.ufPessoa == 'RR' ? 'selected' : ''}>RR</option>
                            <option value="SC" ${aluno.ufPessoa == 'SC' ? 'selected' : ''}>SC</option>
                            <option value="SP" ${aluno.ufPessoa == 'SP' ? 'selected' : ''}>SP</option>
                            <option value="SE" ${aluno.ufPessoa == 'SE' ? 'selected' : ''}>SE</option>
                            <option value="TO" ${aluno.ufPessoa == 'TO' ? 'selected' : ''}>TO</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="complPessoa" class="form-label">Complemento</label>
                        <input type="text" class="form-control" name="complPessoa" id="complPessoa" value="${aluno.complPessoa}">
                    </div>
                    <div class="col-md-3">
                        <label for="plano" class="form-label">Plano</label>
                        <select class="form-select" name="plano" id="plano" required>
                            <option value="" disabled ${aluno.plano == '' ? 'selected' : ''}>Selecione um plano</option>
                            <option value="Mensal" ${aluno.plano == 'Mensal' ? 'selected' : ''}>Mensal</option>
                            <option value="Trimestral" ${aluno.plano == 'Trimestral' ? 'selected' : ''}>Trimestral</option>
                            <option value="Semestral" ${aluno.plano == 'Semestral' ? 'selected' : ''}>Semestral</option>
                            <option value="Anual" ${aluno.plano == 'Anual' ? 'selected' : ''}>Anual</option>
                        </select>
                    </div>


                    <div class="col-12 d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Cadastrar Aluno</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Modal para Novo Personal -->
<div class="modal fade" id="modalNovoPersonal" tabindex="-1" aria-labelledby="modalNovoPersonalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalNovoPersonalLabel">Cadastrar Novo Personal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="CadastrarPersonalForm" class="row g-3" action="CadastrarPersonal" method="POST" enctype="multipart/form-data">

                    <!-- Imagem do Personal -->
                    <div class="col-12 d-flex justify-content-around text-center">
                        <div class="col-6 d-flex justify-content-center align-items-center">
                            <img id="imgPreviewPers" src="#" alt="Imagem do Personal" class="img-thumbnail rounded-circle" style="width: 150px; height: 150px; object-fit: cover; display: none;">
                        </div>
                        <div class="col-6">
                            <label for="imgPessoaPers" class="form-label">Foto do Personal</label>
                            <input type="file" class="form-control" id="imgPessoaPers" name="imgPessoaPers" onchange="converterImagemPers();">
                        </div>
                    </div>

                    <input type="hidden" class="form-control" name="codPessoa" id="codPessoaPers">

                    <div class="col-md-6">
                        <label for="nomePessoa" class="form-label">Nome</label>
                        <input type="text" class="form-control" name="nomePessoa" id="nomePessoaPers" required>
                    </div>

                    <div class="col-md-6">
                        <label for="emailPessoa" class="form-label">E-mail</label>
                        <input type="email" class="form-control" name="emailPessoa" id="emailPessoaPers" required>
                    </div>

                    <div class="col-md-4">
                        <label for="senhaPessoa" class="form-label">Senha</label>
                        <input type="password" class="form-control" name="senhaPessoa" id="senhaPessoaPers" required>
                    </div>

                    <div class="col-md-4">
                        <label for="dtnascPessoa" class="form-label">Data de Nascimento</label>
                        <input type="date" class="form-control" name="dtnascPessoa" id="dtnascPessoaPers" required>
                    </div>

                    <div class="col-md-4">
                        <label for="cpfPessoa" class="form-label">CPF</label>
                        <input type="text" class="form-control" name="cpfPessoa" id="cpfPessoaPers" onkeypress="$(this).mask('000.000.000-00')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="rgPessoa" class="form-label">RG</label>
                        <input type="text" class="form-control" name="rgPessoa" id="rgPessoaPers" onkeypress="$(this).mask('00.000.000-0')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="sexoPessoa" class="form-label">Sexo</label>
                        <select class="form-select" name="sexoPessoa" id="sexoPessoaPers" required>
                            <option value="Masculino">Masculino</option>
                            <option value="Feminino">Feminino</option>
                            <option value="Outro">Outro</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label for="celularPessoa" class="form-label">Celular</label>
                        <input type="text" class="form-control" name="celularPessoa" id="celularPessoaPers" onkeypress="$(this).mask('(00) 00000-0000')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="cepPessoa" class="form-label">CEP</label>
                        <input type="text" class="form-control" name="cepPessoa" id="cepPessoaPers" onkeypress="$(this).mask('00000-000')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="complPessoa" class="form-label">Complemento</label>
                        <input type="text" class="form-control" name="complPessoa" id="complPessoaPers">
                    </div>

                    <div class="col-md-8">
                        <label for="endPessoa" class="form-label">Endereço</label>
                        <input type="text" class="form-control" name="endPessoa" id="endPessoaPers" required>
                    </div>

                    <div class="col-md-4">
                        <label for="bairroPessoa" class="form-label">Bairro</label>
                        <input type="text" class="form-control" name="bairroPessoa" id="bairroPessoaPers" required>
                    </div>

                    <div class="col-md-2">
                        <label for="numeroPessoa" class="form-label">Número</label>
                        <input type="number" class="form-control" name="numeroPessoa" id="numeroPessoaPers" required>
                    </div>

                    <div class="col-md-6">
                        <label for="cidadePessoa" class="form-label">Cidade</label>
                        <input type="text" class="form-control" name="cidadePessoa" id="cidadePessoaPers" required>
                    </div>

                    <div class="col-md-3">
                        <label for="ufPessoa" class="form-label">UF</label>
                        <select class="form-select" name="ufPessoa" id="ufPessoaPers" required>
                            <option value="AC">AC</option>
                            <option value="AL">AL</option>
                            <option value="AP">AP</option>
                            <option value="AM">AM</option>
                            <option value="BA">BA</option>
                            <option value="CE">CE</option>
                            <option value="DF">DF</option>
                            <option value="ES">ES</option>
                            <option value="GO">GO</option>
                            <option value="MA">MA</option>
                            <option value="MT">MT</option>
                            <option value="MS">MS</option>
                            <option value="MG">MG</option>
                            <option value="PA">PA</option>
                            <option value="PB">PB</option>
                            <option value="PR">PR</option>
                            <option value="PE">PE</option>
                            <option value="PI">PI</option>
                            <option value="RJ">RJ</option>
                            <option value="RN">RN</option>
                            <option value="RS">RS</option>
                            <option value="RO">RO</option>
                            <option value="RR">RR</option>
                            <option value="SC">SC</option>
                            <option value="SP">SP</option>
                            <option value="SE">SE</option>
                            <option value="TO">TO</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label for="dtcontratoPers" class="form-label">Data de Contrato</label>
                        <input type="date" class="form-control" name="dtcontratoPers" id="dtcontratoPers" required>
                    </div>

                    <div class="col-md-3">
                        <div class="form-label">Status do personal:</div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="statusPers" id="statusPersAtivo" value="true" checked>
                            <label class="form-check-label" for="statusPersAtivo">Ativo</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="statusPers" id="statusPersInativo" value="false">
                            <label class="form-check-label" for="statusPersInativo">Inativo</label>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="CadastrarPersonalForm">Salvar</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal para Novo Administrador -->
<div class="modal fade" id="modalNovoAdministrador" tabindex="-1" aria-labelledby="modalNovoAdministradorLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalNovoAdministradorLabel">Cadastrar Novo Administrador</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="CadastrarAdministradorForm" class="row g-3" action="CadastrarAdministrador" method="POST" enctype="multipart/form-data">

                    <!-- Imagem do Administrador -->
                    <div class="col-12 d-flex justify-content-around text-center">
                        <div class="col-6 d-flex justify-content-center align-items-center">
                            <img id="imgPreviewAdm" src="#" alt="Imagem do Administrador" class="img-thumbnail rounded-circle" style="width: 150px; height: 150px; object-fit: cover; display: none;">
                        </div>
                        <div class="col-6">
                            <label for="imgPessoaAdm" class="form-label">Foto do Administrador</label>
                            <input type="file" class="form-control" id="imgPessoaAdm" name="imgPessoaAdm" onchange="converterImagemAdm();">
                        </div>
                    </div>

                    <input type="hidden" class="form-control" name="codPessoa" id="codPessoaAdm">

                    <div class="col-md-6">
                        <label for="nomePessoa" class="form-label">Nome</label>
                        <input type="text" class="form-control" name="nomePessoa" id="nomePessoaAdm" required>
                    </div>

                    <div class="col-md-6">
                        <label for="emailPessoa" class="form-label">E-mail</label>
                        <input type="email" class="form-control" name="emailPessoa" id="emailPessoaAdm" required>
                    </div>

                    <div class="col-md-4">
                        <label for="senhaPessoa" class="form-label">Senha</label>
                        <input type="password" class="form-control" name="senhaPessoa" id="senhaPessoaAdm" required>
                    </div>

                    <div class="col-md-4">
                        <label for="dtnascPessoa" class="form-label">Data de Nascimento</label>
                        <input type="date" class="form-control" name="dtnascPessoa" id="dtnascPessoaAdm" required>
                    </div>

                    <div class="col-md-4">
                        <label for="cpfPessoa" class="form-label">CPF</label>
                        <input type="text" class="form-control" name="cpfPessoa" id="cpfPessoaAdm" onkeypress="$(this).mask('000.000.000-00')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="rgPessoa" class="form-label">RG</label>
                        <input type="text" class="form-control" name="rgPessoa" id="rgPessoaAdm" onkeypress="$(this).mask('00.000.000-0')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="sexoPessoa" class="form-label">Sexo</label>
                        <select class="form-select" name="sexoPessoa" id="sexoPessoaAdm" required>
                            <option value="Masculino">Masculino</option>
                            <option value="Feminino">Feminino</option>
                            <option value="Outro">Outro</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label for="celularPessoa" class="form-label">Celular</label>
                        <input type="text" class="form-control" name="celularPessoa" id="celularPessoaAdm" onkeypress="$(this).mask('(00) 00000-0000')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="cepPessoa" class="form-label">CEP</label>
                        <input type="text" class="form-control" name="cepPessoa" id="cepPessoaAdm" onkeypress="$(this).mask('00000-000')" required>
                    </div>

                    <div class="col-md-4">
                        <label for="complPessoa" class="form-label">Complemento</label>
                        <input type="text" class="form-control" name="complPessoa" id="complPessoaAdm">
                    </div>

                    <div class="col-md-8">
                        <label for="endPessoa" class="form-label">Endereço</label>
                        <input type="text" class="form-control" name="endPessoa" id="endPessoaAdm" required>
                    </div>

                    <div class="col-md-4">
                        <label for="bairroPessoa" class="form-label">Bairro</label>
                        <input type="text" class="form-control" name="bairroPessoa" id="bairroPessoaAdm" required>
                    </div>

                    <div class="col-md-2">
                        <label for="numeroPessoa" class="form-label">Número</label>
                        <input type="number" class="form-control" name="numeroPessoa" id="numeroPessoaAdm" required>
                    </div>

                    <div class="col-md-6">
                        <label for="cidadePessoa" class="form-label">Cidade</label>
                        <input type="text" class="form-control" name="cidadePessoa" id="cidadePessoaAdm" required>
                    </div>

                    <div class="col-md-3">
                        <label for="ufPessoa" class="form-label">UF</label>
                        <select class="form-select" name="ufPessoa" id="ufPessoaAdm" required>
                            <option value="AC">AC</option>
                            <option value="AL">AL</option>
                            <option value="AP">AP</option>
                            <option value="AM">AM</option>
                            <option value="BA">BA</option>
                            <option value="CE">CE</option>
                            <option value="DF">DF</option>
                            <option value="ES">ES</option>
                            <option value="GO">GO</option>
                            <option value="MA">MA</option>
                            <option value="MT">MT</option>
                            <option value="MS">MS</option>
                            <option value="MG">MG</option>
                            <option value="PA">PA</option>
                            <option value="PB">PB</option>
                            <option value="PR">PR</option>
                            <option value="PE">PE</option>
                            <option value="PI">PI</option>
                            <option value="RJ">RJ</option>
                            <option value="RN">RN</option>
                            <option value="RS">RS</option>
                            <option value="RO">RO</option>
                            <option value="RR">RR</option>
                            <option value="SC">SC</option>
                            <option value="SP">SP</option>
                            <option value="SE">SE</option>
                            <option value="TO">TO</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <div class="form-label">Status do administrador:</div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="statusAdm" id="statusAdmAtivo" value="true" checked>
                            <label class="form-check-label" for="statusAdmAtivo">Ativo</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="statusAdm" id="statusAdmInativo" value="false">
                            <label class="form-check-label" for="statusAdmInativo">Inativo</label>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="CadastrarAdministradorForm">Salvar</button>
            </div>
        </div>
    </div>
</div>



<script>
    function searchTable() {
        let input = document.getElementById('search').value.toLowerCase();
        let table = document.getElementById('userTable');
        let tr = table.getElementsByTagName('tr');

        for (let i = 1; i < tr.length; i++) { // Começa do índice 1 para pular o cabeçalho
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

    function previewImage(inputId, previewId) {
        var file = document.getElementById(inputId).files[0];
        var reader = new FileReader();
        reader.onloadend = function () {
            document.getElementById(previewId).src = reader.result;
            document.getElementById(previewId).style.display = 'block';
        }
        if (file) {
            reader.readAsDataURL(file);
        } else {
            document.getElementById(previewId).src = "img/upload-placeholder.jpg";
        }
    }

    // Funções para cada tipo de usuário com IDs específicos
    function converterImagemAluno() {
        previewImage("imgPessoaA", "imgPreviewA");
    }

    function converterImagemPers() {
        previewImage("imgPessoaPers", "imgPreviewPers");
    }

    function converterImagemAdm() {
        previewImage("imgPessoaAdm", "imgPreviewAdm");
    }
</script>


<jsp:include page="rodape.jsp"/>
