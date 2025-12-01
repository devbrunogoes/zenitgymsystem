package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Fornecedor;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.Date; // Importar para usar o tipo Date
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class FornecedorDAO {

    private Connection conexao;

    public FornecedorDAO() throws ClassNotFoundException, SQLException {
        conexao = Conexao.abrirConexao();
    }

    public void gravar(Object objeto) throws SQLException {
        Fornecedor fornecedor = (Fornecedor) objeto;
        if (fornecedor.getCodForn() == 0) {
            this.inserir(fornecedor);
        } else {
            this.alterar(fornecedor);
        }
    }

    public void inserir(Object objeto) throws SQLException {
        Fornecedor fornecedor = (Fornecedor) objeto;
        String sql = "INSERT INTO fornecedor (nomeForn, celularForn, emailForn, cnpjForn, enderecoForn, dtCadastroForn, statusForn, obsForn) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, fornecedor.getNomeForn());
            stmt.setString(2, fornecedor.getCelularForn());
            stmt.setString(3, fornecedor.getEmailForn());
            stmt.setString(4, fornecedor.getCnpjForn());
            stmt.setString(5, fornecedor.getEnderecoForn());
            stmt.setDate(6, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(fornecedor.getDtCadastroForn()).getTime()));
            stmt.setBoolean(7, fornecedor.isStatusForn());
            stmt.setString(8, fornecedor.getObsForn()); // Alterado para obsForn
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao INSERIR FORNECEDOR!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<Object> listar() throws SQLException {
        String sql = "SELECT * FROM fornecedor";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> listaf = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Fornecedor fornecedor = new Fornecedor(
                        rs.getInt("codForn"),
                        rs.getString("nomeForn"),
                        rs.getString("celularForn"),
                        rs.getString("emailForn"),
                        rs.getString("cnpjForn"),
                        rs.getString("enderecoForn"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtCadastroForn")),
                        rs.getBoolean("statusForn"),
                        rs.getString("obsForn") // Alterado para obsForn
                );
                listaf.add(fornecedor);
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao Listar Fornecedor!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listaf;
    }

    public Object consultar(int codigo) throws SQLException {
        String sql = "SELECT * FROM fornecedor WHERE codForn = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Fornecedor fornecedor = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            rs = stmt.executeQuery();
            if (rs.next()) {
                fornecedor = new Fornecedor(rs.getInt("codForn"));
                fornecedor.setNomeForn(rs.getString("nomeForn"));
                fornecedor.setCelularForn(rs.getString("celularForn"));
                fornecedor.setEmailForn(rs.getString("emailForn"));
                fornecedor.setCnpjForn(rs.getString("cnpjForn"));
                fornecedor.setEnderecoForn(rs.getString("enderecoForn"));
                fornecedor.setDtCadastroForn(rs.getString("dtCadastroForn"));
                fornecedor.setStatusForn(rs.getBoolean("statusForn"));
                fornecedor.setObsForn(rs.getString("obsForn")); // Alterado para obsForn
            }
        } catch (SQLException ex) {
            throw new SQLException("ERRO na DAO ao consultar fornecedor!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return fornecedor;
    }

    public void alterar(Object objeto) throws SQLException {
        Fornecedor fornecedor = (Fornecedor) objeto;
        String sql = "UPDATE fornecedor SET nomeForn = ?, celularForn = ?, emailForn = ?, cnpjForn = ?, enderecoForn = ?, dtCadastroForn = ?, statusForn = ?, obsForn = ? WHERE codForn = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, fornecedor.getNomeForn());
            stmt.setString(2, fornecedor.getCelularForn());
            stmt.setString(3, fornecedor.getEmailForn());
            stmt.setString(4, fornecedor.getCnpjForn());
            stmt.setString(5, fornecedor.getEnderecoForn());
           stmt.setDate(6, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(fornecedor.getDtCadastroForn()).getTime())); // Usando a data formatada
            stmt.setBoolean(7, fornecedor.isStatusForn());
            stmt.setString(8, fornecedor.getObsForn()); // Alterado para obsForn
            stmt.setInt(9, fornecedor.getCodForn());
            stmt.executeUpdate(); 
        } catch (SQLException | ParseException ex) {
            throw new SQLException("Erro na DAO ao ALTERAR FORNECEDOR!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public boolean existeFornecedor(int codForn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM fornecedor WHERE codForn = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codForn);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Se o número de resultados for maior que 0, o fornecedor existe
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro na DAO ao VERIFICAR FORNECEDOR EXISTENTE!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return false;
    }

    public void excluir(int codForn) throws SQLException {
        String sql = "DELETE FROM fornecedor WHERE codForn = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codForn);
            stmt.execute();
        } catch (SQLException ex) {
            System.out.println("Problemas na DAO ao Deletar Fornecedor! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir fornecedor!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}
