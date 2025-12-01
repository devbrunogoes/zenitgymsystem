package br.com.zenitgymsystem.model;


public class ExercicioTreino {

    private int codET;
    private Exercicio exercicio;  // Exercicio objeto
    private Treino treino;  // Treino objeto
    private String tipoET;
    private int seriesET;
    private int repeticoesET;
    private double pesoET;
    private int descansoET;
    private int duracaoET;
    private String obsET;

    public ExercicioTreino() {
    }

    public ExercicioTreino(int codET) {
        this.codET = codET;
    }

    public ExercicioTreino(int codET, Exercicio exercicio, Treino treino, String tipoET, int seriesET, int repeticoesET, double pesoET, int descansoET, int duracaoET, String obsET) {
        this.codET = codET;
        this.exercicio = exercicio;
        this.treino = treino;
        this.tipoET = tipoET;
        this.seriesET = seriesET;
        this.repeticoesET = repeticoesET;
        this.pesoET = pesoET;
        this.descansoET = descansoET;
        this.duracaoET = duracaoET;
        this.obsET = obsET;
    }

    // Getters e Setters
    public int getCodET() {
        return codET;
    }

    public void setCodET(int codET) {
        this.codET = codET;
    }

    public Exercicio getExercicio() {
        return exercicio;
    }

    public void setExercicio(Exercicio exercicio) {
        this.exercicio = exercicio;
    }

    public Treino getTreino() {
        return treino;
    }

    public void setTreino(Treino treino) {
        this.treino = treino;
    }

    public String getTipoET() {
        return tipoET;
    }

    public void setTipoET(String tipoET) {
        this.tipoET = tipoET;
    }

    public int getSeriesET() {
        return seriesET;
    }

    public void setSeriesET(int seriesET) {
        this.seriesET = seriesET;
    }

    public int getRepeticoesET() {
        return repeticoesET;
    }

    public void setRepeticoesET(int repeticoesET) {
        this.repeticoesET = repeticoesET;
    }

    public double getPesoET() {
        return pesoET;
    }

    public void setPesoET(double pesoET) {
        this.pesoET = pesoET;
    }

    public int getDescansoET() {
        return descansoET;
    }

    public void setDescansoET(int descansoET) {
        this.descansoET = descansoET;
    }

    public int getDuracaoET() {
        return duracaoET;
    }

    public void setDuracaoET(int duracaoET) {
        this.duracaoET = duracaoET;
    }

    public String getObsET() {
        return obsET;
    }

    public void setObsET(String obsET) {
        this.obsET = obsET;
    }

    // Método para setar o código do exercício
    public void setCodEx(int codEx) {
        if (this.exercicio == null) {
            this.exercicio = new Exercicio(); // Criando o objeto Exercicio se não existir
        }
        this.exercicio.setCodEx(codEx); // Definindo o código no objeto Exercicio
    }

    // Método para setar o código do treino
    public void setCodTreino(int codTreino) {
        if (this.treino == null) {
            this.treino = new Treino(); // Criando o objeto Treino se não existir
        }
        this.treino.setCodTreino(codTreino); // Definindo o código no objeto Treino
    }
}
