/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.ProdutoDAO;
import br.com.zenitgymsystem.model.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Bruno Goes
 */
@WebServlet(name = "CadastrarProduto", urlPatterns = {"/CadastrarProduto"})
public class CadastrarProduto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Verificação dos parâmetros
            String codProdutoParam = request.getParameter("codProduto");
            int codProduto = (codProdutoParam == null || codProdutoParam.isEmpty()) ? 0 : Integer.parseInt(codProdutoParam);

            String nomeProduto = request.getParameter("nomeProduto");
            String descProduto = request.getParameter("descProduto");

            String valorProdutoParam = request.getParameter("valorProduto");
            float valorProduto = valorProdutoParam == null ? 0.0f : Float.parseFloat(valorProdutoParam);

            String qtdProdutoParam = request.getParameter("qtdProduto");
            int qtdProduto = qtdProdutoParam == null ? 0 : Integer.parseInt(qtdProdutoParam);

            String imgProduto = request.getParameter("imgProduto");
            String categoriaProduto = request.getParameter("categoriaProduto");

            // Criação do objeto Produto
            Produto produto = new Produto(codProduto, nomeProduto, descProduto, valorProduto, qtdProduto, imgProduto,categoriaProduto);

            // Gravação no banco de dados
            ProdutoDAO produtoDAO = new ProdutoDAO();
            produtoDAO.gravar(produto);

            // Mensagem de sucesso
            request.setAttribute("mensagem", "Produto cadastrado com sucesso!");
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            request.setAttribute("mensagem", ex.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("mensagem", "Erro de formatação dos dados.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensagem", "Erro inesperado: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("Loja.jsp").forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
