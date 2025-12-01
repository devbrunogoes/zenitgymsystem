package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.AlunoDAO;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name="ListarAlunosPers", urlPatterns={"/ListarAlunosPers"})
public class ListarAlunosPers extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

          try {
             HttpSession sessao = request.getSession(false);
            Usuario usuario = (Usuario) sessao.getAttribute("usuario");

            int codPers = usuario.getCodUsuario();
            AlunoDAO alunoDAO = new AlunoDAO();
            List<Aluno> listaalpers = alunoDAO.listarAlunosPorPersonal(codPers);
            request.setAttribute("alunospers", listaalpers);
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            request.setAttribute("erro", "Erro ao listar alunos.");
        }finally{

        request.getRequestDispatcher("AlunosPers.jsp").forward(request, response);
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
