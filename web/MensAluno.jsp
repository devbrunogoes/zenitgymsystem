<%@page import="br.com.zenitgymsystem.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="cabecalho.jsp"/>
<div class="page">
    <style type="text/css">
        .card {
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            width: 70%;
            height: 500px;
        }

        .detalheMens {
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
            width: 25%;
            height: 500px;
            border: 1px solid black;
            border-radius: 5px;
            padding: 10px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }

        .detalheMens h4 {
            margin-top: 10px;
        }

        .detalheMens p {
            margin-bottom: 5px;
            font-size: 14px;
        }

        .detalheMens .status {
            font-weight: bold;
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
                <a href="MensAluno.jsp" class="nav-link py-3 active" title="Mensalidade" data-bs-toggle="tooltip" data-bs-placement="right">
                    <i class="fa-solid fa-money-bill "></i>
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
        <div class="d-flex justify-content-between">
            <div class="card me-3">
                <div class="card-body">
                    <canvas id="mensalidadeChart"></canvas>
                </div>
            </div>
            <div class="detalheMens">
                <h4>Detalhes da Mensalidade</h4>
                <div id="mensalidadeDetails">
                    <!-- Detalhes da mensalidade serão inseridos aqui -->
                    <p>Vencimento: <span class="status">30/11/2024</span></p>
                    <p>Valor: <span class="status">R$ 150,00</span></p>
                    <p>Status: <span class="status">Pago</span></p>
                    <p>Forma de pagamento: <span class="status">Cartão de Crédito</span></p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var ctx = document.getElementById('mensalidadeChart').getContext('2d');
    var mensalidadeChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
            datasets: [{
                    label: 'Status da Mensalidade',
                    data: [105, 105, 100, 100, 100, 95, 95, 95, 95, 95, 95],
                    backgroundColor: [
                        'rgba(255, 255, 255, 1)', // Pago
                        'rgba(255, 255, 255, 1)',
                        'rgba(255, 255, 255, 1)',
                        'rgba(255, 255, 255, 1)',
                        'rgba(255, 255, 255, 1)',
                        'rgba(255, 255, 255, 1)',
                        'rgba(255, 255, 255, 1)',
                        'rgba(255, 255, 255, 1)',
                        'rgba(255, 255, 0, 0.6)', // Vencido
                        'rgba(255, 0, 0, 0.6)'     // Não pago
                    ],
                    borderColor: 'rgba(0, 0, 0, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            plugins: {
                datalabels: {
                    color: 'black',
                    anchor: 'end',
                    align: 'top',
                    font: {
                        size: 10, // Reduz o tamanho da fonte
                    },
                    formatter: function (value, context) {
                        var index = context.dataIndex;
                        var bgColor = context.dataset.backgroundColor[index];
                        if (bgColor === 'rgba(255, 255, 255, 1)') {
                            // Pago - valor riscado
                            return ('\u0336' + 'R$ ' + value.toString().split('').join('\u0336') + ',00');
                        } else if (bgColor === 'rgba(255, 255, 0, 0.6)') {
                            // Vencido
                            return 'R$ ' + value + ',00';
                        } else if (bgColor === 'rgba(255, 0, 0, 0.6)') {
                            // Não pago
                            return 'R$ ' + value + ',00';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        },
        plugins: [ChartDataLabels]
    });
</script>


<jsp:include page="rodape.jsp"/>
