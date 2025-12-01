package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Entrega;
import br.com.zenitgymsystem.model.Equipamento;
import br.com.zenitgymsystem.model.Fornecedor;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


public class EntregaDAO {

    private Connection conexao;

    public EntregaDAO() throws ClassNotFoundException, SQLException {
        conexao = Conexao.abrirConexao();
    }

    public void gravar(Object objeto) throws SQLException {
        Entrega entrega = (Entrega) objeto;
        if (entrega.getCodEntrega() == 0) {
            this.inserir(entrega);
        } else {
            this.alterar(entrega);
        }
    }

    public void inserir(Object objeto) throws SQLException {
        Entrega entrega = (Entrega) objeto;
        String sql = "INSERT INTO entrega VALUES(default, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(entrega.getDataEntrega()).getTime()));
            stmt.setInt(2, entrega.getQuantEntrega());
            stmt.setString(3, entrega.getEnderecoEntrega());
            stmt.setString(4, entrega.getStatusEntrega());
            stmt.setInt(5, entrega.getFornecedor().getCodForn());
            stmt.setInt(6, entrega.getEquipamento().getCodEquip()); 
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao INSERIR ENTREGA!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<Object> listar() throws SQLException {
        String sql = "SELECT * FROM entrega";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> listaetg = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Entrega entrega = new Entrega(
                        rs.getInt("codEntrega"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dataEntrega")),
                        rs.getInt("quantEntrega"),
                        rs.getString("enderecoEntrega"),
                        rs.getString("statusEntrega"),
                        (Fornecedor) new FornecedorDAO().consultar(rs.getInt("codForn")), // Supondo que você tenha o código do fornecedor
                        (Equipamento) new EquipamentoDAO().consultar(rs.getInt("codEquip")) // Supondo que você tenha o código do equipamento
                );
                listaetg.add(entrega);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("Erro ao Listar Entregas!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listaetg;
    }

    public Object consultar(int codigo) throws SQLException {
        String sql = "SELECT * FROM entrega WHERE codEntrega = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Entrega entrega = new Entrega();
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            rs = stmt.executeQuery();
            if (rs.next()) {
                entrega = new Entrega(
                        rs.getInt("codEntrega"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dataEntrega")),
                        rs.getInt("quantEntrega"),
                        rs.getString("enderecoEntrega"),
                        rs.getString("statusEntrega"),
                        new Fornecedor(rs.getInt("codForn")), // Supondo que você tenha o código do fornecedor
                        new Equipamento(rs.getInt("codEquip")) // Supondo que você tenha o código do equipamento
                );
            }
        } catch (SQLException ex) {
            throw new SQLException("ERRO na DAO ao consultar entrega!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return entrega;
    }

    public void alterar(Object objeto) throws SQLException {
        Entrega entrega = (Entrega) objeto;
        String sql = "UPDATE entrega SET dataEntrega = ?, quantEntrega = ?, enderecoEntrega = ?, statusEntrega = ?, codForn = ?, codEquip = ? WHERE codEntrega = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(entrega.getDataEntrega()).getTime()));
            stmt.setInt(2, entrega.getQuantEntrega());
            stmt.setString(3, entrega.getEnderecoEntrega());
            stmt.setString(4, entrega.getStatusEntrega());
            stmt.setInt(5, entrega.getFornecedor().getCodForn()); // Assumindo que você tem um método getCodForn()
            stmt.setInt(6, entrega.getEquipamento().getCodEquip()); // Assumindo que você tem um método getCodEquipamento()
            stmt.setInt(7, entrega.getCodEntrega());
            stmt.executeUpdate();
        } catch (SQLException | ParseException ex) {
            throw new SQLException("Erro na DAO ao ALTERAR ENTREGA!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public void excluir(int codEntrega) throws SQLException {
        String sql = "DELETE FROM entrega WHERE codEntrega = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codEntrega);
            stmt.execute();
        } catch (SQLException ex) {
            System.out.println("Problemas na DAO ao Deletar Entrega! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir entrega!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}


