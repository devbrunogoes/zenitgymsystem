package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AlunoAulaDAO;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.AlunoAula;
import br.com.zenitgymsystem.model.Aula;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AssociarAlunoAula", urlPatterns = {"/AssociarAlunoAula"})
public class AssociarAlunoAula extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            int codAluno = Integer.parseInt(request.getParameter("codAluno"));
            int codAula = Integer.parseInt(request.getParameter("codAula"));

            // Criar objetos Aluno e Aula
            Aluno aluno = new Aluno();
            aluno.setCodAluno(codAluno);
            Aula aula = new Aula();
            aula.setCodAula(codAula);

            // Criar o objeto AlunoAula e associar
            AlunoAula alunoAula = new AlunoAula(0, aluno, aula);
            AlunoAulaDAO alunoAulaDAO = new AlunoAulaDAO();
            alunoAulaDAO.associarAulaAluno(alunoAula);

            request.setAttribute("mensagem", "Aluno e Aula associado com sucesso!");
        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("mensagem", ex.getMessage());
        } finally {
            // Redirecionando para a página JSP
            request.getRequestDispatcher("ListarAlunoAula").forward(request, response);
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
