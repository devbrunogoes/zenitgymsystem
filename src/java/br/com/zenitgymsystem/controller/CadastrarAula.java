package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AulaDAO;
import br.com.zenitgymsystem.model.Aula;
import br.com.zenitgymsystem.model.Personal;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="CadastrarAula", urlPatterns={"/CadastrarAula"})
public class CadastrarAula extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");


        try {
            int codAula = request.getParameter("codAula").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codAula"));
            String nomeAula = request.getParameter("nomeAula");
            String descAula = request.getParameter("descAula");
            String dtAula = request.getParameter("dtAula");
            String horarioAula = request.getParameter("horarioAula");
            int codPers = request.getParameter("codPers").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codPers"));
            
            Personal personal = new Personal(codPers);
            Aula aula = new Aula(codAula,nomeAula,descAula, dtAula,horarioAula, personal);
            AulaDAO aulaDAO = new AulaDAO();
            // Grava a entrega no banco de dados
            aulaDAO.gravar(aula);

            // Define uma mensagem de sucesso
            request.setAttribute("mensagem", "Aula cadastrada com sucesso!");

        } catch (SQLException | ClassNotFoundException ex) {
            // Define a mensagem de erro
            request.setAttribute("mensagem", ex.getMessage());
        } finally {
            // Redireciona para a listagem dos equipamentos
            request.getRequestDispatcher("AulasCRUD.jsp").forward(request, response);
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
