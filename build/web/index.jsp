<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="cabecalho.jsp"></jsp:include>
    <div class="">
        <style type="text/css">
            *{
                padding: 0px;
                margin: 0px;
                font-family: Arial, Helvetica, sans-serif;
                box-sizing: border-box;
            }
            body{
                background-attachment: fixed;
                background-size: cover;
                background-image: url(img/backgroud-index.jpg);
            }
            .wrapper{
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                height: auto;
            }
            .form-holder {
                background: #000;
                width: 450px;
                max-width: 90%;
                padding: 35px 0px;
                opacity: .7;
                border-radius: 10px;
            }
            .logo{
                display: block;
                width: 150px;
                margin: 0px auto;
                border-radius: 20px;
                padding: 10px;
            }
            .form-holder h2{
                color: #ddd;
                padding: 10px;
                text-align: center;
                font-size: 22px;
            }
            .form .form-group{
                width: 90%;
                margin: 10px auto;
                padding: 10px;
                position: relative;
            }
            .form-group input{
                width: 100%;
                padding: 10px;
                background: #222;
                border: none;
                outline: none;
                color: #fff;
                font-size: 15px;
                border-bottom: 2px solid #777;
                border-radius: 5px;
                padding-left: 40px;
            }
            .form-group select{
                width: 100%;
                padding: 10px;
                background: #222;
                border: none;
                outline: none;
                color: #fff;
                font-size: 15px;
                border-bottom: 2px solid #777;
                border-radius: 5px;
                padding-left: 40px;
            }
            .form-group img{
                width: 26px;
                position: absolute;
                left: 15px;
                top: 13px;
            }

            .form-group button{
                width: 100%;
                padding: 10px;
                background: transparent;
                border: none;
                outline: none;
                color: #fff;
                font-size: 15px;
                border: 2px solid #777;
                border-radius: 5px;
                cursor: pointer;
            }

            .form-group button:hover{
                background: #333;
            }
            .form-group a{
                color: #999;
                text-decoration: none;
                font-size: 14px;
            }
            .form-group a:hover{
                color: #555;
            }
            .remember{
                color: #999;
                text-decoration: none;
                font-size: 14px;

            }
            .remember:hover{
                color: #555;
            }
            /* Estilo para a borda vermelha */
            .form-group.error input {
                border: 1px solid red;
            }

            .form-group.error select {
                border: 1px solid red;
            }

            /* Estilo para a mensagem de erro acima do campo */
            .error-message {
                color: red;
                font-size: 12px;
                margin-bottom: 5px;
            }

            .form-group img {
                width: 26px;
                position: absolute;
                left: 20px; /* Alinha a imagem à esquerda */
                transform: translateY(-50%);  /* Ajusta a posição para garantir o centro */
            }

        </style>
        <div class="body">
            <div class="mx-auto shadow my-4">
                <form action="RealizarLogin" method="POST" class="form">
                    <div class="wrapper">
                        <div class="form-holder">
                            <img src="img/logo-sfundo.png" class="logo" alt="">
                            <h2>ZENIT GYM SYSTEM</h2>
                        <c:if test="${mensagem != null}">
                            <!-- CPF com borda vermelha -->
                            <div class="form-group error">
                                <div class="error-message">${mensagem}</div>
                                <div>
                                    <img src="img/user.png" style="top: 60%;">
                                    <input type="text" id="cpfUsuario" name="cpfUsuario" placeholder="Informe o CPF" data-mask="000.000.000-00" required />
                                </div>
                            </div>

                            <!-- Senha com borda vermelha -->
                            <div class="form-group error">
                                <img src="img/lock.png" style="top: 50%;">
                                <input type="password" id="senhaUsuario" name="senhaUsuario" placeholder="Informe a senha" required />
                            </div>

                            <div class="form-group error">
                                <select id="perfilUsuario" name="perfilUsuario" required>
                                    <option value="">Selecione...</option>
                                    <option value="Aluno">Aluno</option>
                                    <option value="Personal">Personal</option>
                                    <option value="Administrador">Administrador</option>
                                </select>
                            </div>
                        </c:if>

                        <!-- Campos sem borda vermelha (caso não haja mensagem) -->
                        <c:if test="${mensagem == null}">
                            <div class="form-group" >
                                <img src="img/user.png" style="top: 50%;">
                                <input type="text" id="cpfUsuario" name="cpfUsuario" placeholder="Informe o CPF" data-mask="000.000.000-00" required />
                            </div>
                            <div class="form-group" >
                                <img src="img/lock.png" style="top: 50%;">
                                <input type="password" id="senhaUsuario" name="senhaUsuario" placeholder="Informe a senha" required />
                            </div>

                            <div class="form-group" >
                                <select id="perfilUsuario" name="perfilUsuario" required>
                                    <option value="">Selecione...</option>
                                    <option value="Aluno">Aluno</option>
                                    <option value="Personal">Personal</option>
                                    <option value="Administrador">Administrador</option>
                                </select>
                            </div>
                        </c:if>



                        <div class="form-group d-flex align-items-center justify-content-between remember">
                            <div class="d-flex align-items-center">
                                <input type="checkbox" id="remember" name="remember" style="margin-right: 5px;">
                                <label for="remember" style="position: absolute; margin-left: 1rem;">Lembrar de mim</label>
                            </div>
                            <a href="">Esqueceu a senha?</a>
                        </div>

                        <div class="form-group">
                            <button type="submit">Entrar</button> 
                        </div>

                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="rodape.jsp"/>
