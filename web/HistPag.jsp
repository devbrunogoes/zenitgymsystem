<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <a href="HistPag.jsp" class="nav-link py-3 active" title="Pagamentos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-money-bill "></i>
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

    <div class="pag" style=" color: #333333; min-height: 100vh; padding: 20px;">
        <div class="container">
            <!-- Cabeçalho -->
            <div class="row mb-4">
                <div class="col text-center">
                    <h2 style="color: #131313;">Histórico de Pagamentos</h2>
                    <p class="lead" style="color: #555555;">Acompanhe o histórico de mensalidades, compras, análises e mais.</p>
                </div>
            </div>

            <!-- Filtros -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <label for="filtroData" class="form-label" style="color: #555555;">Filtrar por Data:</label>
                    <input type="date" id="filtroData" class="form-control" style="background-color: #f9f9f9; color: #333333; border: 1px solid #ccc;">
                </div>
                <div class="col-md-4">
                    <label for="filtroTipo" class="form-label" style="color: #555555;">Filtrar por Tipo:</label>
                    <select id="filtroTipo" class="form-select" style="background-color: #f9f9f9; color: #333333; border: 1px solid #ccc;">
                        <option value="mensalidade">Mensalidades</option>
                        <option value="compras">Compras</option>
                        <option value="analises">Análises</option>
                    </select>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button class="btn btn-dark w-100" style="background-color: #131313; color: #feff00;">Aplicar Filtros</button>
                </div>
            </div>

            <!-- Tabela do Histórico -->
            <div class="row">
                <div class="col">
                    <div class="card" style="background-color: #f9f9f9; border: 1px solid #ccc;">
                        <div class="card-header text-center" style="background-color: #131313; color: #ffffff;">
                            <h5 style="color: #feff00">Detalhes do Histórico</h5>
                        </div>
                        <div class="card-body p-0">
                            <table class="table table-striped mb-0">
                                <thead style="background-color: #131313; color: #ffffff;">
                                    <tr style="color: #feff00">
                                        <th scope="col">Data</th>
                                        <th scope="col">Tipo</th>
                                        <th scope="col">Descrição</th>
                                        <th scope="col">Valor</th>
                                        <th scope="col">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Exemplo de Linha -->
                                    <tr>
                                        <td>22/11/2024</td>
                                        <td>Mensalidade</td>
                                        <td>Plano Fitness</td>
                                        <td>R$ 120,00</td>
                                        <td><span class="badge bg-success">Pago</span></td>
                                    </tr>
                                    <tr>
                                        <td>15/11/2024</td>
                                        <td>Compras</td>
                                        <td>Camisa da Academia</td>
                                        <td>R$ 50,00</td>
                                        <td><span class="badge bg-danger">Pendente</span></td>
                                    </tr>
                                    <!-- Adicionar mais registros dinamicamente -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
<jsp:include page="rodape.jsp"/>
