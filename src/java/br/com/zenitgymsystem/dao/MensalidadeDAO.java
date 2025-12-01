package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Mensalidade;
import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class MensalidadeDAO {

    private Connection conexao;

    public MensalidadeDAO() throws ClassNotFoundException, SQLException {
        conexao = Conexao.abrirConexao();
    }

    public void gravar(Mensalidade mensalidade) throws SQLException {
        if (mensalidade.getCodMens() == 0) {
            this.inserir(mensalidade);
        } else {
            this.alterar(mensalidade);
        }
    }

    public void inserir(Object objeto) throws SQLException {
        Mensalidade mensalidade = (Mensalidade) objeto;
        String sql = "INSERT INTO Mensalidade  VALUES (default, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, mensalidade.getMesMens());
            stmt.setInt(2, mensalidade.getAnoMens());
            stmt.setDouble(3, mensalidade.getValorMens());
            stmt.setDate(4, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(mensalidade.getDtVencMens()).getTime()));
            stmt.setDate(5, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(mensalidade.getDtPagMens()).getTime()));
            stmt.setInt(6, mensalidade.getAluno().getCodAluno());
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao INSERIR MENSALIDADE!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<Mensalidade> listar() throws SQLException {
        String sql = "SELECT * FROM Mensalidade";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Mensalidade> listaMensalidades = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Mensalidade mensalidade = new Mensalidade(
                        rs.getInt("codMens"),
                        rs.getString("mesMens"),
                        rs.getInt("anoMens"),
                        rs.getDouble("valorMens"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtVencMens")),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtPagMens")),
                        (Aluno) new AlunoDAO().consultar(rs.getInt("codAluno"))
                );
                listaMensalidades.add(mensalidade);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao Listar Mensalidades!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listaMensalidades;
    }

    public Mensalidade consultar(int codMens) throws SQLException {
        String sql = "SELECT * FROM Mensalidade WHERE codMens = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Mensalidade mensalidade = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codMens);
            rs = stmt.executeQuery();
            if (rs.next()) {
                mensalidade = new Mensalidade(
                        rs.getInt("codMens"),
                        rs.getString("mesMens"),
                        rs.getInt("anoMens"),
                        rs.getDouble("valorMens"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtVencMens")),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtPagMens")),
                        (Aluno) new AlunoDAO().consultar(rs.getInt("codAluno"))
                );
            }
        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("ERRO na DAO ao consultar Mensalidade!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return mensalidade;
    }

    public void alterar(Mensalidade mensalidade) throws SQLException {
        String sql = "UPDATE Mensalidade SET mesMens = ?, anoMens = ?, valorMens = ?, dtVencMens = ?, dtPagMens = ? WHERE codMens = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, mensalidade.getMesMens());
            stmt.setInt(2, mensalidade.getAnoMens());
            stmt.setDouble(3, mensalidade.getValorMens());
            stmt.setDate(4, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(mensalidade.getDtVencMens()).getTime()));
            stmt.setDate(5, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(mensalidade.getDtPagMens()).getTime()));
            stmt.setInt(6, mensalidade.getAluno().getCodAluno());
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            throw new SQLException("Erro na DAO ao ALTERAR MENSALIDADE!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public void excluir(int codMens) throws SQLException {
        String sql = "DELETE FROM Mensalidade WHERE codMens = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codMens);
            stmt.execute();
        } catch (SQLException ex) {
            System.out.println("Problemas na DAO ao Deletar Mensalidade! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir Mensalidade!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }


}
