<%@page import="br.com.zenitgymsystem.dao.PersonalDAO"%>
<%@page import="br.com.zenitgymsystem.model.Personal"%>
<%@page import="br.com.zenitgymsystem.model.Aula"%>
<%@page import="java.util.List"%>
<%@page import="br.com.zenitgymsystem.dao.AulaDAO"%>
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
        .card{
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }
        .botoesExpandido {
                display: none; /* Inicialmente escondidos */
                padding: 10px 0;
            }
            tr.linhaExpandida + tr.botoesExpandido {
                display: table-row; /* Exibe quando a linha está expandida */
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
                <a href="AulasCRUD.jsp" class="nav-link py-3 active" title="Aulas" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-book"></i>
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
                        <h3>Gerenciamento de Aulas</h3>
                        <a class="btn btn-outline-primary" href="#" data-bs-toggle="modal" data-bs-target="#modalCadastroAula">+ Cadastrar Nova Aula</a>
                    </div>
                    <div class="card-body ">
                        <table class="table table-striped table-hover p-3 text-center">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nome</th>
                                    <th>Descrição</th>
                                    <th>Data</th>
                                    <th>Horário</th>
                                    <th>Professor</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Recuperar a lista de aulas do banco de dados
                                    AulaDAO aulaDAO = new AulaDAO();
                                    List<Object> listaAulas = aulaDAO.listar();

                                    for (Object obj : listaAulas) {
                                        Aula aula = (Aula) obj;
                                %>
                                <tr class="linhaAula" onclick="toggleLinha(this);">
                                    <td><%= aula.getCodAula()%></td>
                                    <td><%= aula.getNomeAula()%></td>
                                    <td><%= aula.getDescAula()%></td>
                                    <td><%= aula.getDtAula()%></td>
                                    <td><%= aula.getHorarioAula()%></td>
                                    <td><%= aula.getPersonal().getNomePessoa()%></td>
                                    <td>

                                    </td>
                                </tr>
                                <tr class="botoesExpandido">
                                    <td colspan="6" style="text-align: center;">
                                        <button class="btn btn-warning btn-sm">Editar</button>
                                        <button class="btn btn-danger btn-sm">Excluir</button>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal para cadastrar nova aula -->
<div class="modal fade" id="modalCadastroAula" tabindex="-1" aria-labelledby="modalCadastroAulaLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalCadastroAulaLabel">Cadastrar Nova Aula</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="CadastrarAula" method="post">
                    <input type="hidden" name="codAula" id="codAula"  value="${aula.codAula == 0 ? '' : aula.codAula}" required/>
                    <div class="mb-3">
                        <label for="nomeAula" class="form-label">Nome da Aula</label>
                        <input type="text" class="form-control" id="nomeAula" name="nomeAula" required>
                    </div>
                    <div class="mb-3">
                        <label for="descAula" class="form-label">Descrição</label>
                        <textarea class="form-control" id="descAula" name="descAula" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="dtAula" class="form-label">Data da Aula</label>
                        <input type="date" class="form-control" id="dtAula" name="dtAula" required>
                    </div>
                    <div class="mb-3">
                        <label for="horarioAula" class="form-label">Horario da Aula</label>
                        <input type="time" class="form-control" id="horarioAula" name="horarioAula" required>
                    </div>
                    <!-- Selecionar o Personal -->
                    <div class="mb-3">
                        <label for="codPers" class="form-label text-white">Selecione o Professor</label>
                        <select name="codPers" id="codPers" class="form-select" required>
                            <option value="">Selecione o Professor</option>
                            <%
                                // Certifique-se de que a lista chamada listaPersonais está sendo carregada corretamente
                                PersonalDAO personalDAO = new PersonalDAO();
                                List<Object> listaPersonais = personalDAO.listar(); // Método para listar todos os personais

                                for (Object obj : listaPersonais) {
                                    Personal personal = (Personal) obj;
                            %>
                            <option value="<%= personal.getCodPers()%>"><%= personal.getNomePessoa()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-success">Cadastrar</button>
                </form>
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
<jsp:include page="rodape.jsp"/>
