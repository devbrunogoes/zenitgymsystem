<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page import="br.com.zenitgymsystem.model.Equipamento"%>
<%@page import="br.com.zenitgymsystem.dao.EquipamentoDAO"%>
<%@page import="java.util.List"%>
<%@page import="br.com.zenitgymsystem.dao.FornecedorDAO"%>
<%@page import="br.com.zenitgymsystem.model.Fornecedor"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"/>
<style type="text/css">
    
    th{
        font-size: 0.9rem;
    }
    td{
        font-size: 0.85rem;
    }
    .botoesExpandido {
        display: none; /* Inicialmente escondidos */
        padding: 10px 0;
    }
    tr.linhaExpandida + tr.botoesExpandido {
        display: table-row; /* Exibe quando a linha está expandida */
    }
    .header {
        cursor: pointer;
        background-color: green;
        color: white;
        padding: 10px;
    }
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
                <a href="ListarEEF" class="nav-link py-3 active" title="Fornecedores" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-truck-fast "></i>
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
        <div class="container" style="width: 100%;">
            <div class="col-12 mt-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3>Entregas</h3>
                        <form class="d-flex" role="search">
                            <input class="form-control me-2" type="search" placeholder="Pesquisar Entrega..." aria-label="Search" id="search" name="search" onkeyup="searchTable()" style="font-size: 0.875rem;">                            
                            <a class="btn btn-outline-success" href="NovaEntrega" data-bs-toggle="modal" data-bs-target="#modalNovaEntrega"><i class="fa-solid fa-plus"></i></a>
                        </form>
                    </div>
                    <div class="card-body" style="overflow-y: auto; max-height:300px;">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Data</th>
                                    <th>Fornecedor</th>
                                    <th>Equipamento</th>
                                    <th>Quantidade</th>
                                    <th>Endereço</th>
                                    <th>Status</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="entrega" items="${entregas}">
                                    <tr class="linhaEntrega" onclick="toggleLinha(this);">
                                        <td>${entrega.dataEntrega}</td>
                                        <td>${entrega.fornecedor.nomeForn}</td>
                                        <td>${entrega.equipamento.nomeEquip}</td>
                                        <td>${entrega.quantEntrega}</td>
                                        <td>${entrega.enderecoEntrega}</td>
                                        <td>${entrega.statusEntrega}</td>
                                        
                                    </tr>
                                    <tr class="botoesExpandido">
                                        <td colspan="6" style="text-align: center;">
                                            <a class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#modalAlterarEntrega" data-id="${entrega.codEntrega}"><i class="fa-solid fa-pencil"></i> Alterar</a> 
                                            <a class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalExclusaoEntrega" data-id="${entrega.codEntrega}" title="Excluir entrega"><i class="fa-solid fa-trash"></i> Excluir</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-12 mt-4">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h3>Equipamentos</h3>
                            <form class="d-flex" role="search">
                                <input class="form-control me-2" type="search" placeholder="Pesquisar Equipamento..." aria-label="Search" id="search" name="search" onkeyup="searchTable()" style="font-size: 0.875rem;">                                
                                <a class="btn btn-outline-success" href="NovoEquipamento" data-bs-toggle="modal" data-bs-target="#modalNovoEquipamento"><i class="fa-solid fa-plus"></i></a>
                            </form>
                        </div>
                        <div class="card-body" style="overflow-y: auto; max-height:300px;">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Nome</th>
                                        <th>Descrição</th>
                                        <th>Fornecedor</th>
                                        <th>Data de Aquisição</th>
                                        <th>Estado</th>
                                        <th>Status</th>
                                        <th>Última Manutenção</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="equipamento" items="${equipamentos}">
                                        <tr class="linhaEquipamento" onclick="toggleLinha(this);">
                                            <td>${equipamento.nomeEquip}</td>
                                            <td>${equipamento.descEquip}</td>
                                            <td>${equipamento.fornecedor.nomeForn}</td> <!-- Exibe o nome do fornecedor -->
                                            <td>${equipamento.dtAquisicaoEquip}</td>
                                            <td>${equipamento.estadoConsEquip}</td>
                                            <td>${equipamento.statusEquip}</td>
                                            <td>${equipamento.dtUltManuEquip}</td>
                                        </tr>
                                        <tr class="botoesExpandido">
                                            <td colspan="7" style="text-align: center;">
                                                <a class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#modalAlterarEquipamento" data-id="${equipamento.codEquip}"><i class="fa-solid fa-pencil"></i> Alterar</a> 
                                                <a class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalExclusaoEquipamento" data-id="${equipamento.codEquip}" title="Excluir equipamento"><i class="fa-solid fa-trash"></i> Excluir</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>



                <div class="col-12 mt-4">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h3 class="mb-0">Fornecedores</h3>
                            <form class="d-flex" role="search">
                                <input class="form-control me-2" type="search" placeholder="Pesquisar Fornecedor..." aria-label="Search" id="search" name="search" onkeyup="searchTable()" style="font-size: 0.875rem;">
                                <a class="btn btn-outline-success" href="NovoFornecedor" data-bs-toggle="modal" data-bs-target="#modalNovoFornecedor"><i class="fa-solid fa-plus"></i></a>

                            </form>
                        </div>

                        <div class="card-body" style="overflow-y: auto; max-height:300px;">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Nome</th>
                                            <th>Celular</th>
                                            <th>E-mail</th>
                                            <th>CNPJ</th>
                                            <th>Endereço</th>
                                            <th>Data de Cadastro</th>
                                            <th>Status</th>
                                            <th>Observações</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="fornecedor" items="${fornecedores}">
                                            <tr class="linhaFornecedor" onclick="toggleLinha(this);">
                                                <td>${fornecedor.nomeForn}</td>
                                                <td>${fornecedor.celularForn}</td>
                                                <td>${fornecedor.emailForn}</td>
                                                <td>${fornecedor.cnpjForn}</td>
                                                <td>${fornecedor.enderecoForn}</td>
                                                <td>${fornecedor.dtCadastroForn}</td>
                                                <td>${fornecedor.statusForn ? 'Ativo' : 'Inativo'}</td>
                                                <td>${fornecedor.obsForn}</td>
                                            </tr>
                                            <tr class="botoesExpandido">
                                                <td colspan="8" style="text-align: center;">
                                                    <a class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#modalAlterarFornecedor"
                                                       data-codforn="${fornecedor.codForn}" data-nomeforn="${fornecedor.nomeForn}" 
                                                       data-celularforn="${fornecedor.celularForn}" data-emailforn="${fornecedor.emailForn}">
                                                        <i class="fa-solid fa-pencil"></i> Alterar
                                                    </a> 
                                                    <a class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalExclusao"
                                                       data-codforn="${fornecedor.codForn}" data-nomeforn="${fornecedor.nomeForn}" title="Excluir fornecedor">
                                                        <i class="fa-solid fa-trash"></i> Excluir
                                                    </a>
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
        </div>
    </div>
</div>
<!--Modal Novo Fornecedor -->
<div class="modal fade" id="modalNovoFornecedor" tabindex="-1" aria-labelledby="modalNovoFornecedorLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalNovoFornecedorLabel">Cadastrar Novo Fornecedor</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="CadastrarFornecedorForm" class="row text-center container-fluid" action="CadastrarFornecedor" method="post">
                    <div class="col-md-6">
                        <label class="form-label">Nome</label>
                        <input type="hidden" name="codForn" id="codForn" value="${fornecedor.codForn == 0 ? '' : fornecedor.codForn}">
                        <input type="text" class="form-control" name="nomeForn" id="nomeForn" required="" value="${fornecedor.nomeForn}" placeholder="Informe o Nome..." />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Celular</label>
                        <input type="text" class="form-control" name="celularForn" onkeypress="$(this).mask('(00) 00000-0000')" id="celularForn" value="${fornecedor.celularForn}" placeholder="Informe o Celular..." required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="emailForn" id="emailForn" required="" value="${fornecedor.emailForn}" placeholder="Informe o E-mail..." />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">CNPJ</label>
                        <input type="text" class="form-control" name="cnpjForn" id="cnpjForn"  value="${fornecedor.cnpjForn}" placeholder="Informe o CNPJ..." data-mask="00.000.000/0000-00"/>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Endereço</label>
                        <input type="text" class="form-control" name="enderecoForn" id="enderecoForn" required="" value="${fornecedor.enderecoForn}" placeholder="Informe o Endereço..." />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Data de Cadastro</label>
                        <input type="date" class="form-control" name="dtCadastroForn" id="dtCadastroForn" required="" value="${fornecedor.dtCadastroForn}" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Status</label>
                        <select class="form-select" name="statusForn" id="statusForn" required>
                            <option value="">Selecione...</option>
                            <option value="Ativo"${fornecedor.statusForn == 'Ativo' ? 'selected' : ''}>Ativo</option>
                            <option value="Inativo"${fornecedor.statusForn == 'Inativo' ? 'selected' : ''}">Inativo</option>
                        </select>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Observações</label>
                        <textarea class="form-control" name="obsForn" id="obsForn" rows="3" placeholder="Observações...">${fornecedor.obsForn}</textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="CadastrarFornecedorForm">Salvar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Inserir Equipamento -->
<div class="modal fade" id="modalNovoEquipamento" tabindex="-1" aria-labelledby="modalNovoEquipamentoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalNovoEquipamentoLabel">Cadastrar Novo Equipamento</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="CadastrarEquipamentoForm" class="row text-center container-fluid" action="CadastrarEquip" method="post">
                    <div class="col-md-6">
                        <input type="hidden" name="codEquip" id="codEquip"  value="${equipamento.codEquip == 0 ? '' : equipamento.codEquip}" required/>
                        <label class="form-label">Fornecedor</label>
                        <select class="form-select" name="codForn" id="codForn" required>
                            <option value="" disabled selected>Selecione o Fornecedor</option>
                            <c:forEach var="fornecedor" items="${fornecedores}">
                                <option value="${fornecedor.codForn}">${fornecedor.nomeForn}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Nome</label>
                        <input type="text" class="form-control" name="nomeEquip" id="nomeEquip" required placeholder="Informe o Nome..." />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Descrição</label>
                        <input type="text" class="form-control" name="descEquip" id="descEquip" required placeholder="Informe a Descrição..." />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Data de Aquisição</label>
                        <input type="date" class="form-control" name="dtAquisicaoEquip" required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Estado de Conservação</label>
                        <select class="form-select" name="estadoConsEquip" required>
                            <option value="novo">Novo</option>
                            <option value="usado">Usado</option>
                            <option value="precisa de reparo">Precisa de Reparo</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Status</label>
                        <select class="form-select" name="statusEquip" required>
                            <option value="ativo">Ativo</option>
                            <option value="inativo">Inativo</option>
                            <option value="manutencao">Em Manutenção</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Última Manutenção</label>
                        <input type="date" class="form-control" name="dtUltManuEquip" />
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="CadastrarEquipamentoForm">Salvar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Nova Entrega -->
<div class="modal fade" id="modalNovaEntrega" tabindex="-1" aria-labelledby="modalNovaEntregaLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalNovaEntregaLabel">Cadastrar Nova Entrega</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="CadastrarEntregaForm" class="container-fluid" action="CadastrarEntrega" method="post">
                    <div class="row">
                        <input type="hidden" name="codEntrega" id="codEntrega"  value="${entrega.codEntrega == 0 ? '' : entrega.codEntrega}" required/>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Fornecedor</label>
                            <select class="form-select" name="codForn" id="codForn" required>
                                <option value="" disabled selected>Selecione o Fornecedor</option>
                                <c:forEach var="fornecedor" items="${fornecedores}">
                                    <option value="${fornecedor.codForn}">${fornecedor.nomeForn}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Equipamento</label>
                            <select class="form-select" id="codEquip" name="codEquip" required>
                                <option value="">Selecione um equipamento</option>
                                <c:forEach var="equipamento" items="${equipamentos}">
                                    <option value="${equipamento.codEquip}">${equipamento.nomeEquip}</option>
                                </c:forEach>
                            </select>

                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Data da Entrega</label>
                            <input type="date" class="form-control" name="dataEntrega" id="dataEntrega" required />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Quantidade</label>
                            <input type="number" class="form-control" name="quantEntrega" id="quantEntrega" min="1" required />
                        </div>
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Endereço de Entrega</label>
                            <input type="text" class="form-control" name="enderecoEntrega" id="enderecoEntrega" required />
                        </div>
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-select" name="statusEntrega" id="statusEntrega" required>
                                <option value="Pendente">Pendente</option>
                                <option value="Entregue">Entregue</option>
                                <option value="Cancelada">Cancelada</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="CadastrarEntregaForm">Salvar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Alterar Fornecedor -->
<div class="modal fade" id="modalAlterarFornecedor" tabindex="-1" aria-labelledby="modalAlterarFornecedorLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAlterarFornecedorLabel">Alterar Fornecedor</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="AlterarFornecedorForm" class="row text-center container-fluid" action="AlterarFornecedor" method="post">
                    <input type="hidden" name="codForn" id="codFornAlterar" value="" />
                    <div class="col-md-6">
                        <label class="form-label">Nome</label>
                        <input type="text" class="form-control" name="nomeForn" id="nomeFornAlterar" required placeholder="Informe o Nome..." />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Celular</label>
                        <input type="text" class="form-control" name="celularForn" onkeypress="$(this).mask('(00) 00000-0000')" id="celularFornAlterar" placeholder="Informe o Celular..." required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="emailForn" id="emailFornAlterar" required placeholder="Informe o E-mail..." />
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-primary" form="AlterarFornecedorForm">Salvar Alterações</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal de Confirmação -->
<div class="modal fade" id="modalExclusao" aria-hidden="true" aria-labelledby="modalExclusaoLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalExclusaoLabel">Confirmar Exclusão</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Tem certeza que deseja excluir o fornecedor(a) <span id="nomeForn"></span>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <form id="excluirForm" method="post" action="ExcluirFornecedor">
                    <input type="hidden" name="codForn" id="codForn">
                    <button type="submit" class="btn btn-danger" id="liveToastBtn">Excluir</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    //Funcão para a barra de pesquisa
    function searchTable() {
        let input = document.getElementById('search').value.toLowerCase();
        let table = document.getElementById('userTable');
        let tr = table.getElementsByTagName('tr');
        for (let i = 1; i < tr.length; i++) {  // Start from 1 to skip the header row
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

    //Função para auto escrever o nome do Fornecedor nos outros modais
    var modalExclusao = document.getElementById('modalExclusao');
    modalExclusao.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget;
        var codForn = button.getAttribute('data-codforn');
        var nomeForn = button.getAttribute('data-nomeforn');
        var modalBody = modalExclusao.querySelector('.modal-body #nomeForn');
        var modalFormInput = modalExclusao.querySelector('.modal-footer #codForn');
        modalBody.textContent = nomeForn;
        modalFormInput.value = codForn;
    });
    // Função para auto preencher os campos do modal de alterar fornecedor
    var modalAlterarFornecedor = document.getElementById('modalAlterarFornecedor');
    modalAlterarFornecedor.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget;
        var codForn = button.getAttribute('data-codforn');
        var nomeForn = button.getAttribute('data-nomeforn');
        var celularForn = button.getAttribute('data-celularforn');
        var emailForn = button.getAttribute('data-emailforn');
        var modalBodyInputCod = modalAlterarFornecedor.querySelector('#codFornAlterar');
        var modalBodyInputNome = modalAlterarFornecedor.querySelector('#nomeFornAlterar');
        var modalBodyInputCelular = modalAlterarFornecedor.querySelector('#celularFornAlterar');
        var modalBodyInputEmail = modalAlterarFornecedor.querySelector('#emailFornAlterar');
        modalBodyInputCod.value = codForn;
        modalBodyInputNome.value = nomeForn;
        modalBodyInputCelular.value = celularForn;
        modalBodyInputEmail.value = emailForn;
    });
    $(document).ready(function () {
        $('#nomeForn').select2({
            placeholder: "Selecione o Fornecedor",
            allowClear: true
        });
    });
    // Verifica se há uma mensagem antes de exibir o Toast
    <c:if test="${mensagem != null}">
    var liveToast = new bootstrap.Toast(document.getElementById('liveToast'));
    liveToast.show();
    </c:if>
    function toggleLinha(tr) {
        $(tr).toggleClass('linhaExpandida'); // Adiciona ou remove a classe para expandir a linha
        $(tr).next('.botoesExpandido').slideToggle(); // Alterna a exibição da linha de botões
    }

</script>


<jsp:include page="rodape.jsp"/>