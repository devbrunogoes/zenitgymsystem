package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AnaliseDAO;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Analise;
import br.com.zenitgymsystem.model.Personal;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AgendarAnalise", urlPatterns = {"/AgendarAnalise"})
public class AgendarAnalise extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperando os parâmetros da requisição
            System.out.println("Iniciando o processamento da análise...");

            int codAv = request.getParameter("codAv").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codAv"));
            int codAluno = request.getParameter("codAluno").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codAluno"));
            int codPers = request.getParameter("codPers").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codPers"));
            
          System.out.println("codAluno: " + codAluno + ", codPers: " + codPers);
            
            double pesoAv = Double.parseDouble(request.getParameter("pesoAv"));
            double alturaAv = Double.parseDouble(request.getParameter("alturaAv"));
            double imcAv = Double.parseDouble(request.getParameter("imcAv"));
            double percentGorduraAv = Double.parseDouble(request.getParameter("percentGorduraAv"));
            double massaMuscularAv = Double.parseDouble(request.getParameter("massaMuscularAv"));
            String pressaoAv = request.getParameter("pressaoAv");
            int freqCardiacaAv = Integer.parseInt(request.getParameter("freqCardiacaAv"));
            double capacidadeAerobicaAv = Double.parseDouble(request.getParameter("capacidadeAerobicaAv"));
            String hrAgendamentoAv = request.getParameter("hrAgendamentoAv");
            String objetivoAv = request.getParameter("objetivoAv");
            
            String dtAgendamentoAv = request.getParameter("dtAgendamentoAv");
            boolean statusAv = Boolean.parseBoolean(request.getParameter("statusAv"));

            System.out.println("Data de agendamento: " + dtAgendamentoAv + ", Hora: " + hrAgendamentoAv);

            // Criando os objetos Aluno e Personal
            Aluno aluno = new Aluno(codAluno);
            Personal personal = new Personal(codPers);

            // Criando o objeto Analise
            Analise analise = new Analise(codAv, pesoAv, alturaAv, imcAv, percentGorduraAv, massaMuscularAv,
                    pressaoAv, freqCardiacaAv, capacidadeAerobicaAv, objetivoAv,dtAgendamentoAv, hrAgendamentoAv, statusAv,
                    aluno, personal);

            System.out.println("Objeto análise criado com sucesso!");

            // Criando o DAO e gravando a análise
            AnaliseDAO analiseDAO = new AnaliseDAO();
            analiseDAO.gravar(analise);

            // Mensagem de sucesso
            request.setAttribute("mensagem", "Análise cadastrada com sucesso!");

        } catch (NumberFormatException e) {
            request.setAttribute("mensagem", "Erro na conversão de dados: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            request.setAttribute("mensagem", "Erro de SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            request.setAttribute("mensagem", "Erro de classe não encontrada: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            request.setAttribute("mensagem", "Erro desconhecido: " + e.getMessage());
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher("ListarAlunoPersonal").forward(request, response);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // Processa o agendamento
    }

    @Override
    public String getServletInfo() {
        return "Servlet para agendar análise de aluno com personal.";
    }
}
