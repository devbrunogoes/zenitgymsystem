package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.PersonalDAO;
import br.com.zenitgymsystem.model.Personal;
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

@WebServlet(name = "PerfilPersonal", urlPatterns = {"/PerfilPersonal"})
public class PerfilPersonal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            HttpSession sessao = request.getSession(false);
            Usuario usuario = (Usuario) sessao.getAttribute("usuario");

            int codPers = usuario.getCodUsuario();
            PersonalDAO personalDAO = new PersonalDAO();
            Personal personalL = (Personal) personalDAO.consultar(codPers);
            request.setAttribute("personal", personalL);

        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("mensagem", ex.getMessage());
        } finally {
            request.getRequestDispatcher("Perfil.jsp").forward(request, response);
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
