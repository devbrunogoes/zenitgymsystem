
package br.com.zenitgymsystem.model;


public class Aula {
    
    private int codAula;
    private String nomeAula;
    private String descAula; 
    private String dtAula;
    private String horarioAula;
    private Personal personal;
    

    public Aula() {
    }

    public Aula(int codAula) {
        this.codAula = codAula;
    }

    public Aula(int codAula, String nomeAula, String descAula, String dtAula, String horarioAula, Personal personal) {
        this.codAula = codAula;
        this.nomeAula = nomeAula;
        this.descAula = descAula;
        this.dtAula = dtAula;
        this.horarioAula = horarioAula;
        this.personal = personal;
    }

   

    
    

    public int getCodAula() {
        return codAula;
    }

    public void setCodAula(int codAula) {
        this.codAula = codAula;
    }

    public String getNomeAula() {
        return nomeAula;
    }

    public void setNomeAula(String nomeAula) {
        this.nomeAula = nomeAula;
    }

    public String getDescAula() {
        return descAula;
    }

    public void setDescAula(String descAula) {
        this.descAula = descAula;
    }

    public String getDtAula() {
        return dtAula;
    }

    public void setDtAula(String dtAula) {
        this.dtAula = dtAula;
    }

    public String getHorarioAula() {
        return horarioAula;
    }

    public void setHorarioAula(String horarioAula) {
        this.horarioAula = horarioAula;
    }

    public Personal getPersonal() {
        return personal;
    }

    public void setPersonal(Personal personal) {
        this.personal = personal;
    }

    
    
    
    
}
