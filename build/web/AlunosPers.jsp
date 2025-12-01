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
                <a href="home.jsp" class="nav-link py-3 " aria-current="page" title="Início" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-house fa"></i>
                </a>
            </li>
            
            <li>
                <a href="ListarAlunosPers" class="nav-link py-3 active" title="Alunos" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-users "></i>
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
        <div class="container" style="width: 100%;">
            <div class="col-12 mt-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-around">
                        <h3>Meus Alunos</h3>
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
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="aluno" items="${alunospers}">
                                    <tr>
                                       <td class="text-center">
                                            <img src="img/Fts-Perfil/${aluno.imgPessoa != null ? aluno.imgPessoa : 'default.jpg'}" class="rounded-circle" style="width: 30px; height: 30px;">
                                        </td>
                                        <td>${aluno.codPessoa}</td>
                                        <td>${aluno.nomePessoa}</td>
                                        <td>${aluno.cpfPessoa}</td>
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




<script>
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



    // Função para converter imagem para base64
    function carregarImagem() {
        const fileInput = document.getElementById('imgUsuario');
        const preview = document.getElementById('imgPreview');
        const file = fileInput.files[0];
        const reader = new FileReader();
        reader.onloadend = function () {
            preview.src = reader.result;
        }

        if (file) {
            reader.readAsDataURL(file);
        } else {
            preview.src = "img/upload-placeholder.jpg";
        }
    }
</script>

<jsp:include page="rodape.jsp"/>
