package br.com.zenitgymsystem.dao;

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


public class PersonalDAO {
    
    private final Connection conexao;
    
    public PersonalDAO() throws ClassNotFoundException, SQLException{
        this.conexao = Conexao.abrirConexao();
    }
    
   
    public void gravar (Object objeto) throws SQLException{
        Personal pers = (Personal) objeto;
        if(pers.getCodPers()== 0 ){
            this.inserir(pers);
        }else{
            this.alterar(pers);
        }
        
    }

     public void inserir(Object objeto) throws SQLException {
        Personal personal = (Personal) objeto;
        String sql = "insert into personal values (default, ?, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(personal.getDtcontratoPers()).getTime()));
            stmt.setBoolean(2,personal.isStatusPers());
            stmt.setInt(3, new PessoaDAO().gravar(personal));
            stmt.execute();
        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir personal");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
    
    public List<Object> listar() throws SQLException{
        String sql = "select * from pessoa pe inner join personal fu on pe.codPessoa = fu.codPessoa";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> lista = new ArrayList<>();
        try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()) {
                Personal personal = new Personal(
                    rs.getInt("codPers"),
                    new SimpleDateFormat("yyyy-MM-dd")
                            .format(rs.getDate("dtcontratoPers")),
                    rs.getBoolean("statusPers"),
                    rs.getInt("codPessoa"),
                    rs.getString("nomepessoa"),
                    rs.getString("senhapessoa"),
                    new SimpleDateFormat("yyyy-MM-dd")
                            .format(rs.getDate("dtnascPessoa")),
                    rs.getString("cpfPessoa"),
                    rs.getString("rgPessoa"),
                    rs.getString("sexoPessoa"),
                    rs.getString("celularPessoa"),
                    rs.getString("cepPessoa"),
                    rs.getString("endPessoa"),
                    rs.getString("complPessoa"),
                    rs.getInt("numeroPessoa"),
                    rs.getString("cidadePessoa"),
                    rs.getString("ufPessoa"),
                    rs.getString("bairroPessoa"),
                    rs.getString("emailPessoa"),
                        rs.getString("imgPessoa")
                );
                lista.add(personal);
            }
        } catch(SQLException ex){
            throw new SQLException("Erro ao listar personal");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return lista;
    }
    
   public Object consultar(int codPers) throws SQLException{
        String sql = "select * from pessoa pe inner join personal fu on pe.codPessoa = fu.codPessoa where codPers = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Personal personal = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codPers);
            rs = stmt.executeQuery();
            while(rs.next()){
                personal = new Personal(
                rs.getInt("codPers"),
                new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtcontratoPers")),
                rs.getBoolean("statusPers"),
                
                    rs.getInt("codPessoa"),
                    rs.getString("nomepessoa"),
                    rs.getString("senhaPessoa"),
                    new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                    rs.getString("cpfpessoa"),
                    rs.getString("rgPessoa"),
                    rs.getString("sexoPessoa"),
                    rs.getString("celularPessoa"),
                    rs.getString("cepPessoa"),
                    rs.getString("endPessoa"),
                    rs.getString("complPessoa"),
                    rs.getInt("numeroPessoa"),
                    rs.getString("cidadePessoa"),
                    rs.getString("ufPessoa"),
                    rs.getString("bairroPessoa"),
                    rs.getString("emailPessoa"),
                        rs.getString("imgPessoa")
                ); 
            }
        }
        catch(SQLException  ex){
            ex.printStackTrace();
            System.out.println("Problemas ao Consultar Personal! ERRO: " + ex.getMessage());
            throw  new SQLException("ERRO na DAO ao consultar Personal!");
        }
        finally{
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return personal;
    }
   public Object consultarporCPF(String cpfPessoa) throws SQLException{
        String sql = "select * from pessoa pe inner join personal fu on pe.codPessoa = fu.codPessoa where cpfPessoa = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Personal personal = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpfPessoa);
            rs = stmt.executeQuery();
            while(rs.next()){
                personal = new Personal(
                rs.getInt("codPers"),
                new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtcontratoPers")),
                rs.getBoolean("statusPers"),
                
                    rs.getInt("codPessoa"),
                    rs.getString("nomepessoa"),
                    rs.getString("senhaPessoa"),
                    new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                    rs.getString("cpfpessoa"),
                    rs.getString("rgPessoa"),
                    rs.getString("sexoPessoa"),
                    rs.getString("celularPessoa"),
                    rs.getString("cepPessoa"),
                    rs.getString("endPessoa"),
                    rs.getString("complPessoa"),
                    rs.getInt("numeroPessoa"),
                    rs.getString("cidadePessoa"),
                    rs.getString("ufPessoa"),
                    rs.getString("bairroPessoa"),
                    rs.getString("emailPessoa"),
                        rs.getString("imgPessoa")
                ); 
            }
        }
        catch(SQLException  ex){
            ex.printStackTrace();
            System.out.println("Problemas ao Consultar Personal! ERRO: " + ex.getMessage());
            throw  new SQLException("ERRO na DAO ao consultar Personal!");
        }
        finally{
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return personal;
    }

    public void alterar(Object objeto) throws SQLException {
        Personal personal = (Personal) objeto;
        String sql = "UPDATE Personal SET statusPers = ?, dtcontratoPers = ? WHERE codPers = ?";
        PreparedStatement stmt = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setBoolean(1, personal.isStatusPers());
            stmt.setDate(2,new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(personal.getDtcontratoPers()).getTime()));
            stmt.setInt(3, personal.getCodPers());
            stmt.setInt(4, new PessoaDAO().gravar(personal));
            stmt.execute();
        }catch(SQLException | ParseException | ClassNotFoundException ex){
            //mostrar os erros para o progrmador
            System.out.print("ERRO na DAO Alterar Cliente! ERRO: " + ex.getMessage());
            //mostar uma pilha de erros
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao ALTERAR CLIENTE!");
        } finally{
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
    
    public void excluir(int codigo) throws SQLException{
        String sql = "DELETE FROM personal WHERE codPers = ?";
        /*O método PreparedStatement é usado para criar um objeto
        que representa a instrução SQL que será executada no banco*/
        PreparedStatement stmt = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            stmt.execute();
        }
        catch(SQLException ex){
            System.out.println("Problemas na DAO ao Deletar Personal! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir personal!");
        }
        finally{
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
    
}