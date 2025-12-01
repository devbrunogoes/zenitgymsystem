package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.PersonalDAO;
import br.com.zenitgymsystem.dao.PessoaDAO;
import br.com.zenitgymsystem.model.Personal;
import br.com.zenitgymsystem.model.Pessoa;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="CadastrarPersonal", urlPatterns={"/CadastrarPersonal"})
public class CadastrarPersonal extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            int codPessoa = request.getParameter("codPessoa").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codPessoa"));
            String nomePessoa = request.getParameter("nomePessoa");
            String senhaPessoa = request.getParameter("senhaPessoa");
            String dtnascPessoa = request.getParameter("dtnascPessoa");
            String cpfPessoa = request.getParameter("cpfPessoa");
            String rgPessoa = request.getParameter("rgPessoa");
            String sexoPessoa = request.getParameter("sexoPessoa");
            String celularPessoa = request.getParameter("celularPessoa");
            String cepPessoa = request.getParameter("cepPessoa");
            String endPessoa = request.getParameter("endPessoa");
            String complPessoa = request.getParameter("complPessoa");
            int numeroPessoa = Integer.parseInt(request.getParameter("numeroPessoa"));
            String cidadePessoa = request.getParameter("cidadePessoa");
            String ufPessoa = request.getParameter("ufPessoa");
            String bairroPessoa = request.getParameter("bairroPessoa");
            String emailPessoa = request.getParameter("emailPessoa");
            String imgPessoa = request.getParameter("imgPessoa");
            int codPers = request.getParameter("codPers").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codPers"));
            String dtcontratoPers = request.getParameter("dtcontratoPers");
            boolean statusPers = request.getParameter("statusPers").equals("Ativo");
            
            Personal pers = new Personal(codPers, dtcontratoPers , statusPers,  codPessoa, nomePessoa, senhaPessoa, dtnascPessoa, cpfPessoa, rgPessoa, sexoPessoa, celularPessoa, cepPessoa, endPessoa, complPessoa, numeroPessoa, cidadePessoa, ufPessoa, bairroPessoa, emailPessoa, imgPessoa);
            PersonalDAO persDAO = new PersonalDAO();
            PessoaDAO pessoaDAO = new PessoaDAO();
            

            Pessoa pessoaExistente = (Pessoa) pessoaDAO.consultar(cpfPessoa);
            Personal persExistente = (Personal) persDAO.consultarporCPF(cpfPessoa);
            if (pessoaExistente != null || persExistente != null) {
                request.setAttribute("mensagem", "Já existe uma pessoa/persionario cadastrada com este CPF.");
            } else {
                PersonalDAO persDAO2 = new PersonalDAO();
                persDAO2.gravar(pers);
                request.setAttribute("mensagem", "Personal cadastrado com sucesso!");
            }

        } catch (ClassNotFoundException | SQLException ex) {
            request.setAttribute("mensagem", ex.getMessage());
        } finally {
            request.getRequestDispatcher("ListarUsuarios").forward(request, response);

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
