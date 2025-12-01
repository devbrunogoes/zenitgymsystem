<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="cabecalho.jsp"/>
<div class="page">
    <style type="text/css">

        img {
            width: 200px;
            height: 200px;
            border: 2px solid gray;
            padding: 5px;
        }
        .corpo {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .form-group {
            flex: 1;
            min-width: 200px;
        }
        .form-label {
            margin-bottom: 0.5rem;
        }
        .form-control {
            width: 100%;
            box-sizing: border-box;
        }

        .card{
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }
        .corpo {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .receita {
            background-color: #e0ffe0; /* Verde claro */
        }
        .despesa {
            background-color: #ffe0e0; /* Vermelho claro */
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
                <a href="ListarFinancas" class="nav-link py-3 active" title="Financeiro" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-coins "></i>
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
        <div class="container" style="width: 100%;">
            <div class="col-12 mt-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-around">
                        <h2>Gestão Financeira</h2>
                        <hr>

                        <!-- Botões para alternar entre as seções -->
                        <div class="btn-group mb-4" role="group">
                            <button type="button" class="btn btn-outline-dark" onclick="showSection('fluxoCaixa')">Fluxo de Caixa</button>
                            <button type="button" class="btn btn-outline-dark" onclick="showSection('gestaoMensalidades')">Gestão de Mensalidades</button>
                        </div>
                    </div>
                    <div class="card-body ">
                        <!-- Seções da Página -->
                        <div id="fluxoCaixa" class="secao-financeiro">
                            <div class="header d-flex justify-content-around">
                                <h3>Fluxo de Caixa</h3>
                                <a href="#"  data-bs-toggle="modal" data-bs-target="#modalRegistrarMov" style="text-decoration: none;">
                                    + Receita/Despesa
                                </a>
                            </div>


                            <table class="table table-striped table-hover p-3 text-center">
                                <thead>
                                    <tr>
                                        <th>Data</th>
                                        <th>Descrição</th>
                                        <th>Tipo</th>
                                        <th>Valor</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="movFin" items="${movfins}">
                                        <!-- Condicional para definir a cor da linha -->
                                        <tr style="background-color: ${movFin.tipoMov ? '#e0f7e9' : '#fbe4e6'};">
                                            <!-- Conversão da data para o formato brasileiro -->
                                            <td>
                                                <fmt:parseDate value="${movFin.dtMov}" pattern="yyyy-MM-dd" var="dataFormatada" />
                                                <fmt:formatDate value="${dataFormatada}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>${movFin.descMov}</td>
                                            <td>${movFin.tipoMov ? 'Receita' : 'Despesa'}</td>
                                            <td>R$ ${movFin.valorMov}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div id="gestaoMensalidades" class="secao-financeiro" style="display:none;">
                            <h3>Gestão de Mensalidades</h3>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Aluno</th>
                                        <th>Data de Pagamento</th>
                                        <th>Status</th>
                                        <th>Valor</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>João Silva</td>
                                        <td>01/11/2024</td>
                                        <td>Pago</td>
                                        <td>R$ 100,00</td>
                                    </tr>
                                    <tr>
                                        <td>Maria Souza</td>
                                        <td>02/11/2024</td>
                                        <td>Não Pago</td>
                                        <td>R$ 100,00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal para Registrar Receita/Despesa -->
<div class="modal fade" id="modalRegistrarMov" tabindex="-1" aria-labelledby="modalRegistrarMovLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalRegistrarMovLabel">Registrar Receita/Despesa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" action="CadastrarMovFin">
                    <!-- Campo oculto para o código do movimento financeiro -->
                    <input type="hidden" class="form-control" name="codMov" value="${movFin.codMov == 0 ? '' : movFin.codMov}">

                    <!-- Campo de Data -->
                    <div class="form-group mb-3">
                        <label for="data">Data</label>
                        <input type="date" id="data" name="dtMov" class="form-control" required>
                    </div>

                    <!-- Campo de Valor -->
                    <div class="form-group mb-3">
                        <label for="valor">Valor</label>
                        <input type="number" step="0.01" id="valor" name="valorMov" class="form-control" required>
                    </div>

                    <!-- Campo de Tipo (Receita ou Despesa) -->
                    <div class="form-group mb-3">
                        <label for="tipo">Tipo</label>
                        <select id="tipo" name="tipoMov" class="form-control" required>
                            <option value="true">Receita</option>
                            <option value="false">Despesa</option>
                        </select>
                    </div>

                    <!-- Campo de Descrição -->
                    <div class="form-group mb-3">
                        <label for="descricao">Descrição</label>
                        <input type="text" id="descricao" name="descMov" class="form-control" required>
                    </div>

                    <!-- Campo de Tipo de Pagamento -->
                    <div class="form-group mb-3">
                        <label for="tipoPag">Pagamento</label>
                        <select id="tipoPag" name="tipoPagMov" class="form-control" required>
                            <option value="Cartão">Cartão</option>
                            <option value="Dinheiro">Dinheiro</option>
                            <option value="Pix">Pix</option>
                        </select>
                    </div>

                    <!-- Campo de Categoria -->
                    <div class="form-group mb-3">
                        <label for="categoria">Categoria</label>
                        <input type="text" id="categoria" name="categoriaMov" class="form-control" required>
                    </div>

                    <!-- Campo de Observação -->
                    <div class="form-group mb-3">
                        <label for="obs">Observação</label>
                        <textarea id="obs" name="obsMov" class="form-control"></textarea>
                    </div>

                    <!-- Botão de envio -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                        <button type="submit" class="btn btn-primary">Registrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function showSection(sectionId) {
        // Esconde todas as seções
        const sections = document.querySelectorAll('.secao-financeiro');
        sections.forEach(section => {
            section.style.display = 'none';
        });
        // Exibe a seção selecionada
        document.getElementById(sectionId).style.display = 'block';
    }


</script>

<jsp:include page="rodape.jsp"/>
