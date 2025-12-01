package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.TreinoAlunoDAO;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Treino;
import br.com.zenitgymsystem.model.TreinoAluno;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CadastrarTreinoAluno", urlPatterns = {"/CadastrarTreinoAluno"})
public class CadastrarTreinoAluno extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recupera os dados da sessão que foram setados na primeira servlet
            HttpSession session = request.getSession();
            Integer codTreino = (Integer) session.getAttribute("codTreino"); // Código do treino
            Integer codAluno = (Integer) session.getAttribute("codAluno"); // Código do aluno

            // Verifica se os valores são válidos
            if (codTreino == null || codAluno == null || codTreino <= 0 || codAluno <= 0) {
                throw new IllegalArgumentException("Código do treino ou do aluno inválido.");
            }

            // Criação do objeto Aluno e Treino
            Aluno aluno = new Aluno();
            aluno.setCodAluno(codAluno);

            Treino treino = new Treino();
            treino.setCodTreino(codTreino);

            // Cria o objeto TreinoAluno para associar o treino ao aluno
            TreinoAluno treinoAluno = new TreinoAluno();
            treinoAluno.setAluno(aluno);
            treinoAluno.setTreino(treino);

            // Associa o treino ao aluno usando o DAO
            TreinoAlunoDAO treinoAlunoDAO = new TreinoAlunoDAO();
            treinoAlunoDAO.associarTreinoAoAluno(treinoAluno);

            // Mensagem de sucesso
            request.setAttribute("mensagem", "Treino associado ao aluno com sucesso!");
            System.out.println("Treino associado ao aluno com sucesso.");

            // Redireciona ou encaminha para a página desejada após sucesso
            request.getRequestDispatcher("Treinos.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException | IllegalArgumentException ex) {
            // Em caso de erro, exibe a mensagem de erro
            request.setAttribute("mensagem", "Erro ao associar treino ao aluno: " + ex.getMessage());
            ex.printStackTrace();
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
        return "Servlet para associar o treino ao aluno";
    }
}
