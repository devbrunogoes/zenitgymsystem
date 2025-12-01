package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Aula;
import br.com.zenitgymsystem.model.Personal;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class AulaDAO {

    private Connection conexao;

    public AulaDAO() throws SQLException, ClassNotFoundException {
        this.conexao = Conexao.abrirConexao();
    }

    // Método para gravar (inserir ou alterar)
    public void gravar(Object objeto) throws SQLException {
        Aula aula = (Aula) objeto;
        if (aula.getCodAula() == 0) {
            this.inserir(aula);
        } else {
            this.alterar(aula);
        }
    }

    // Método para inserir uma nova aula
    public void inserir(Object objeto) throws SQLException {
        Aula aula = (Aula) objeto;
        String sql = "INSERT INTO aula VALUES (default,?, ?, ?, ?,?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, aula.getNomeAula());
            stmt.setString(2, aula.getDescAula());
            stmt.setDate(3, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(aula.getDtAula()).getTime()));
            stmt.setString(4, aula.getHorarioAula());
            stmt.setInt(5, aula.getPersonal().getCodPers());
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao INSERIR AULA!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    // Método para listar todas as aulas
    public List<Object> listar() throws SQLException {
        String sql = "SELECT * FROM aula";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> listaAulas = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Aula aula = new Aula(
                        rs.getInt("codAula"),
                        rs.getString("nomeAula"),
                        rs.getString("descAula"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAula")),
                        rs.getString("horarioAula"),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers"))
                );
                listaAulas.add(aula);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("Erro ao Listar Aulas!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listaAulas;
    }

    public List<Aula> listarAulasPorAluno(int codAluno) throws SQLException {
    List<Aula> listaAulas = new ArrayList<>();
    String sql = "SELECT a.codAula, a.nomeAula, a.descAula, a.dtAula, a.horarioAula, a.codPers "
               + "FROM Aula a "
               + "JOIN AlunoAula aa ON a.codAula = aa.codAula "
               + "WHERE aa.codAluno = ?";  // Filtra pelo aluno logado
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, codAluno);  // Passa o código do aluno
        rs = stmt.executeQuery();

        while (rs.next()) {
            Aula aula = new Aula(
                    rs.getInt("codAula"),
                    rs.getString("nomeAula"),
                    rs.getString("descAula"),
                    new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAula")),
                    rs.getString("horarioAula"),
                    (Personal) new PersonalDAO().consultar(rs.getInt("codPers")) // Consulta o Personal responsável
            );
            listaAulas.add(aula);
        }

    } catch (SQLException | ClassNotFoundException ex) {
        throw new SQLException("Erro ao listar aulas do aluno.", ex);
    } finally {
        Conexao.encerrarConexao(conexao, stmt, rs);
    }

    return listaAulas;
}


    public List<Aula> listarAulasPorPersonal(int codPers) throws SQLException {
        List<Aula> listaAulas = new ArrayList<>();
        String sql = "SELECT codAula, nomeAula, descAula, dtAula, horarioAula, codPers "
                + "FROM Aula "
                + "WHERE codPers = ?"; // Filtra pelo código do Personal
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codPers); // Passa o código do Personal
            rs = stmt.executeQuery();

            while (rs.next()) {
                Aula aula = new Aula(
                        rs.getInt("codAula"),
                        rs.getString("nomeAula"),
                        rs.getString("descAula"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAula")),
                        rs.getString("horarioAula"),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers"))
                );
                listaAulas.add(aula);
            }

        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("Erro ao listar aulas para o Personal.", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }

        return listaAulas;
    }

    // Método para consultar uma aula pelo código
    public Object consultar(int codigo) throws SQLException {
        String sql = "SELECT * FROM Aula WHERE codAula = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Aula aula = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            rs = stmt.executeQuery();

            if (rs.next()) {
                aula = new Aula(
                        rs.getInt("codAula"),
                        rs.getString("nomeAula"),
                        rs.getString("descAula"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAula")),
                        rs.getString("horarioAula"),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers"))
                );
            }
        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("Erro ao consultar aula!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }

        return aula;
    }

    // Método para alterar uma aula existente
    public void alterar(Object objeto) throws SQLException {
        Aula aula = (Aula) objeto;
        String sql = "UPDATE Aula SET nomeAula = ?, descAula = ?, dtAula = ?, horarioAula = ?, codPers = ? WHERE codAula = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, aula.getNomeAula());
            stmt.setString(2, aula.getDescAula());
            stmt.setDate(3, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(aula.getDtAula()).getTime()));
            stmt.setString(4, aula.getHorarioAula());
            stmt.setInt(5, aula.getPersonal().getCodPers());
            stmt.setInt(6, aula.getCodAula());
            stmt.executeUpdate();
        } catch (SQLException | ParseException ex) {
            throw new SQLException("Erro ao alterar aula!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    // Método para excluir uma aula pelo código
    public void excluir(int codAula) throws SQLException {
        String sql = "DELETE FROM aula WHERE codAula = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codAula);
            stmt.execute();
        } catch (SQLException ex) {
            System.out.println("Problemas na DAO ao Deletar Aula! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir Aula!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}
