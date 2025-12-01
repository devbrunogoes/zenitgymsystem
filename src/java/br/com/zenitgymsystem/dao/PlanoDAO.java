package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Plano;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PlanoDAO {
    private Connection conexao;

    public PlanoDAO() throws ClassNotFoundException, SQLException {
        conexao = Conexao.abrirConexao();
    }

    // Método para inserir um novo plano
    public void inserir(Plano plano) throws SQLException {
        String sql = "INSERT INTO Plano (nomePlano, valorMensalPlano, durMesPlano) VALUES (?, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, plano.getNomePlano());
            stmt.setDouble(2, plano.getValorMensalPlano());
            stmt.setInt(3, plano.getDurMesPlano());
            stmt.execute();
        } catch (SQLException ex) {
            throw new SQLException("Erro ao inserir plano!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    // Método para listar todos os planos
    public List<Plano> listar() throws SQLException {
        String sql = "SELECT * FROM Plano";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Plano> listaPlanos = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Plano plano = new Plano(
                    rs.getInt("codPlano"),
                    rs.getString("nomePlano"),
                    rs.getDouble("valorMensalPlano"),
                    rs.getInt("durMesPlano")
                );
                listaPlanos.add(plano);
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao listar planos!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listaPlanos;
    }

    // Método para consultar um plano específico
    public Plano consultar(int codPlano) throws SQLException {
        String sql = "SELECT * FROM Plano WHERE codPlano = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Plano plano = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codPlano);
            rs = stmt.executeQuery();
            if (rs.next()) {
                plano = new Plano(
                    rs.getInt("codPlano"),
                    rs.getString("nomePlano"),
                    rs.getDouble("valorMensalPlano"),
                    rs.getInt("durMesPlano")
                );
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao consultar plano!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return plano;
    }

    // Método para alterar um plano existente
    public void alterar(Plano plano) throws SQLException {
        String sql = "UPDATE Plano SET nomePlano = ?, valorMensalPlano = ?, durMesPlano = ? WHERE codPlano = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, plano.getNomePlano());
            stmt.setDouble(2, plano.getValorMensalPlano());
            stmt.setInt(3, plano.getDurMesPlano());
            stmt.setInt(4, plano.getCodPlano());
            stmt.execute();
        } catch (SQLException ex) {
            throw new SQLException("Erro ao alterar plano!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    // Método para excluir um plano
    public void excluir(int codPlano) throws SQLException {
        String sql = "DELETE FROM Plano WHERE codPlano = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codPlano);
            stmt.execute();
        } catch (SQLException ex) {
            throw new SQLException("Erro ao excluir plano!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}
