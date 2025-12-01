/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.ProdutoDAO;
import br.com.zenitgymsystem.model.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Aluno(a)
 */
@WebServlet(name = "AlterarProduto", urlPatterns = {"/AlterarProduto"})
public class AlterarProduto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // Verificação dos parâmetros
            String codProduto = request.getParameter("codProduto");
            String nomeProduto = request.getParameter("nomeProduto");
            String descProduto = request.getParameter("descProduto");
            String valorProduto =  request.getParameter("valorProduto");
            String qtdProduto = request.getParameter("qtdProduto");
            String imgProduto = request.getParameter("imgProduto");
            String categoriaProduto = request.getParameter("categoriaProduto");

            

            // Criação do objeto Produto
            Produto produto = new Produto();
            produto.setCodProduto(Integer.parseInt(codProduto));
            produto.setNomeProduto(nomeProduto);
            produto.setDescProduto(descProduto);
            produto.setValorProduto(Float.parseFloat(valorProduto));
            produto.setQtdProduto(Integer.parseInt(qtdProduto));
            produto.setImgProduto(imgProduto);
            produto.setCategoriaProduto(categoriaProduto);


            // Instancia o DAO e atualiza o produto no banco de dados
            ProdutoDAO produtoDAO = new ProdutoDAO();
            produtoDAO.alterar(produto);          
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            // Redireciona para uma página de erro
            request.setAttribute("mensagem","Erro ao alterar o produto! :" + ex.getMessage());
        }
        response.sendRedirect("Loja.jsp");
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
