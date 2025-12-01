package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AulaDAO;
import br.com.zenitgymsystem.model.Aula;
import br.com.zenitgymsystem.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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

@WebServlet(name = "ListarAulasPorAluno", urlPatterns = {"/ListarAulasPorAluno"})
public class ListarAulasPorAluno extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            HttpSession sessao = request.getSession(false);
            Usuario usuario = (Usuario) sessao.getAttribute("usuario");

            // Obter o código do aluno
            int codAluno = usuario.getCodUsuario();

            // Instanciando a classe DAO para buscar as aulas
            AulaDAO aulaDAO = new AulaDAO();
            List<Aula> aulas = aulaDAO.listarAulasPorAluno(codAluno);  // Recupera as aulas associadas ao aluno logado

            // Lista de eventos formatados para o calendário
            List<Map<String, String>> eventos = new ArrayList<>();

            for (Aula aula : aulas) {
                Map<String, String> evento = new HashMap<>();

                // Preenchendo as informações do evento
                evento.put("title", aula.getNomeAula());
                evento.put("start", aula.getDtAula() + "T" + aula.getHorarioAula() + ":00"); // Ajustando para o formato do FullCalendar
                evento.put("end", aula.getDtAula() + "T" + aula.getHorarioAula() + ":00");  // A mesma hora para o fim
                evento.put("description", aula.getDescAula());

                eventos.add(evento);
            }
            System.out.println("Eventos: " + eventos);
            // Passando os eventos formatados para o JSP
            request.setAttribute("eventos", eventos);
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            request.setAttribute("erro", "Erro ao listar aulas.");
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
