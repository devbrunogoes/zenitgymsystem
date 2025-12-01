<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" 
              integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" href="img/logo-sfundo.png">
        <title >Zenit Gym System</title>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/locale/pt-br.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Afacad+Flux:wght@400&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

    </head>
    <body>
        <style type="text/css">
            ::-webkit-scrollbar {
                width: 10px;
            }
            ::-webkit-scrollbar-thumb {
                background: #515151;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: black;
            }
            .fa {
                color: yellow;
            }

            .fa:hover {
                color: #ffffff;
            }

            .nav-pills .nav-link.active {
                background-color: #feff00;
                color: black;
            }

            .page {
                display: flex;
                height: 100%;
            }

            .pag {
                display: block;
                width: 100%;
                padding: 15px;
                margin-left: 4.5rem;
                min-height: 100vh;
                background-color: rgb(236, 240, 241);
            }

            .sidebar {
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                background-color: #131313;
                overflow: visible;
                z-index: 10;
            }

            .dropdown-item .drop-icon,
            .dropdown-item .drop-exit {
                color: black;
                transition: color 0.3s ease;
            }

            .dropdown-item:hover .drop-exit {
                color: red;
            }

            .dropdown-item:hover .drop-icon {
                color: #feff00;
            }
            .dropdown-menu {
                position: absolute; /* Importante para posicionar dentro da sidebar */
                z-index: 999; /* Deve ser maior que o z-index da sidebar e do conteúdo */
                background-color: white; /* Adicione fundo para melhor visibilidade */
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Opcional: estilização */
            }

            .avatar {
                width: 25px;
                height: 25px;
                border: 0;
                padding: 0;
            }
        </style>



