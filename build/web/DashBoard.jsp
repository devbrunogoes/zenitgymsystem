<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"></jsp:include>

    <!--Dentro deste parametro colocar apenas as atribuições que o Administrador poderá vizualizar-->
    <div class="page">
        <style>
            .pag {
                font-family: Arial, sans-serif;
            }
            .card-header h5 {
                font-weight: bold;
                margin: 0;
            }
            .card-body canvas {
                max-height: 300px;
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
                    <a href="DashBoard.jsp" class="nav-link py-3 active" title="Dashboard" data-bs-toggle="tooltip" data-bs-placement="right">
                        <i class="fa-solid fa-chart-pie "></i>
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
    <div class="pag" style=" color: #feff00; min-height: 100vh; padding: 20px;">
        <div class="container">
            <div class="row">
                <!-- Gráfico de Receitas vs Despesas -->
                <div class="col-md-6 mb-4">
                    <div class="card" style="background-color: #131313; border: 1px solid #feff00;">
                        <div class="card-header text-center" style="background-color: #feff00; color: #131313;">
                            <h5>Receitas vs Despesas</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="receitasDespesasChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Gráfico de Fluxo de Caixa -->
                <div class="col-md-6 mb-4">
                    <div class="card" style="background-color: #131313; border: 1px solid #feff00;">
                        <div class="card-header text-center" style="background-color: #feff00; color: #131313;">
                            <h5>Fluxo de Caixa</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="fluxoCaixaChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Gráfico de Gestão de Mensalidades -->
                <div class="col-md-6 mb-4">
                    <div class="card" style="background-color: #131313; border: 1px solid #feff00;">
                        <div class="card-header text-center" style="background-color: #feff00; color: #131313;">
                            <h5>Gestão de Mensalidades</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="gestaoMensalidadesChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Gráfico Receita vs Despesa -->
                <div class="col-md-6 mb-4">
                    <div class="card" style="background-color: #131313; border: 1px solid #feff00;">
                        <div class="card-header text-center" style="background-color: #feff00; color: #131313;">
                            <h5>Receita vs Despesa</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="receitaDespesaChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Gráfico Distribuição de Gastos -->
                <div class="col-md-6 mb-4">
                    <div class="card" style="background-color: #131313; border: 1px solid #feff00;">
                        <div class="card-header text-center" style="background-color: #feff00; color: #131313;">
                            <h5>Distribuição de Gastos</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="distribuicaoGastosChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


<script>
    // Dados para o Fluxo de Caixa
    const fluxoCaixaCtx = document.getElementById('fluxoCaixaChart').getContext('2d');
    new Chart(fluxoCaixaCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
            datasets: [{
                    label: 'Fluxo de Caixa (R$)',
                    data: [5000, 7000, 8000, 6000, 9000, 10000, 9500],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    tension: 0.4
                }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }
    });

    // Dados para Gestão de Mensalidades
    const gestaoMensalidadesCtx = document.getElementById('gestaoMensalidadesChart').getContext('2d');
    new Chart(gestaoMensalidadesCtx, {
        type: 'bar',
        data: {
            labels: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho'],
            datasets: [{
                    label: 'Mensalidades Pagas (R$)',
                    data: [3000, 4500, 5200, 4800, 5000, 6000, 5800],
                    backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }, {
                    label: 'Mensalidades Pendentes (R$)',
                    data: [500, 700, 600, 800, 700, 900, 1000],
                    backgroundColor: 'rgba(255, 99, 132, 0.7)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top'
                }
            }
        }
    });

    // Dados para Receita vs Despesa
    const receitaDespesaCtx = document.getElementById('receitaDespesaChart').getContext('2d');
    new Chart(receitaDespesaCtx, {
        type: 'pie',
        data: {
            labels: ['Receitas', 'Despesas'],
            datasets: [{
                    label: 'Receita vs Despesa',
                    data: [12000, 5000],
                    backgroundColor: ['rgba(75, 192, 192, 0.7)', 'rgba(255, 99, 132, 0.7)'],
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
        }
    });

    // Dados para Distribuição de Gastos
    const distribuicaoGastosCtx = document.getElementById('distribuicaoGastosChart').getContext('2d');
    new Chart(distribuicaoGastosCtx, {
        type: 'doughnut',
        data: {
            labels: ['Salários', 'Aluguel', 'Manutenção', 'Marketing', 'Outros'],
            datasets: [{
                    label: 'Distribuição de Gastos (R$)',
                    data: [4000, 2000, 1500, 1000, 500],
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(255, 206, 86, 0.7)',
                        'rgba(75, 192, 192, 0.7)',
                        'rgba(153, 102, 255, 0.7)',
                        'rgba(255, 159, 64, 0.7)'
                    ],
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
        }
    });
    // Dados para Receitas e Despesas
    const receitasDespesasCtx = document.getElementById('receitasDespesasChart').getContext('2d');
    new Chart(receitasDespesasCtx, {
        type: 'bar',
        data: {
            labels: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho'],
            datasets: [
                {
                    label: 'Receitas (R$)',
                    data: [12000, 15000, 17000, 13000, 16000, 20000, 18000],
                    backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                },
                {
                    label: 'Despesas (R$)',
                    data: [10000, 11000, 12000, 9000, 11000, 15000, 14000],
                    backgroundColor: 'rgba(255, 99, 132, 0.7)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top'
                },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            return `R$ ${context.raw.toLocaleString('pt-BR')}`;
                        }
                    }
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Meses',
                        font: {size: 14}
                    }
                },
                y: {
                    title: {
                        display: true,
                        text: 'Valores (R$)',
                        font: {size: 14}
                    },
                    beginAtZero: true
                }
            }
        }
    });
</script>


<jsp:include page="rodape.jsp" ></jsp:include>