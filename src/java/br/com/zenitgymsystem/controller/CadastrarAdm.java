package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AdmDAO;
import br.com.zenitgymsystem.dao.PessoaDAO;
import br.com.zenitgymsystem.model.Administrador;
import br.com.zenitgymsystem.model.Pessoa;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="CadastrarAdm", urlPatterns={"/CadastrarAdm"})
public class CadastrarAdm extends HttpServlet {
   
    
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
            int codAdm = request.getParameter("codAdm").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codAdm"));
            boolean statusAdm = request.getParameter("statusAdm").equals("Ativo");
            
            Administrador adm = new Administrador(codAdm, statusAdm,  codPessoa, nomePessoa, senhaPessoa, dtnascPessoa, cpfPessoa, rgPessoa, sexoPessoa, celularPessoa, cepPessoa, endPessoa, complPessoa, numeroPessoa, cidadePessoa, ufPessoa, bairroPessoa, emailPessoa, imgPessoa);
            AdmDAO admDAO = new AdmDAO();
            PessoaDAO pessoaDAO = new PessoaDAO();
            

            Pessoa pessoaExistente = (Pessoa) pessoaDAO.consultar(cpfPessoa);
            Administrador admExistente = (Administrador) admDAO.consultarporCPF(cpfPessoa);
            if (pessoaExistente != null || admExistente != null) {
                request.setAttribute("mensagem", "Já existe uma pessoa/administrador cadastrada com este CPF.");
            } else {
                AdmDAO admDAO2 = new AdmDAO();
                admDAO2.gravar(adm);
                request.setAttribute("mensagem", "Administrador cadastrado com sucesso!");
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
