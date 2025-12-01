package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AnaliseDAO;
import br.com.zenitgymsystem.dao.AulaDAO;
import br.com.zenitgymsystem.dao.ExercicioTreinoDAO;
import br.com.zenitgymsystem.model.Analise;
import br.com.zenitgymsystem.model.Aula;
import br.com.zenitgymsystem.model.ExercicioTreino;
import br.com.zenitgymsystem.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ListarEventoCal", urlPatterns = {"/ListarEventoCal"})
public class ListarEventoCal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Obtendo a sessão do usuário
            HttpSession sessao = request.getSession(false);
            Usuario usuario = (Usuario) sessao.getAttribute("usuario");

            // Obter o código do aluno
            int codAluno = usuario.getCodUsuario();

            // Instanciando a classe DAO para buscar as aulas e análises
            AulaDAO aulaDAO = new AulaDAO();
            AnaliseDAO analiseDAO = new AnaliseDAO();
            ExercicioTreinoDAO exercicioTreinoDAO = new ExercicioTreinoDAO();

            // Recuperando as aulas e análises associadas ao aluno logado
            List<Aula> aulas = aulaDAO.listarAulasPorAluno(codAluno);
            List<Analise> analises = analiseDAO.listarAnalisesPorAluno(codAluno);
            List<ExercicioTreino> exercicioTreinos = exercicioTreinoDAO.listarExerciciosPorAluno(codAluno);

            // Lista de eventos formatados para o calendário
            List<Map<String, String>> eventos = new ArrayList<>();

            // Adicionando aulas à lista de eventos
            for (Aula aula : aulas) {
                if (aula.getDtAula() != null && aula.getHorarioAula() != null) {
                    Map<String, String> evento = new HashMap<>();

                    // Preenchendo as informações do evento
                    evento.put("title", aula.getNomeAula());
                    evento.put("start", aula.getDtAula() + "T" + aula.getHorarioAula() + ":00"); // Formato adequado para o FullCalendar
                    evento.put("end", aula.getDtAula() + "T" + aula.getHorarioAula() + ":00");   // A mesma hora para o fim
                    evento.put("description", aula.getDescAula());

                    eventos.add(evento);
                }
            }

            for (Analise analise : analises) {
                if (analise.getDtAgendamentoAv() != null && analise.getHrAgendamentoAv() != null) {
                    Map<String, String> evento = new HashMap<>();

                    // Adicionando as informações do evento
                    evento.put("title", "Análise - " + analise.getObjetivoAv());
                    evento.put("start", analise.getDtAgendamentoAv() + "T" + analise.getHrAgendamentoAv() + ":00" );  // Formato correto
                    evento.put("end", analise.getDtAgendamentoAv() + "T" + analise.getHrAgendamentoAv() + ":00" );      // Formato correto
                    evento.put("description", analise.isStatusAv() ? "Concluído" : "Pendente");

                    eventos.add(evento);
                }
            }

            for (ExercicioTreino exercicioTreino : exercicioTreinos) {
                if (exercicioTreino.getTreino() != null && exercicioTreino.getTreino().getDtTreino() != null) {
                    Map<String, String> evento = new HashMap<>();

                    // Preenchendo as informações do evento com os dados do ExercicioTreino
                    evento.put("title", exercicioTreino.getTreino().getNomeTreino());
                    evento.put("start", exercicioTreino.getTreino().getDtTreino()); // Formato adequado para o FullCalendar
                    evento.put("end", exercicioTreino.getTreino().getDtTreino());   // End também no formato adequado
                    evento.put("description", exercicioTreino.getExercicio().getNomeEx());

                    eventos.add(evento);
                }
            }

            System.out.println("Eventos: " + eventos);

            // Passando os eventos formatados para o JSP
            request.setAttribute("eventos", eventos);

        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            // Atribuindo uma mensagem de erro ao request para ser exibida no JSP
            request.setAttribute("erro", "Erro ao listar aulas e análises. Tente novamente mais tarde.");
        } catch (Exception ex) {
            ex.printStackTrace();
            // Caso ocorra algum erro inesperado
            request.setAttribute("erro", "Erro inesperado: " + ex.getMessage());
        } finally {
            // Redirecionando para a página onde o calendário está exibido
            request.getRequestDispatcher("Agenda.jsp").forward(request, response);
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
