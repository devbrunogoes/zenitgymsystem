package br.com.zenitgymsystem.model;

public class TreinoAluno {

    private int codTA;
    private Aluno aluno;
    private Treino treino;


    public TreinoAluno() {
    }

    public TreinoAluno(int codTA) {
        this.codTA = codTA;
    }

    public TreinoAluno(int codTA, Aluno aluno, Treino treino) {
        this.codTA = codTA;
        this.aluno = aluno;
        this.treino = treino;
    }

    

    public int getCodTA() {
        return codTA;
    }

    public void setCodTA(int codTA) {
        this.codTA = codTA;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public Treino getTreino() {
        return treino;
    }

    public void setTreino(Treino treino) {
        this.treino = treino;
    }

   

    // Método para associar um Aluno com o TreinoAluno
    public void setCodAluno(Aluno aluno) {
        this.aluno = aluno;  // Associando o objeto Aluno
    }

    // Método para associar um Treino com o TreinoAluno
    public void setCodTreino(Treino treino) {
        this.treino = treino;  // Associando o objeto Treino
    }
}
