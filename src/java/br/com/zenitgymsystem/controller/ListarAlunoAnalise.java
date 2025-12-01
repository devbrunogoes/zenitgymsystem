package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AlunoDAO;
import br.com.zenitgymsystem.dao.AnaliseDAO;
import br.com.zenitgymsystem.model.Analise;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="ListarAlunoAnalise", urlPatterns={"/ListarAlunoAnalise"})
public class ListarAlunoAnalise extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

            try {
            AnaliseDAO analiseDAO = new AnaliseDAO();
            AlunoDAO alunoDAO = new AlunoDAO();

            // Listas genéricas de Object
            List<Object> listaAnalises = analiseDAO.listar();  // Lista de Analises
            List<Object> listaAlunos = alunoDAO.listar();  // Lista de Alunos

            // Definindo os atributos para o request
            request.setAttribute("analises", listaAnalises);
            request.setAttribute("listaAlunos", listaAlunos);

        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("mensagem", ex.getMessage());
        } finally {
            // Redirecionando para a página JSP
            request.getRequestDispatcher("AnalisesPers.jsp").forward(request, response);
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
