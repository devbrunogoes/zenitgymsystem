package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Exercicio;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExercicioDAO {

    private final Connection conexao;

    public ExercicioDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    public void gravar(Object objeto) throws SQLException {
        Exercicio exercicio = (Exercicio) objeto;
        if (exercicio.getCodEx() == 0) {
            this.inserir(exercicio);
        } else {
            this.alterar(exercicio);
        }
    }

    public void inserir(Exercicio exercicio) throws SQLException {
        String sql = "INSERT INTO exercicio (nomeEx, grupoEx) VALUES (?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, exercicio.getNomeEx());
            stmt.setString(2, exercicio.getGrupoEx());
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir exercício");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<Exercicio> listar() throws SQLException {
        String sql = "SELECT * FROM exercicio";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Exercicio> lista = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Exercicio exercicio = new Exercicio(
                        rs.getInt("codEx"),
                        rs.getString("nomeEx"),
                        rs.getString("grupoEx")
                );
                lista.add(exercicio);
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao listar exercícios");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return lista;
    }

    public void alterar(Exercicio exercicio) throws SQLException {
        String sql = "UPDATE exercicio SET nomeEx = ?, grupoEx = ? WHERE codEx = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, exercicio.getNomeEx());
            stmt.setString(2, exercicio.getGrupoEx());
            stmt.setInt(3, exercicio.getCodEx());
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao alterar exercício");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public Exercicio consultar(int codigo) throws SQLException {
        String sql = "SELECT * FROM exercicio WHERE codEx = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Exercicio exercicio = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            rs = stmt.executeQuery();
            if (rs.next()) {
                exercicio = new Exercicio(rs.getInt("codEx"));
                exercicio.setNomeEx(rs.getString("nomeEx"));
                exercicio.setGrupoEx(rs.getString("grupoEx"));
            }
        } catch (SQLException ex) {
            throw new SQLException("ERRO na DAO ao consultar exercício!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return exercicio;
    }

    public void excluir(int codEx) throws SQLException {
        String sql = "DELETE FROM exercicio WHERE codEx = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codEx);
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao excluir exercício");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}
