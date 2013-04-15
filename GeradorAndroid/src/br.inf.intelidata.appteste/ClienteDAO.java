package br.inf.intelidata.appteste;
import java.util.Map;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;
//
public abstract class ClienteDAO extends ClienteDIC {
    //
    private SQLiteDatabase db = null;
    private DicHelper dbHelper= null;
    //
    public ClienteDAO(Context context) {
        dbHelper = new DicHelper(context);
    }
 
    //
    //
    public long incluir(Map<String,String> elemento) throws SQLException{
        ContentValues cv = new ContentValues();
        for (Map.Entry<String, String> entry : elemento.entrySet()) {
            cv.put( entry.getKey(), entry.getValue());
        }
        this.db = dbHelper.getWritableDatabase();
        long retorno = db.insert( ClienteDIC.TABELA_NOME, null, cv);
        db.close();
        Log.i( "APP", "Registro criado com sucesso.");
        return retorno;
    }
 
    //
    //
    public int alterar(Map<String,String> elemento, String rowid) throws SQLException{
        ContentValues cv = new ContentValues();
        for (Map.Entry<String, String> entry : elemento.entrySet()) {
            cv.put( entry.getKey(), entry.getValue());
        }
        this.db = dbHelper.getWritableDatabase();
        int retorno = db.update(ClienteDIC.TABELA_NOME, cv, ClienteDIC.ID + "=?", new String[]{rowid.toString()});
        db.close();
        Log.i("APP", "Registro atualizado com sucesso.");
        return retorno;
    }
 
    //
    //
    public int excluir(String rowid)throws SQLException{
        this.db = dbHelper.getWritableDatabase();
        int retorno = db.delete( ClienteDIC.TABELA_NOME, ClienteDIC.ID + "=?", new String[]{rowid.toString()});
        db.close();
        Log.i( "APP", "Registro excluido com sucesso.");
        return retorno;
    }
 
    //
    //
    public Cursor listaTodos(String query) {
        String value = "%" + query + "%";
        this.db = dbHelper.getReadableDatabase();
        if (query.isEmpty()) {
            return db.query(ClienteDIC.TABELA_NOME,
            new String[] {ClienteDIC.ID,
			ClienteDIC.CODIGO,
			ClienteDIC.NOME,
			ClienteDIC.CNPJ,
			ClienteDIC.EMAIL},
            null, null, null, null, null, null);
        } else {
            return db.query(ClienteDIC.TABELA_NOME,
            new String[] {ClienteDIC.ID,
			ClienteDIC.CODIGO,
			ClienteDIC.NOME,
			ClienteDIC.CNPJ,
			ClienteDIC.EMAIL},
            ClienteDIC.SQL_QUERY,
            null, null, null, null, null);
        }
    }
 
    //
    //
    public Cursor listaUm( String rowid) {
        this.db = dbHelper.getReadableDatabase();
        return db.query(ClienteDIC.TABELA_NOME,
        new String[] { ClienteDIC.ID,
			ClienteDIC.CODIGO,
			ClienteDIC.NOME,
			ClienteDIC.CNPJ,
			ClienteDIC.EMAIL},
        ClienteDIC.ID + "=?",
        new String[] {rowid},
        null, null, null, null);
    }
}
