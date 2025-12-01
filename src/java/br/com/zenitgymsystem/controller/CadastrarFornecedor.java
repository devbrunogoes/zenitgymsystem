package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.FornecedorDAO;
import br.com.zenitgymsystem.model.Fornecedor;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CadastrarFornecedor", urlPatterns = {"/CadastrarFornecedor"})
public class CadastrarFornecedor extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Verifica se o código do fornecedor foi enviado
            int codForn = request.getParameter("codForn").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codForn"));
            String nomeForn = request.getParameter("nomeForn");
            String celularForn = request.getParameter("celularForn");
            String emailForn = request.getParameter("emailForn");
            String cnpjForn = request.getParameter("cnpjForn");
            String enderecoForn = request.getParameter("enderecoForn");
            String dtCadastroForn = request.getParameter("dtCadastroForn");
            boolean statusForn = request.getParameter("statusForn").equals("Ativo");
            String obsForn = request.getParameter("obsForn");

            // Cria o objeto fornecedor
            Fornecedor fornecedor = new Fornecedor(codForn, nomeForn, celularForn, emailForn, cnpjForn, enderecoForn, dtCadastroForn, statusForn, obsForn);
            FornecedorDAO fornecedorDAO = new FornecedorDAO();

            // Se o codForn for 0, significa que estamos cadastrando um novo fornecedor
            if (codForn == 0) {
                fornecedorDAO.gravar(fornecedor);
                request.setAttribute("mensagem", "Fornecedor cadastrado com sucesso!");
            } else {
                // Se o codForn for diferente de 0, atualizamos o fornecedor existente
                if (fornecedorDAO.existeFornecedor(codForn)) {
                    fornecedorDAO.alterar(fornecedor);
                    request.setAttribute("mensagem", "Fornecedor atualizado com sucesso!");
                } else {
                    request.setAttribute("mensagem", "Fornecedor não encontrado!");
                }
            }

        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("mensagem", ex.getMessage());
        }

// Redireciona para a página de listagem após gravar ou atualizar
        response.sendRedirect("ListarEEF");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Cadastrar e atualizar fornecedores";
    }
}
