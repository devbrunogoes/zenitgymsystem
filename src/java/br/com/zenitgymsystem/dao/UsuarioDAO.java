/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Usuario;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author BrunoGoes
 */
public class UsuarioDAO {

    private final Connection conexao;

    public UsuarioDAO() throws SQLException, ClassNotFoundException {
        this.conexao = Conexao.abrirConexao();
    }

    public Usuario realizarLogin(String cpfUsuario, String senhaUsuario, String perfilUsuario) throws SQLException {
        String sql = "select * from Usuario where cpfUsuario = ? and senhaUsuario = ? and perfilUsuario = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpfUsuario);
            stmt.setString(2, senhaUsuario);
            stmt.setString(3, perfilUsuario);
            rs = stmt.executeQuery();
            while (rs.next()) {
                usuario = new Usuario(
                        rs.getInt("codUsuario"),
                        rs.getString("nomeUsuario"),
                        rs.getString("cpfUsuario"),
                        rs.getString("senhaUsuario"),
                        rs.getString("perfilUsuario"),
                        rs.getString("imgUsuario")
                );
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao buscar usuário");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return usuario;
    }

    public List<Object> listar() throws SQLException {
        String sql = "SELECT * FROM Usuario ORDER BY codUsuario";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> lista = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario(rs.getInt("codUsuario"));
                usuario.setNomeUsuario(rs.getString("nomeUsuario"));
                usuario.setCpfUsuario(rs.getString("cpfUsuario"));
                usuario.setSenhaUsuario(rs.getString("senhaUsuario"));
                usuario.setPerfilUsuario(rs.getString("perfilUsuario"));
                usuario.setImgUsuario(rs.getString("imgUsuario"));
                lista.add(usuario);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro da DAO ao Listar Usuario! ERRO:" + ex.getMessage());
            throw new SQLException("Erro ao Listar Usuario!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return lista;
    }

    

}
