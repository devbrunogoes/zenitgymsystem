/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.FornecedorDAO;
import br.com.zenitgymsystem.model.Fornecedor;
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
 * @author Bruno Goes
 */
@WebServlet(name = "AlterarFornecedor", urlPatterns = {"/AlterarFornecedor"})
public class AlterarFornecedor extends HttpServlet {

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
            String codForn = request.getParameter("codForn");
            String nomeForn = request.getParameter("nomeForn");
            String celularForn = request.getParameter("celularForn");
            String emailForn = request.getParameter("emailForn");

            // Cria um objeto Fornecedor com os dados fornecidos
            Fornecedor fornecedor = new Fornecedor();
            fornecedor.setCodForn(Integer.parseInt(codForn));
            fornecedor.setNomeForn(nomeForn);
            fornecedor.setCelularForn(celularForn);
            fornecedor.setEmailForn(emailForn);

            // Instancia o DAO e atualiza o fornecedor no banco de dados
            FornecedorDAO fornecedorDAO = new FornecedorDAO();
            fornecedorDAO.alterar(fornecedor);          
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            // Redireciona para uma página de erro
            request.setAttribute("mensagem","Erro ao alterar o fornecedor! :" + ex.getMessage());
        }
        response.sendRedirect("ListarEEF");
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
