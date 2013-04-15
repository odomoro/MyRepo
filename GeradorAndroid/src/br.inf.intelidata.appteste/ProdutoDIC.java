package br.inf.intelidata.appteste;
import android.provider.BaseColumns;
//
public abstract class ProdutoDIC implements BaseColumns {
    //
    public void ProdutoDIC(){}
    //
    private static final String TIPO_TEXTO = " text";
    private static final String TIPO_INTEIRO = " integer";
    private static final String TIPO_NULL = " null";
    private static final String TIPO_REAL = " real";
    private static final String TIPO_BLOB = " blob";
    private static final String OR = " OR ";
    private static final String LIKE = " LIKE value ";
    private static final String VIRGULA = ",";
    //
    public static final String TABELA_NOME = "produto";
    public static final String ID = "_id";
    //
    public static final String CODIGO= "codigo";
    public static final String COLUNA_1 = "codigo";
    public static final String NOME= "nome";
    public static final String COLUNA_2 = "nome";
    public static final String MODELO= "modelo";
    public static final String PRECO= "preco";
    //
    public static final String SQL_QUERY = CODIGO + LIKE + OR + NOME + LIKE + OR + MODELO + LIKE + OR + PRECO + LIKE;
    //
    public static final String SQL_CRIA_TABELA = "CREATE TABLE " + TABELA_NOME + " (" + 
        ID  + " integer primary key autoincrement" + VIRGULA + 
		CODIGO + TIPO_TEXTO + VIRGULA + 
		NOME + TIPO_TEXTO + VIRGULA + 
		MODELO + TIPO_TEXTO + VIRGULA + 
		PRECO + TIPO_REAL + " )";
    //
    public static final String SQL_APAGA_TABELA = "DROP TABLE IF EXISTS " + TABELA_NOME;
    //
}
