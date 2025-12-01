package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.TreinoDAO;
import br.com.zenitgymsystem.dao.ExercicioTreinoDAO;
import br.com.zenitgymsystem.model.ExercicioTreino;
import br.com.zenitgymsystem.model.Treino;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CadastrarTreino", urlPatterns = {"/CadastrarTreino"})
public class CadastrarTreino extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Dados recebidos da view
            int codTreino = request.getParameter("codTreino").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codTreino"));
            String nomeTreino = request.getParameter("nomeTreino");
            String descricaoTreino = request.getParameter("descricaoTreino");
            String dtTreino = request.getParameter("dtTreino");
            boolean statusTreino = "Ativo".equals(request.getParameter("statusTreino"));

            // Captura o codAluno do select
            int codAluno = request.getParameter("codAluno").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codAluno"));

            // Criação do objeto Treino
            Treino treino = new Treino(codTreino, nomeTreino, descricaoTreino, dtTreino, statusTreino);

            // DAO e gravação
            TreinoDAO treinoDAO = new TreinoDAO();
            if (codTreino == 0) {
                // Inserir no banco e recuperar o codTreino gerado
                codTreino = treinoDAO.gravar(treino);
            } else {
                // Atualiza caso já tenha um codTreino
                treinoDAO.alterar(treino);
            }

            // Adicionar exercícios ao treino
            ExercicioTreinoDAO exercicioTreinoDAO = new ExercicioTreinoDAO();
            String[] exerciciosSelecionados = request.getParameterValues("exerciciosSelecionados");
            if (exerciciosSelecionados != null) {
                System.out.println("Exercícios selecionados para o treino: " + Arrays.toString(exerciciosSelecionados));

                for (String codExStr : exerciciosSelecionados) {
                    try {
                        int codEx = Integer.parseInt(codExStr);
                        System.out.println("Código do exercício: " + codEx);

                        ExercicioTreino exercicioTreino = new ExercicioTreino();
                        exercicioTreino.setCodTreino(codTreino);
                        exercicioTreino.setCodEx(codEx);

                        String tipoET = request.getParameter("tipoET_" + codEx);
                        if (tipoET != null) {
                            exercicioTreino.setTipoET(tipoET);
                        }
                        System.out.println("Tipo do exercício: " + tipoET);

                        String seriesETStr = request.getParameter("seriesET_" + codEx);
                        if (seriesETStr != null && !seriesETStr.isEmpty()) {
                            exercicioTreino.setSeriesET(Integer.parseInt(seriesETStr));
                        }

                        String repeticoesETStr = request.getParameter("repeticoesET_" + codEx);
                        if (repeticoesETStr != null && !repeticoesETStr.isEmpty()) {
                            exercicioTreino.setRepeticoesET(Integer.parseInt(repeticoesETStr));
                        }

                        String pesoETStr = request.getParameter("pesoET_" + codEx);
                        if (pesoETStr != null && !pesoETStr.isEmpty()) {
                            exercicioTreino.setPesoET(Double.parseDouble(pesoETStr));
                        }

                        String descansoETStr = request.getParameter("descansoET_" + codEx);
                        if (descansoETStr != null && !descansoETStr.isEmpty()) {
                            exercicioTreino.setDescansoET(Integer.parseInt(descansoETStr));
                        }

                        String duracaoETStr = request.getParameter("duracaoET_" + codEx);
                        if (duracaoETStr != null && !duracaoETStr.isEmpty()) {
                            exercicioTreino.setDuracaoET(Integer.parseInt(duracaoETStr));
                        }

                        String obsET = request.getParameter("obsET_" + codEx);
                        if (obsET != null) {
                            exercicioTreino.setObsET(obsET);
                        }

                        exercicioTreinoDAO.adicionarExercicioAoTreino(exercicioTreino);
                        System.out.println("Exercício adicionado ao treino: " + codEx);

                    } catch (NumberFormatException | SQLException e) {
                        System.out.println("Erro ao adicionar exercício ao treino: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
            } else {
                System.out.println("Nenhum exercício foi selecionado para o treino.");
            }

            // Armazenar a lista de exercícios no objeto da sessão
            HttpSession session = request.getSession();
            session.setAttribute("codAluno", codAluno);
            session.setAttribute("codTreino", codTreino);

            // Redirecionar para a segunda servlet
            response.sendRedirect("CadastrarTreinoAluno");

        } catch (NumberFormatException e) {
            System.out.println("Erro ao processar dados: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("CadastrarTreino"); // Redireciona de volta em caso de erro

        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            response.sendRedirect("CadastrarTreino"); // Redireciona de volta em caso de erro no banco de dados
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
        return "Servlet para cadastrar um treino e associar exercícios a ele";
    }
}
