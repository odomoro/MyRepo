package br.inf.intelidata.appteste;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import br.inf.intelidata.appteste.ClienteDIC;
import br.inf.intelidata.appteste.ProdutoDIC;
public class DicHelper extends SQLiteOpenHelper{
    public static final int DATABASE_VERSION = 1;
    public static final String DATABASE_NAME = "appteste";
    public DbDicionarioHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(ProdutoDIC.SQL_CRIA_TABELA);
        db.execSQL(ClienteDIC.SQL_CRIA_TABELA);
    }
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        if (newVersion > oldVersion) {
           db.execSQL(ProdutoDIC.SQL_APAGA_TABELA);
           db.execSQL(ClienteDIC.SQL_APAGA_TABELA);
        }
        onCreate(db);
    }
}
