
package br.com.zenitgymsystem.model;


public class Exercicio {
    
    private int codEx;
    private String nomeEx;
    private String grupoEx;
    
    

    public Exercicio() {
    }

    public Exercicio(int codEx) {
        this.codEx = codEx;
    }

    public Exercicio(int codEx, String nomeEx, String grupoEx) {
        this.codEx = codEx;
        this.nomeEx = nomeEx;
        this.grupoEx = grupoEx;
    }

    public int getCodEx() {
        return codEx;
    }

    public void setCodEx(int codEx) {
        this.codEx = codEx;
    }

    public String getNomeEx() {
        return nomeEx;
    }

    public void setNomeEx(String nomeEx) {
        this.nomeEx = nomeEx;
    }

    public String getGrupoEx() {
        return grupoEx;
    }

    public void setGrupoEx(String grupoEx) {
        this.grupoEx = grupoEx;
    }

    
    
    

    
}
