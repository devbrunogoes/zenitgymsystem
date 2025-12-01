package br.com.zenitgymsystem.model;


public class Analise {
    private int codAv;
    private double pesoAv;
    private double alturaAv;
    private double imcAv;
    private double percentGorduraAv;
    private double massaMuscularAv;
    private String pressaoAv;
    private int freqCardiacaAv;
    private double capacidadeAerobicaAv;
    private String objetivoAv;
    private String dtAgendamentoAv;
    private String hrAgendamentoAv;
    private boolean statusAv;
    private Aluno aluno;
    private Personal personal;

    public Analise() {
    }

    public Analise(int codAv) {
        this.codAv = codAv;
    }

    public Analise(int codAv, double pesoAv, double alturaAv, double imcAv, double percentGorduraAv, double massaMuscularAv, String pressaoAv, int freqCardiacaAv, double capacidadeAerobicaAv, String objetivoAv, String dtAgendamentoAv, String hrAgendamentoAv, boolean statusAv, Aluno aluno, Personal personal) {
        this.codAv = codAv;
        this.pesoAv = pesoAv;
        this.alturaAv = alturaAv;
        this.imcAv = imcAv;
        this.percentGorduraAv = percentGorduraAv;
        this.massaMuscularAv = massaMuscularAv;
        this.pressaoAv = pressaoAv;
        this.freqCardiacaAv = freqCardiacaAv;
        this.capacidadeAerobicaAv = capacidadeAerobicaAv;
        this.objetivoAv = objetivoAv;
        this.dtAgendamentoAv = dtAgendamentoAv;
        this.hrAgendamentoAv = hrAgendamentoAv;
        this.statusAv = statusAv;
        this.aluno = aluno;
        this.personal = personal;
    }

    

    

    

    public int getCodAv() {
        return codAv;
    }

    public void setCodAv(int codAv) {
        this.codAv = codAv;
    }

    public double getPesoAv() {
        return pesoAv;
    }

    public void setPesoAv(double pesoAv) {
        this.pesoAv = pesoAv;
    }

    public double getAlturaAv() {
        return alturaAv;
    }

    public void setAlturaAv(double alturaAv) {
        this.alturaAv = alturaAv;
    }

    public double getImcAv() {
        return imcAv;
    }

    public void setImcAv(double imcAv) {
        this.imcAv = imcAv;
    }

    public double getPercentGorduraAv() {
        return percentGorduraAv;
    }

    public void setPercentGorduraAv(double percentGorduraAv) {
        this.percentGorduraAv = percentGorduraAv;
    }

    public double getMassaMuscularAv() {
        return massaMuscularAv;
    }

    public void setMassaMuscularAv(double massaMuscularAv) {
        this.massaMuscularAv = massaMuscularAv;
    }

    public String getPressaoAv() {
        return pressaoAv;
    }

    public void setPressaoAv(String pressaoAv) {
        this.pressaoAv = pressaoAv;
    }

    public int getFreqCardiacaAv() {
        return freqCardiacaAv;
    }

    public void setFreqCardiacaAv(int freqCardiacaAv) {
        this.freqCardiacaAv = freqCardiacaAv;
    }

    public double getCapacidadeAerobicaAv() {
        return capacidadeAerobicaAv;
    }

    public void setCapacidadeAerobicaAv(double capacidadeAerobicaAv) {
        this.capacidadeAerobicaAv = capacidadeAerobicaAv;
    }

    public String getObjetivoAv() {
        return objetivoAv;
    }

    public void setObjetivoAv(String objetivoAv) {
        this.objetivoAv = objetivoAv;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public Personal getPersonal() {
        return personal;
    }

    public void setPersonal(Personal personal) {
        this.personal = personal;
    }

    public String getDtAgendamentoAv() {
        return dtAgendamentoAv;
    }

    public void setDtAgendamentoAv(String dtAgendamentoAv) {
        this.dtAgendamentoAv = dtAgendamentoAv;
    }

    public boolean isStatusAv() {
        return statusAv;
    }

    public void setStatusAv(boolean statusAv) {
        this.statusAv = statusAv;
    }

    public String getHrAgendamentoAv() {
        return hrAgendamentoAv;
    }

    public void setHrAgendamentoAv(String hrAgendamentoAv) {
        this.hrAgendamentoAv = hrAgendamentoAv;
    }

    
    
    
}

