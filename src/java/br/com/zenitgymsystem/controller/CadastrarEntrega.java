
package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.EntregaDAO;
import br.com.zenitgymsystem.model.Entrega;
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

@WebServlet(name = "CadastrarEntrega", urlPatterns = {"/CadastrarEntrega"})
public class CadastrarEntrega extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            int codEntrega = request.getParameter("codEntrega").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codEntrega"));
            String dataEntrega = request.getParameter("dataEntrega");
            int quantEntrega = Integer.parseInt(request.getParameter("quantEntrega"));
            String enderecoEntrega = request.getParameter("enderecoEntrega");
            String statusEntrega = request.getParameter("statusEntrega");
            int codForn = request.getParameter("codForn").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codForn"));
            int codEquip = request.getParameter("codEquip").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codEquip"));

            // Cria o objeto Entrega
            Fornecedor fornecedor = new Fornecedor(codForn); // Presumindo que você tenha um construtor em Fornecedor
            Equipamento equipamento = new Equipamento(codEquip); // Presumindo que você tenha um construtor em Equipamento
            Entrega entrega = new Entrega(codEntrega, dataEntrega, quantEntrega, enderecoEntrega, statusEntrega, fornecedor, equipamento);
            EntregaDAO entregaDAO = new EntregaDAO();
            // Grava a entrega no banco de dados
            entregaDAO.gravar(entrega);

            // Define uma mensagem de sucesso
            request.setAttribute("mensagem", "Entrega cadastrada com sucesso!");

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
