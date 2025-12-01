/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.UsuarioDAO;
import br.com.zenitgymsystem.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author BrunoGoes
 */
@WebServlet(name = "RealizarLogin", urlPatterns = {"/RealizarLogin"})
public class RealizarLogin extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            String cpfUsuario = request.getParameter("cpfUsuario");
            String senhaUsuario = request.getParameter("senhaUsuario");
            String perfilUsuario = request.getParameter("perfilUsuario");
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            Usuario usuario = (Usuario) usuarioDAO.realizarLogin(cpfUsuario, senhaUsuario, perfilUsuario);
            if(usuario != null) {
                HttpSession sessao = request.getSession(true);
                sessao.setAttribute("usuario", usuario);
                response.sendRedirect(request.getContextPath() + "/home.jsp");
                
            } else {
                request.setAttribute("mensagem", "Usuario, senha ou perfil incorretos!");
                request.getRequestDispatcher("index.jsp")
                        .forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("mensagem", ex.getMessage());
            request.getRequestDispatcher("index.jsp")
                        .forward(request, response);
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
