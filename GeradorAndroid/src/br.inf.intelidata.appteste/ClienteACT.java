package br.inf.intelidata.appteste;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
public class ClienteACT extends Activity {
    private ClienteDAO mDbHelper;
    private int mModo;
    private String mID;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.cliente_crud);
        mDbHelper = new ClienteDAO(this);
        Intent intent = getIntent();
        mID = intent.getStringExtra("rowID");

        mModo = 0; // inserir
        if ( !mID.isEmpty()) {
            mModo = 1; //alterar
            final Cursor mCursor = mDbHelper.listaUm(mID);
            try
            {
                mCursor.moveToFirst();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            final EditText codigo_edit_text_tmp = (EditText) findViewById(R.id.codigo_edit_text);
            codigo_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ClienteDIC.CODIGO)));

            final EditText nome_edit_text_tmp = (EditText) findViewById(R.id.nome_edit_text);
            nome_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ClienteDIC.NOME)));

            final EditText cnpj_edit_text_tmp = (EditText) findViewById(R.id.cnpj_edit_text);
            cnpj_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ClienteDIC.CNPJ)));

            final EditText email_edit_text_tmp = (EditText) findViewById(R.id.email_edit_text);
            email_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ClienteDIC.EMAIL)));

        }
    }
 
    public void salvarOnClick(View button) {
        Map<String,String> elemento = new HashMap<String,String>();

        final EditText codigo_edit_text_tmp = (EditText) findViewById(R.id.codigo_edit_text);
        elemento.put( ClienteDIC.CODIGO, (String) codigo_edit_text_tmp.getText().toString());

        final EditText nome_edit_text_tmp = (EditText) findViewById(R.id.nome_edit_text);
        elemento.put( ClienteDIC.NOME, (String) nome_edit_text_tmp.getText().toString());

        final EditText cnpj_edit_text_tmp = (EditText) findViewById(R.id.cnpj_edit_text);
        elemento.put( ClienteDIC.CNPJ, (String) cnpj_edit_text_tmp.getText().toString());

        final EditText email_edit_text_tmp = (EditText) findViewById(R.id.email_edit_text);
        elemento.put( ClienteDIC.EMAIL, (String) email_edit_text_tmp.getText().toString());

        if (mModo == 0)
            mDbHelper.incluir(elemento);
        else;
            mDbHelper.alterar(elemento, mID);

        finish();
    }
}
