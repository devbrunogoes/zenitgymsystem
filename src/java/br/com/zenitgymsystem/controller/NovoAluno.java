package br.com.zenitgymsystem.controller;

import br.com.zenitgymsystem.dao.UsuarioDAO;
import br.com.zenitgymsystem.model.Aluno;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="NovoAluno", urlPatterns={"/NovoAluno"})
public class NovoAluno extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try{
        
        request.setAttribute("Aluno", new Aluno());
        
        request.setAttribute("Usuario", new UsuarioDAO().listar());
        
        
        } catch(SQLException | ClassNotFoundException ex){
            request.setAttribute("mensagem", "Erro: " + ex.getMessage());
   
        } 
        request.getRequestDispatcher("ListarUsuarios.jsp").forward(request, response);
        
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
