package br.com.zenitgymsystem.model;


public class AlunoAula {

    private int codAlunoAula;
    private Aluno aluno;
    private Aula aula;

    public AlunoAula() {
    }

    public AlunoAula(int codAlunoAula) {
        this.codAlunoAula = codAlunoAula;
    }

    public AlunoAula(int codAlunoAula, Aluno aluno, Aula aula) {
        this.codAlunoAula = codAlunoAula;
        this.aluno = aluno;
        this.aula = aula;
    }

    public int getCodAlunoAula() {
        return codAlunoAula;
    }

    public void setCodAlunoAula(int codAlunoAula) {
        this.codAlunoAula = codAlunoAula;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public Aula getAula() {
        return aula;
    }

    public void setAula(Aula aula) {
        this.aula = aula;
    }
    
    
    
}
