
package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Produto;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {
    
    private final Connection conexao;

    public ProdutoDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    public void gravar(Object objeto) throws SQLException {
        Produto produto = (Produto) objeto;
        if (produto.getCodProduto() == 0) {
            this.inserir(produto);
        } else {
            this.alterar(produto);
        }
    }

    public void inserir(Object objeto) throws SQLException {
        Produto produto = (Produto) objeto;
        String sql = "INSERT INTO Produto VALUES(default, ?, ?, ?, ?, ?,?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, produto.getNomeProduto());
            stmt.setString(2, produto.getDescProduto());
            stmt.setFloat(3, produto.getValorProduto());
            stmt.setInt(4, produto.getQtdProduto());
            stmt.setString(5, produto.getImgProduto());
            stmt.setString(6, produto.getCategoriaProduto());
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao INSERIR PRODUTO/SERVIÇO!" + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
        
    }

    public List<Object> listar() throws SQLException {
    String sql = "SELECT * FROM produto";
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<Object> lista = new ArrayList<>();
    try {
        stmt = conexao.prepareStatement(sql);
        rs = stmt.executeQuery();
        while (rs.next()) {
            Produto produto = new Produto(
                rs.getInt("codProduto"),
                rs.getString("nomeProduto"),
                rs.getString("descProduto"),
                rs.getFloat("valorProduto"),
                rs.getInt("qtdProduto"),
                rs.getString("imgProduto"),
                rs.getString("categoriaProduto")
            );
            lista.add(produto);
        }
    } catch (SQLException ex) {
        throw new SQLException("Erro ao Listar Produtos!", ex);
    } finally {
        Conexao.encerrarConexao(conexao, stmt, rs);
    }
    return lista;
}


    public Object consultar(int codProduto) throws SQLException {
        String sql = "SELECT * FROM produto WHERE codProduto = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Produto produto = new Produto();
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codProduto);
            rs = stmt.executeQuery();
            while (rs.next()) {
                produto = new Produto(
                    rs.getInt("codProduto"),
                    rs.getString("nomeProduto"),
                    rs.getString("descProduto"),
                    rs.getFloat("valorProduto"),
                    rs.getInt("qtdProduto"),
                    rs.getString("imgProduto"),
                    rs.getString("categoriaProduto")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao consultar produto!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return produto;
    }

    public void alterar(Object objeto) throws SQLException {
        String sql = "UPDATE produto SET nomeProduto = ?, descProduto = ?, valorProduto = ?, qtdProduto = ?, imgProduto = ?, categoriaProduto = ? WHERE codProduto = ?";
        Produto produto = (Produto) objeto;
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, produto.getNomeProduto());
            stmt.setString(2, produto.getDescProduto());
            stmt.setFloat(3, produto.getValorProduto());
            stmt.setInt(4, produto.getQtdProduto());
            stmt.setString(5, produto.getImgProduto());
            stmt.setString(6, produto.getCategoriaProduto());
            stmt.setInt(7, produto.getCodProduto());
            stmt.execute();
        } catch (SQLException ex) {
             System.out.println("Problemas na DAO ao Alterar Produto! ERRO: " + ex.getMessage());
            throw new SQLException("Erro na DAO ao ALTERAR PRODUTO!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public void excluir(int codProduto) throws SQLException {
        String sql = "DELETE FROM produto WHERE codProduto = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codProduto);
            stmt.execute();
        } catch (SQLException ex) {
            System.out.println("Problemas na DAO ao Deletar Produto! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir produto!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
    
}
