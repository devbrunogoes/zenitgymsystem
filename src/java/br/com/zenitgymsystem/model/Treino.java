package br.com.zenitgymsystem.model;


public class Treino {
    private int codTreino;
    private String nomeTreino;
    private String descricaoTreino;
    private String dtTreino;
    private boolean statusTreino;

    public Treino() {
    }

    public Treino(int codTreino) {
        this.codTreino = codTreino;
    }

    public Treino(int codTreino, String nomeTreino, String descricaoTreino, String dtTreino, boolean statusTreino) {
        this.codTreino = codTreino;
        this.nomeTreino = nomeTreino;
        this.descricaoTreino = descricaoTreino;
        this.dtTreino = dtTreino;
        this.statusTreino = statusTreino;
    }


    // Getters e Setters
    public int getCodTreino() {
        return codTreino;
    }

    public void setCodTreino(int codTreino) {
        this.codTreino = codTreino;
    }

    public String getNomeTreino() {
        return nomeTreino;
    }

    public void setNomeTreino(String nomeTreino) {
        this.nomeTreino = nomeTreino;
    }

    public String getDescricaoTreino() {
        return descricaoTreino;
    }

    public void setDescricaoTreino(String descricaoTreino) {
        this.descricaoTreino = descricaoTreino;
    }

    public String getDtTreino() {
        return dtTreino;
    }

    public void setDtTreino(String dtTreino) {
        this.dtTreino = dtTreino;
    }

    public boolean isStatusTreino() {
        return statusTreino;
    }

    public void setStatusTreino(boolean statusTreino) {
        this.statusTreino = statusTreino;
    }

   
    
}

