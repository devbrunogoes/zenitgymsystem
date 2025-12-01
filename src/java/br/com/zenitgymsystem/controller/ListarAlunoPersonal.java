package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AlunoDAO;
import br.com.zenitgymsystem.dao.AnaliseDAO;
import br.com.zenitgymsystem.dao.PersonalDAO;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Analise;
import br.com.zenitgymsystem.model.Personal;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ListarAlunoPersonal", urlPatterns = {"/ListarAlunoPersonal"})
public class ListarAlunoPersonal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperando as listas de alunos e personal trainers
            AlunoDAO alunoDAO = new AlunoDAO();
            PersonalDAO personalDAO = new PersonalDAO();
            AnaliseDAO analiseDAO = new AnaliseDAO();

            // As listas agora devem ser do tipo correto (List<Aluno> e List<Personal>)
            List<Object> listaAlunos = alunoDAO.listar(); // Lista de alunos
            List<Object> listaPersonais = personalDAO.listar(); // Lista de personal trainers
            List<Object> listaAnalise = analiseDAO.listar();

            // Adiciona essas listas como atributos na requisição para a JSP
            request.setAttribute("alunos", listaAlunos);
            request.setAttribute("personais", listaPersonais);
            request.setAttribute("analises", listaAnalise);

        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar dados.");
        } finally {
            // Redireciona para a página JSP que exibirá as listas
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
