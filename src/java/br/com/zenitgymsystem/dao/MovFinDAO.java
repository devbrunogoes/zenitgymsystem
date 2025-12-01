package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Fornecedor;
import br.com.zenitgymsystem.model.MovFin;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class MovFinDAO {

    private final Connection conexao;

    public MovFinDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    // Método para gravar (inserir ou atualizar)
    public void gravar(Object objeto) throws SQLException {
        MovFin mov = (MovFin) objeto;
        if (mov.getCodMov() == 0) {
            this.inserir(mov);
        } else {
            this.alterar(mov);
        }
    }

    // Método para inserir uma nova movimentação
    public void inserir(Object objeto) throws SQLException {
        MovFin mov = (MovFin) objeto;
        String sql = "INSERT INTO MovFin VALUES (default, ?, ?, ?, ?, ?, ?, ?) RETURNING codMov";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, mov.getDescMov());
            stmt.setBoolean(2, mov.isTipoMov());
            stmt.setDouble(3, mov.getValorMov());
            stmt.setDate(4, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(mov.getDtMov()).getTime()));
            stmt.setString(5, mov.getTipoPagMov());
            stmt.setString(6, mov.getCategoriaMov());
            stmt.setString(7, mov.getObsMov());
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir movimentação: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    // Método para listar todas as movimentações
    public List<Object> listar() throws SQLException {
        String sql = "SELECT * FROM MovFin";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> listafluxo = new ArrayList<>();

        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                MovFin mov = new MovFin(
                        rs.getInt("codMov"),
                        rs.getString("descMov"),
                        rs.getBoolean("tipoMov"),
                        rs.getDouble("valorMov"),
                        new SimpleDateFormat("yyyy-MM-dd")
                            .format(rs.getDate("dtMov")),
                        rs.getString("tipoPagMov"),
                        rs.getString("categoriaMov"),
                        rs.getString("obsMov")
                );
                listafluxo.add(mov);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao listar movimentações: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listafluxo;
    }

    // Método para consultar uma movimentação por código
    public MovFin consultar(int codMov) throws SQLException {
        String sql = "SELECT * FROM MovFin WHERE codMov = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        MovFin mov = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codMov);
            rs = stmt.executeQuery();
            if (rs.next()) {
                mov = new MovFin(
                        rs.getInt("codMov"),
                        rs.getString("descMov"),
                        rs.getBoolean("tipoMov"),
                        rs.getDouble("valorMov"),
                        rs.getDate("dtMov").toString(),
                        rs.getString("tipoPagMov"),
                        rs.getString("categoriaMov"),
                        rs.getString("obsMov")
                );
            }
        } catch (SQLException  ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao consultar movimentação: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return mov;
    }

    // Método para alterar uma movimentação existente
    public void alterar(Object objeto) throws SQLException {
        MovFin mov = (MovFin) objeto;
        String sql = "UPDATE MovFin SET descMov = ?, tipoMov = ?, valorMov = ?, dtMov = ?, tipoPagMov = ?, categoriaMov = ?, obsMov = ? WHERE codMov = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, mov.getDescMov());
            stmt.setBoolean(2, mov.isTipoMov());
            stmt.setDouble(3, mov.getValorMov());
            stmt.setDate(4, java.sql.Date.valueOf(mov.getDtMov()));
            stmt.setString(5, mov.getTipoPagMov());
            stmt.setString(6, mov.getCategoriaMov());
            stmt.setString(7, mov.getObsMov());

            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao alterar movimentação: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}
