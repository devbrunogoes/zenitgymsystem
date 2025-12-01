package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AlunoDAO;
import br.com.zenitgymsystem.dao.PessoaDAO;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Personal;
import br.com.zenitgymsystem.model.Pessoa;
import br.com.zenitgymsystem.model.Plano;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="CadastrarAluno", urlPatterns={"/CadastrarAluno"})
public class CadastrarAluno extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Recuperar e validar os parâmetros do request
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
            int numeroPessoa = request.getParameter("numeroPessoa").isEmpty() ? 0 : Integer.parseInt(request.getParameter("numeroPessoa"));
            String cidadePessoa = request.getParameter("cidadePessoa");
            String ufPessoa = request.getParameter("ufPessoa");
            String bairroPessoa = request.getParameter("bairroPessoa");
            String emailPessoa = request.getParameter("emailPessoa");
            String imgPessoa = request.getParameter("imgPessoa");
            boolean statusAluno = request.getParameter("statusAluno").equals("Ativo");
            String dtMatriculaAluno = request.getParameter("dtMatriculaAluno");
            String obsAluno = request.getParameter("obsAluno");
            int codPers = request.getParameter("codPers").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codPers"));
            int codPlano = request.getParameter("codPlano").isEmpty() ? 0 : Integer.parseInt(request.getParameter("codPlano"));

            System.out.println("codPessoa: " + codPessoa);
        System.out.println("nomePessoa: " + nomePessoa);
            
            // Instanciar os objetos de Personal e Plano, se necessário
            Personal personal = codPers != 0 ? new Personal(codPers) : null;
            Plano plano = codPlano != 0 ? new Plano(codPlano) : null;

            // Criar o objeto Aluno
            Aluno aluno = new Aluno(0, statusAluno, dtMatriculaAluno, obsAluno,
                    personal != null ? personal : new Personal(0),
                    plano != null ? plano : new Plano(0),
                    codPessoa, nomePessoa, senhaPessoa, dtnascPessoa, cpfPessoa, rgPessoa, sexoPessoa,
                    celularPessoa, cepPessoa, endPessoa, complPessoa, numeroPessoa, cidadePessoa, ufPessoa,
                    bairroPessoa, emailPessoa, imgPessoa);

            // Interação com os DAOs
            AlunoDAO alunoDAO = new AlunoDAO();
            PessoaDAO pessoaDAO = new PessoaDAO();

            // Verifica se a pessoa já existe
            Pessoa pessoaExistente = (Pessoa) pessoaDAO.consultar(cpfPessoa);
            Aluno alunoExistente = (Aluno) alunoDAO.consultarporCPF(cpfPessoa);

            if (pessoaExistente != null) {
                aluno.setCodPessoa(pessoaExistente.getCodPessoa());
            }

            if (alunoExistente != null) {
                aluno.setCodAluno(alunoExistente.getCodAluno());
            } else {
                alunoDAO.gravar(aluno); // Grava o aluno somente se não existir
                request.setAttribute("mensagem", "Aluno gravado com sucesso!");
            }

       } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        request.setAttribute("mensagem", "Erro: " + ex.getMessage());
    } catch (IllegalArgumentException ex) {
         ex.printStackTrace();
        request.setAttribute("mensagem", "Erro: " + ex.getMessage());
    } catch (Exception ex) {
         ex.printStackTrace();
        request.setAttribute("mensagem", "Erro inesperado: " + ex.getMessage());
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
