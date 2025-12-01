package br.com.zenitgymsystem.model;


public class Plano {

    private int codPlano;
    private String nomePlano;
    private double valorMensalPlano;
    private int durMesPlano;

    public Plano() {
    }

    public Plano(int codPlano) {
        this.codPlano = codPlano;
    }

    public Plano(int codPlano, String nomePlano, double valorMensalPlano, int durMesPlano) {
        this.codPlano = codPlano;
        this.nomePlano = nomePlano;
        this.valorMensalPlano = valorMensalPlano;
        this.durMesPlano = durMesPlano;
    }

    public int getCodPlano() {
        return codPlano;
    }

    public void setCodPlano(int codPlano) {
        this.codPlano = codPlano;
    }

    public String getNomePlano() {
        return nomePlano;
    }

    public void setNomePlano(String nomePlano) {
        this.nomePlano = nomePlano;
    }

    public double getValorMensalPlano() {
        return valorMensalPlano;
    }

    public void setValorMensalPlano(double valorMensalPlano) {
        this.valorMensalPlano = valorMensalPlano;
    }

    public int getDurMesPlano() {
        return durMesPlano;
    }

    public void setDurMesPlano(int durMesPlano) {
        this.durMesPlano = durMesPlano;
    }

    
    
    
}
