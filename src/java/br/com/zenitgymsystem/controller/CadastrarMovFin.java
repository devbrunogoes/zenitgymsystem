package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AlunoDAO;
import br.com.zenitgymsystem.dao.FornecedorDAO;
import br.com.zenitgymsystem.dao.MovFinDAO;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Fornecedor;
import br.com.zenitgymsystem.model.MovFin;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CadastrarMovFin", urlPatterns = {"/CadastrarMovFin"})
public class CadastrarMovFin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Captura os parâmetros da requisição
            int codMov = request.getParameter("codMov").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codMov"));
            String descMov = request.getParameter("descMov");
            boolean tipoMov = Boolean.parseBoolean(request.getParameter("tipoMov")); // true para receita, false para despesa
            double valorMov = Double.parseDouble(request.getParameter("valorMov"));
            String dtMov = request.getParameter("dtMov"); // Data no formato "yyyy-MM-dd"
            String tipoPagMov = request.getParameter("tipoPagMov");
            String categoriaMov = request.getParameter("categoriaMov");
            String obsMov = request.getParameter("obsMov");

           

            // Cria o objeto MovFin com os parâmetros capturados
            MovFin movFin = new MovFin(codMov, descMov, tipoMov, valorMov, dtMov, tipoPagMov, categoriaMov, obsMov);
            MovFinDAO movFinDAO = new MovFinDAO();

            // Grava a movimentação no banco de dados
            movFinDAO.gravar(movFin);

            // Define uma mensagem de sucesso
            request.setAttribute("mensagem", "Movimentação financeira cadastrada com sucesso!");

        } catch (SQLException | ClassNotFoundException ex) {
            // Define a mensagem de erro
            request.setAttribute("mensagem", "Erro ao cadastrar movimentação: " + ex.getMessage());
        } finally {
            // Redireciona para a página de listagem das movimentações
            response.sendRedirect("ListarFinancas");
        }

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
        return "Short description";
    }

}
