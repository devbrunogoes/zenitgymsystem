package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.EquipamentoDAO;
import br.com.zenitgymsystem.model.Equipamento;
import br.com.zenitgymsystem.model.Fornecedor;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CadastrarEquip", urlPatterns = {"/CadastrarEquip"})
public class CadastrarEquip extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            int codEquip = request.getParameter("codEquip").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codEquip"));
            String nomeEquip = request.getParameter("nomeEquip");
            String descEquip = request.getParameter("descEquip");
            String dtAquisicaoEquip = request.getParameter("dtAquisicaoEquip");
            String estadoConsEquip = request.getParameter("estadoConsEquip"); // 'novo', 'usado', 'precisa de reparo'
            String statusEquip = request.getParameter("statusEquip"); // 'ativo', 'inativo', 'manutencao'
            String dtUltManuEquip = request.getParameter("dtUltManuEquip");
            int codForn = request.getParameter("codForn").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codForn"));

            // Cria o objeto Equipamento
            Fornecedor fornecedor = new Fornecedor(codForn);
            Equipamento equipamento = new Equipamento(codEquip, nomeEquip, descEquip, dtAquisicaoEquip, estadoConsEquip, statusEquip, dtUltManuEquip, fornecedor);
            EquipamentoDAO equipamentoDAO = new EquipamentoDAO();
            
            // Grava o equipamento no banco de dados
            equipamentoDAO.gravar(equipamento);

            // Define uma mensagem de sucesso
            request.setAttribute("mensagem", "Equipamento cadastrado com sucesso!");

        } catch (SQLException | ClassNotFoundException ex) {
            // Define a mensagem de erro
            request.setAttribute("mensagem", ex.getMessage());
        } finally {
            // Redireciona para a listagem dos equipamentos
            request.getRequestDispatcher("ListarEEF").forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
