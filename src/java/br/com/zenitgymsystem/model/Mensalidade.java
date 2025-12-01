package br.com.zenitgymsystem.model;


public class Mensalidade {

    private int codMens;
    private String mesMens;
    private int anoMens;
    private double valorMens;
    private String dtVencMens;
    private String dtPagMens;
    private Aluno aluno;

    public Mensalidade() {
    }

    public Mensalidade(int codMens) {
        this.codMens = codMens;
    }

    public Mensalidade(int codMens, String mesMens, int anoMens, double valorMens, String dtVencMens, String dtPagMens, Aluno aluno) {
        this.codMens = codMens;
        this.mesMens = mesMens;
        this.anoMens = anoMens;
        this.valorMens = valorMens;
        this.dtVencMens = dtVencMens;
        this.dtPagMens = dtPagMens;
        this.aluno = aluno;
    }

    public int getCodMens() {
        return codMens;
    }

    public void setCodMens(int codMens) {
        this.codMens = codMens;
    }

    public String getMesMens() {
        return mesMens;
    }

    public void setMesMens(String mesMens) {
        this.mesMens = mesMens;
    }

    public int getAnoMens() {
        return anoMens;
    }

    public void setAnoMens(int anoMens) {
        this.anoMens = anoMens;
    }

    public double getValorMens() {
        return valorMens;
    }

    public void setValorMens(double valorMens) {
        this.valorMens = valorMens;
    }

    public String getDtVencMens() {
        return dtVencMens;
    }

    public void setDtVencMens(String dtVencMens) {
        this.dtVencMens = dtVencMens;
    }

    public String getDtPagMens() {
        return dtPagMens;
    }

    public void setDtPagMens(String dtPagMens) {
        this.dtPagMens = dtPagMens;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }
    
    
    
    
}
