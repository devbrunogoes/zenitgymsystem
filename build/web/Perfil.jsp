<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"></jsp:include>
<%
    HttpSession sessao = request.getSession(false);
    Usuario usuario = (Usuario) sessao.getAttribute("usuario");
    if (usuario.getPerfilUsuario().equals("Aluno")) {
%>
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
        <ul class="nav nav-pills nav-flush flex-column mb-auto text-center">
            <li class="nav-item">
                <a href="home.jsp" class="nav-link  py-3" aria-current="page" title="Inicio" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house fa"></i>
                </a>
            </li>

            <li>
                <a href="ListarEventoCal" class="nav-link py-3 " title="Agenda" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-calendar-days fa"></i>
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
        <form class="row align-self-center" action="PerfilAluno">
            <div class="text-center">
                <img src="img/Fts-Perfil/<%= urlImagem%>" class="rounded-circle" alt="Imagem do Aluno">
            </div>
            <div class="corpo d-flex">
                <!-- Campos do formulário, todos em readonly -->
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Código Aluno</label>
                    <input type="text" class="form-control" readonly value="${aluno.codAluno}">
                </div>
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Código Pessoa</label>
                    <input type="text" class="form-control" readonly value="${aluno.codPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Nome</label>
                    <input type="text" class="form-control" readonly value="${aluno.nomePessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Data de Nascimento</label>
                    <input type="text" class="form-control" readonly value="${aluno.dtnascPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Data de Matrícula</label>
                    <input type="text" class="form-control" readonly value="${aluno.dtMatriculaAluno}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">CPF</label>
                    <input type="text" class="form-control" readonly value="${aluno.cpfPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">RG</label>
                    <input type="text" class="form-control" readonly value="${aluno.rgPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Sexo</label>
                    <input type="text" class="form-control" readonly value="${aluno.sexoPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Celular</label>
                    <input type="text" class="form-control" readonly value="${aluno.celularPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">CEP</label>
                    <input type="text" class="form-control" readonly value="${aluno.cepPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Endereço</label>
                    <input type="text" class="form-control" readonly value="${aluno.endPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Número</label>
                    <input type="text" class="form-control" readonly value="${aluno.numeroPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Bairro</label>
                    <input type="text" class="form-control" readonly value="${aluno.bairroPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Cidade</label>
                    <input type="text" class="form-control" readonly value="${aluno.cidadePessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">UF</label>
                    <input type="text" class="form-control" readonly value="${aluno.ufPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Observações</label>
                    <input type="text" class="form-control" readonly value="${aluno.obsAluno}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Status</label>
                    <input type="text" class="form-control" readonly value="${aluno.statusAluno ? 'Ativo' : 'Inativo'}">
                </div>
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Personal Responsável</label>
                    <input type="text" class="form-control" readonly value="${aluno.personal.nomePessoa}">
                </div>
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Plano</label>
                    <input type="text" class="form-control" readonly value="${aluno.plano.nomePlano}">
                </div>
            </div>
        </form>
    </div>
</div>


<%
} else if (usuario.getPerfilUsuario().equals("Personal")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Personal poderá vizualizar-->
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
        <form class="row align-self-center" action="PerfilPersonal">
            <div class="text-center">
                <img src="img/Fts-Perfil/<%= usuarioLogado != null ? usuarioLogado.getImgUsuario() : "default.jpg"%>" class="rounded-circle" alt="Imagem do Personal">
            </div>
            <div class="corpo d-flex">
                <!-- Campos do formulário para o Personal, todos em readonly -->
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Código P</label>
                    <input type="text" class="form-control" readonly value="${personal.codPers}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Nome</label>
                    <input type="text" class="form-control" readonly value="${personal.nomePessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Senha</label>
                    <input type="password" class="form-control" readonly value="${personal.senhaPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Data de Nascimento</label>
                    <input type="text" class="form-control" readonly value="${personal.dtnascPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Data de Contrato</label>
                    <input type="text" class="form-control" readonly value="${personal.dtcontratoPers}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">CPF</label>
                    <input type="text" class="form-control" readonly value="${personal.cpfPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">RG</label>
                    <input type="text" class="form-control" readonly value="${personal.rgPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Sexo</label>
                    <input type="text" class="form-control" readonly value="${personal.sexoPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Celular</label>
                    <input type="text" class="form-control" readonly value="${personal.celularPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">CEP</label>
                    <input type="text" class="form-control" readonly value="${personal.cepPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Endereço</label>
                    <input type="text" class="form-control" readonly value="${personal.endPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Complemento</label>
                    <input type="text" class="form-control" readonly value="${personal.complPessoa}">
                </div>
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Número</label>
                    <input type="text" class="form-control" readonly value="${personal.numeroPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Bairro</label>
                    <input type="text" class="form-control" readonly value="${personal.bairroPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Cidade</label>
                    <input type="text" class="form-control" readonly value="${personal.cidadePessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">UF</label>
                    <input type="text" class="form-control" readonly value="${personal.ufPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Status</label>
                    <input type="text" class="form-control" readonly value="${personal.statusPers ? 'Ativo' : 'Inativo'}">
                </div>
            </div>
        </form>
    </div>
</div>

<%
} else if (usuario.getPerfilUsuario().equals("Administrador")) {
%>
<!--Dentro deste parametro colocar apenas as atribuições que o Administrador poderá vizualizar-->
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
        <form class="row align-self-center" action="Perfil">
            <div class="text-center">
                <img src="img/Fts-Perfil/<%= urlImagem%>" class="rounded-circle" alt="Imagem do Administrador">
            </div>
            <div class="corpo d-flex">
                <!-- Campos do formulário, todos em readonly -->
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Código A</label>
                    <input type="text" class="form-control" readonly value="${administrador.codAdm}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Código P</label>
                    <input type="text" class="form-control" readonly value="${administrador.codPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Nome</label>
                    <input type="text" class="form-control" readonly value="${administrador.nomePessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Senha</label>
                    <input type="password" class="form-control" readonly value="${administrador.senhaPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Data de Nascimento</label>
                    <input type="text" class="form-control" readonly value="${administrador.dtnascPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">CPF</label>
                    <input type="text" class="form-control" readonly value="${administrador.cpfPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">RG</label>
                    <input type="text" class="form-control" readonly value="${administrador.rgPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Sexo</label>
                    <input type="text" class="form-control" readonly value="${administrador.sexoPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Celular</label>
                    <input type="text" class="form-control" readonly value="${administrador.celularPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">CEP</label>
                    <input type="text" class="form-control" readonly value="${administrador.cepPessoa}">
                </div>
                <div class="col-md-4 form-group">
                    <label for="" class="form-label">Endereço</label>
                    <input type="text" class="form-control" readonly value="${administrador.endPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Complemento</label>
                    <input type="text" class="form-control" readonly value="${administrador.complPessoa}">
                </div>
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">Número</label>
                    <input type="text" class="form-control" readonly value="${administrador.numeroPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Bairro</label>
                    <input type="text" class="form-control" readonly value="${administrador.bairroPessoa}">
                </div>
                <div class="col-md-3 form-group">
                    <label for="" class="form-label">Cidade</label>
                    <input type="text" class="form-control" readonly value="${administrador.cidadePessoa}">
                </div>
                <div class="col-md-1 form-group">
                    <label for="" class="form-label">UF</label>
                    <input type="text" class="form-control" readonly value="${administrador.ufPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Email</label>
                    <input type="text" class="form-control" readonly value="${administrador.emailPessoa}">
                </div>
                <div class="col-md-2 form-group">
                    <label for="" class="form-label">Status</label>
                    <input type="text" class="form-control" readonly value="${administrador.statusAdm ? 'Ativo' : 'Inativo'}">
                </div>
            </div>
        </form>
    </div>
</div>

<%
    }
%>
<jsp:include page="rodape.jsp" ></jsp:include>