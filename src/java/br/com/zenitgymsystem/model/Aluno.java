package br.com.zenitgymsystem.model;

public class Aluno extends Pessoa{
    
    private int codAluno;
    private boolean statusAluno;
    private String dtMatriculaAluno;
    private String obsAluno; 
    private Personal personal;
    private Plano plano;

    public Aluno() {
    }

    public Aluno(int codAluno) {
        this.codAluno = codAluno;
    }

    public Aluno(int codAluno, boolean statusAluno, String dtMatriculaAluno, String obsAluno, Personal personal, Plano plano) {
        this.codAluno = codAluno;
        this.statusAluno = statusAluno;
        this.dtMatriculaAluno = dtMatriculaAluno;
        this.obsAluno = obsAluno;
        this.personal = personal;
        this.plano = plano;
    }

    public Aluno(int codAluno, boolean statusAluno, String dtMatriculaAluno, String obsAluno, Personal personal, Plano plano, int codPessoa) {
        super(codPessoa);
        this.codAluno = codAluno;
        this.statusAluno = statusAluno;
        this.dtMatriculaAluno = dtMatriculaAluno;
        this.obsAluno = obsAluno;
        this.personal = personal;
        this.plano = plano;
    }

    public Aluno(int codAluno, boolean statusAluno, String dtMatriculaAluno, String obsAluno, Personal personal, Plano plano, int codPessoa, String nomePessoa, String senhaPessoa, String dtnascPessoa, String cpfPessoa, String rgPessoa, String sexoPessoa, String celularPessoa, String cepPessoa, String endPessoa, String complPessoa, int numeroPessoa, String cidadePessoa, String ufPessoa, String bairroPessoa, String emailPessoa, String imgPessoa) {
        super(codPessoa, nomePessoa, senhaPessoa, dtnascPessoa, cpfPessoa, rgPessoa, sexoPessoa, celularPessoa, cepPessoa, endPessoa, complPessoa, numeroPessoa, cidadePessoa, ufPessoa, bairroPessoa, emailPessoa, imgPessoa);
        this.codAluno = codAluno;
        this.statusAluno = statusAluno;
        this.dtMatriculaAluno = dtMatriculaAluno;
        this.obsAluno = obsAluno;
        this.personal = personal;
        this.plano = plano;
    }

    

    
    public int getCodAluno() {
        return codAluno;
    }

    public void setCodAluno(int codAluno) {
        this.codAluno = codAluno;
    }

    public boolean isStatusAluno() {
        return statusAluno;
    }

    public void setStatusAluno(boolean statusAluno) {
        this.statusAluno = statusAluno;
    }

    public String getDtMatriculaAluno() {
        return dtMatriculaAluno;
    }

    public void setDtMatriculaAluno(String dtMatriculaAluno) {
        this.dtMatriculaAluno = dtMatriculaAluno;
    }


    public String getObsAluno() {
        return obsAluno;
    }

    public void setObsAluno(String obsAluno) {
        this.obsAluno = obsAluno;
    }

    public Personal getPersonal() {
        return personal;
    }

    public void setPersonal(Personal personal) {
        this.personal = personal;
    }

    public Plano getPlano() {
        return plano;
    }

    public void setPlano(Plano plano) {
        this.plano = plano;
    }

    
    
    
    
}
