/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.ExercicioDAO;
import br.com.zenitgymsystem.model.Exercicio;
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
@WebServlet(name = "CadastrarExercicio", urlPatterns = {"/CadastrarExercicio"})
public class CadastrarExercicio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int codEx = request.getParameter("codEx").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codEx"));
            String nomeEx = request.getParameter("nomeEx");
            String grupoEx = request.getParameter("grupoEx");
            

            // Cria o objeto Exercicio com o novo atributo uniCargaEx
            Exercicio exercicio = new Exercicio(codEx, nomeEx,  grupoEx);
            ExercicioDAO exercicioDAO = new ExercicioDAO();

            // Grava o exercício no banco de dados
            exercicioDAO.gravar(exercicio);

            // Define uma mensagem de sucesso
            request.setAttribute("mensagem", "Exercício cadastrado com sucesso!");

        } catch (SQLException | ClassNotFoundException ex) {
            // Define a mensagem de erro
            request.setAttribute("mensagem", ex.getMessage());
        } finally {
            // Redireciona para a listagem dos exercícios
            response.sendRedirect("Treinos.jsp");
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
