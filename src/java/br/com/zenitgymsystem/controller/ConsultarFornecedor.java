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
@WebServlet(name = "ConsultarFornecedor", urlPatterns = {"/ConsultarFornecedor"})
public class ConsultarFornecedor extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int codForn = Integer.parseInt(request.getParameter("codForn"));
            FornecedorDAO fornecedorDAO = new FornecedorDAO();
            Fornecedor fornecedor = (Fornecedor) fornecedorDAO.consultar(codForn);
            request.setAttribute("fornecedor", fornecedor);
        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("mensagem", ex.getMessage());
        } 
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
        return "Short description";
    }

}
