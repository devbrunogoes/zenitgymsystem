package br.com.zenitgymsystem.dao;

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

public class EquipamentoDAO {

    private Connection conexao;

    public EquipamentoDAO() throws ClassNotFoundException, SQLException {
        conexao = Conexao.abrirConexao();
    }

    public void gravar(Equipamento equipamento) throws SQLException {
        if (equipamento.getCodEquip() == 0) {
            this.inserir(equipamento);
        } else {
            this.alterar(equipamento);
        }
    }

    public void inserir(Object objeto) throws SQLException {
        Equipamento equipamento = (Equipamento) objeto;
        String sql = "INSERT INTO Equipamento VALUES (default, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, equipamento.getNomeEquip());
            stmt.setString(2, equipamento.getDescEquip());
            stmt.setDate(3, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(equipamento.getDtAquisicaoEquip()).getTime()));
            stmt.setString(4, equipamento.getEstadoConsEquip());
            stmt.setString(5, equipamento.getStatusEquip());
            stmt.setDate(6, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(equipamento.getDtUltManuEquip()).getTime()));
            stmt.setInt(7, equipamento.getFornecedor().getCodForn());
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao INSERIR EQUIPAMENTO!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<Object> listar() throws SQLException {
        String sql = "SELECT * from Equipamento";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> listae = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Equipamento equipamento = new Equipamento(
                        rs.getInt("codEquip"),
                        rs.getString("nomeEquip"),
                        rs.getString("descEquip"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAquisicaoEquip")),
                        rs.getString("estadoConsEquip"),
                        rs.getString("statusEquip"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtUltManuEquip")),
                        (Fornecedor) new FornecedorDAO().consultar(rs.getInt("codForn"))      
                );
                listae.add(equipamento);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao Listar Equipamentos!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listae;
    }

    public Object consultar(int codigo) throws SQLException {
        String sql = "SELECT * FROM Equipamento WHERE codEquip = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Equipamento equipamento = new Equipamento();
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            rs = stmt.executeQuery();
            if (rs.next()) {
                equipamento = new Equipamento(
                        rs.getInt("codEquip"),
                        rs.getString("nomeEquip"),
                        rs.getString("descEquip"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAquisicaoEquip")),
                        rs.getString("estadoConsEquip"),
                        rs.getString("statusEquip"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtUltManuEquip")),
                        new Fornecedor(rs.getInt("codForn"))
                );
            }
        } catch (SQLException ex) {
            throw new SQLException("ERRO na DAO ao consultar equipamento!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return equipamento;
    }

    public void alterar(Object objeto) throws SQLException {
        Equipamento equipamento = (Equipamento) objeto;
        String sql = "UPDATE Equipamento SET nomeEquip = ?, descEquip = ?, dtAquisicaoEquip = ?, estadoConsEquip = ?, statusEquip = ?, dtUltManuEquip = ?, codForn = ? WHERE codEquip = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, equipamento.getNomeEquip());
            stmt.setString(2, equipamento.getDescEquip());
            stmt.setDate(3, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(equipamento.getDtAquisicaoEquip()).getTime()));
            stmt.setString(4, equipamento.getEstadoConsEquip());
            stmt.setString(5, equipamento.getStatusEquip());
            stmt.setDate(6, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(equipamento.getDtUltManuEquip()).getTime()));
            stmt.setInt(7, equipamento.getFornecedor().getCodForn());
            stmt.setInt(8, equipamento.getCodEquip());
            stmt.executeUpdate();
        } catch (SQLException | ParseException ex) {
            throw new SQLException("Erro na DAO ao ALTERAR EQUIPAMENTO!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public void excluir(int codEquip) throws SQLException {
        String sql = "DELETE FROM Equipamento WHERE codEquip = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codEquip);
            stmt.execute();
        } catch (SQLException ex) {
            System.out.println("Problemas na DAO ao Deletar Equipamento! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir equipamento!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}
