package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Personal;
import br.com.zenitgymsystem.model.Analise;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class AnaliseDAO {

    private Connection conexao;

    public AnaliseDAO() throws ClassNotFoundException, SQLException {
        conexao = Conexao.abrirConexao();
    }

    // Método para inserir ou atualizar uma análise
    public void gravar(Object objeto) throws SQLException {
        Analise analise = (Analise) objeto;
        if (analise.getCodAv() == 0) {
            this.inserir(analise);
        } else {
            this.alterar(analise);
        }
    }

    // Inserir nova análise
    public void inserir(Object objeto) throws SQLException {
        Analise analise = (Analise) objeto;
        String sql = "INSERT INTO analise (pesoAv, alturaAv, imcAv, percentGorduraAv, massaMuscularAv, pressaoAv, freqCardiacaAv, capacidadeAerobicaAv, objetivoAv, dtAgendamentoAv, hrAgendamentoAv, statusAv, codAluno, codPers) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, analise.getPesoAv());
            stmt.setDouble(2, analise.getAlturaAv());
            stmt.setDouble(3, analise.getImcAv());
            stmt.setDouble(4, analise.getPercentGorduraAv());
            stmt.setDouble(5, analise.getMassaMuscularAv());
            stmt.setString(6, analise.getPressaoAv());
            stmt.setInt(7, analise.getFreqCardiacaAv());
            stmt.setDouble(8, analise.getCapacidadeAerobicaAv());
            stmt.setString(9, analise.getObjetivoAv());
            stmt.setDate(10, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(analise.getDtAgendamentoAv()).getTime()));
            stmt.setString(11, analise.getHrAgendamentoAv());
            stmt.setBoolean(12, analise.isStatusAv());
            stmt.setInt(13, analise.getAluno().getCodAluno());
            stmt.setInt(14, analise.getPersonal().getCodPers());
            stmt.execute();
        } catch (SQLException | ParseException ex) {
            ex.printStackTrace();  // Imprime o erro no console para depuração
            throw new SQLException("Erro ao inserir análise: " + ex.getMessage());  // Lança a exceção com a mensagem detalhada
        } finally {
            // Fechar a conexão corretamente
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

// Listar todas as análises
    public List<Object> listar() throws SQLException {
        String sql = "SELECT * FROM analise";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> listaAnalise = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Analise analise = new Analise(
                        rs.getInt("codAv"),
                        rs.getDouble("pesoAv"),
                        rs.getDouble("alturaAv"),
                        rs.getDouble("imcAv"),
                        rs.getDouble("percentGorduraAv"),
                        rs.getDouble("massaMuscularAv"),
                        rs.getString("pressaoAv"),
                        rs.getInt("freqCardiacaAv"),
                        rs.getDouble("capacidadeAerobicaAv"),
                        rs.getString("objetivoAv"),
                        rs.getString("hrAgendamentoAv"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAgendamentoAv")),
                        rs.getBoolean("statusAv"),
                        (Aluno) new AlunoDAO().consultar(rs.getInt("codAluno")),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers"))
                );
                listaAnalise.add(analise);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("Erro ao listar análises!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return listaAnalise;
    }

    public List<Analise> listarAnalisesPorAluno(int codAluno) throws SQLException {
        List<Analise> listaAnalises = new ArrayList<>();
        String sql = "SELECT codAv, pesoAv, alturaAv, imcAv, percentGorduraAv, massaMuscularAv, "
                + "pressaoAv, freqCardiacaAv, capacidadeAerobicaAv, objetivoAv, "
                + "hrAgendamentoAv, dtAgendamentoAv, statusAv, codAluno, codPers "
                + "FROM Analise "
                + "WHERE codAluno = ?"; // Filtra pelo aluno logado
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codAluno);  // Passa o código do aluno
            rs = stmt.executeQuery();

            while (rs.next()) {
                Analise analise = new Analise(
                        rs.getInt("codAv"),
                        rs.getDouble("pesoAv"),
                        rs.getDouble("alturaAv"),
                        rs.getDouble("imcAv"),
                        rs.getDouble("percentGorduraAv"),
                        rs.getDouble("massaMuscularAv"),
                        rs.getString("pressaoAv"),
                        rs.getInt("freqCardiacaAv"),
                        rs.getDouble("capacidadeAerobicaAv"),
                        rs.getString("objetivoAv"),
                        rs.getString("hrAgendamentoAv"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAgendamentoAv")),
                        rs.getBoolean("statusAv"),
                        (Aluno) new AlunoDAO().consultar(rs.getInt("codAluno")),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers"))
                );
                listaAnalises.add(analise);
            }

        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("Erro ao listar aulas.");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }

        return listaAnalises;
    }

    public List<Analise> listarAnalisesPorPersonal(int codPers) throws SQLException {
        List<Analise> listaAnalises = new ArrayList<>();
        String sql = "SELECT codAv, pesoAv, alturaAv, imcAv, percentGorduraAv, massaMuscularAv, "
                + "pressaoAv, freqCardiacaAv, capacidadeAerobicaAv, objetivoAv, "
                + "hrAgendamentoAv, dtAgendamentoAv, statusAv, codAluno, codPers "
                + "FROM Analise "
                + "WHERE codPers = ?"; // Filtra pelo personal logado
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codPers); // Passa o código do personal
            rs = stmt.executeQuery();

            while (rs.next()) {
                Analise analise = new Analise(
                        rs.getInt("codAv"),
                        rs.getDouble("pesoAv"),
                        rs.getDouble("alturaAv"),
                        rs.getDouble("imcAv"),
                        rs.getDouble("percentGorduraAv"),
                        rs.getDouble("massaMuscularAv"),
                        rs.getString("pressaoAv"),
                        rs.getInt("freqCardiacaAv"),
                        rs.getDouble("capacidadeAerobicaAv"),
                        rs.getString("objetivoAv"),
                        rs.getString("hrAgendamentoAv"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAgendamentoAv")),
                        rs.getBoolean("statusAv"),
                        (Aluno) new AlunoDAO().consultar(rs.getInt("codAluno")),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers"))
                );
                listaAnalises.add(analise);
            }

        } catch (SQLException | ClassNotFoundException ex) {
            throw new SQLException("Erro ao listar análises para o personal.");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }

        return listaAnalises;
    }

    // Consultar análise por código
    public Analise consultar(int codAv) throws SQLException {
        String sql = "SELECT * FROM analise WHERE codAv = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Analise analise = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codAv);
            rs = stmt.executeQuery();
            if (rs.next()) {
                analise = new Analise(
                        rs.getInt("codAv"),
                        rs.getDouble("pesoAv"),
                        rs.getDouble("alturaAv"),
                        rs.getDouble("imcAv"),
                        rs.getDouble("percentGorduraAv"),
                        rs.getDouble("massaMuscularAv"),
                        rs.getString("pressaoAv"),
                        rs.getInt("freqCardiacaAv"),
                        rs.getDouble("capacidadeAerobicaAv"),
                        rs.getString("objetivoAv"),
                        rs.getString("hrAgendamentoAv"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtAgendamentoAv")),
                        rs.getBoolean("statusAv"),
                        new Aluno(rs.getInt("codAluno")),
                        new Personal(rs.getInt("codPers"))
                );
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao consultar análise!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return analise;
    }

    // Atualizar análise
    public void alterar(Object objeto) throws SQLException {
        Analise analise = (Analise) objeto;
        String sql = "UPDATE analise SET  pesoAv = ?, alturaAv = ?, imcAv = ?, percentGorduraAv = ?, massaMuscularAv = ?, pressaoAv = ?, freqCardiacaAv = ?, capacidadeAerobicaAv = ?, objetivoAv = ?, codAluno = ?, codPers = ? WHERE codAv = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, analise.getPesoAv());
            stmt.setDouble(2, analise.getAlturaAv());
            stmt.setDouble(3, analise.getImcAv());
            stmt.setDouble(4, analise.getPercentGorduraAv());
            stmt.setDouble(5, analise.getMassaMuscularAv());
            stmt.setString(6, analise.getPressaoAv());
            stmt.setInt(7, analise.getFreqCardiacaAv());
            stmt.setDouble(8, analise.getCapacidadeAerobicaAv());
            stmt.setString(9, analise.getObjetivoAv());
            stmt.setString(10, analise.getHrAgendamentoAv());
            stmt.setDate(11, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(analise.getDtAgendamentoAv()).getTime()));
            stmt.setBoolean(12, analise.isStatusAv());
            stmt.setInt(13, analise.getAluno().getCodAluno());
            stmt.setInt(14, analise.getPersonal().getCodPers());
            stmt.setInt(15, analise.getCodAv());
            stmt.executeUpdate();
        } catch (SQLException | ParseException ex) {
            throw new SQLException("Erro ao atualizar análise!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    // Excluir análise
    public void excluir(int codAv) throws SQLException {
        String sql = "DELETE FROM analise WHERE codAv = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codAv);
            stmt.execute();
        } catch (SQLException ex) {
            throw new SQLException("Erro ao excluir análise!", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

}
