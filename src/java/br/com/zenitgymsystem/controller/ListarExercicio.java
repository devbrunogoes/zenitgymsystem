package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.ExercicioDAO;
import br.com.zenitgymsystem.model.Exercicio;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ListarExercicio", urlPatterns = {"/ListarExercicio"})
public class ListarExercicio extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Instancia o DAO e obtém a lista de exercícios
            ExercicioDAO exercicioDAO = new ExercicioDAO();
            List<Exercicio> listaExercicios = exercicioDAO.listar();

            // Define a lista como atributo da requisição
            request.setAttribute("listaExercicios", listaExercicios);

            

        } catch (SQLException | ClassNotFoundException ex) {
           request.setAttribute("mensagem", ex.getMessage());
        } finally{
            // Encaminha para a página JSP que exibirá os exercícios
            request.getRequestDispatcher("Treinos.jsp").forward(request, response);
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
