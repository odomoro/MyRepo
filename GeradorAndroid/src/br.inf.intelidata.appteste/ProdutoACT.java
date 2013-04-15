package br.inf.intelidata.appteste;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
public class ProdutoACT extends Activity {
    private ProdutoDAO mDbHelper;
    private int mModo;
    private String mID;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.produto_crud);
        mDbHelper = new ProdutoDAO(this);
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
            codigo_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ProdutoDIC.CODIGO)));

            final EditText nome_edit_text_tmp = (EditText) findViewById(R.id.nome_edit_text);
            nome_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ProdutoDIC.NOME)));

            final EditText modelo_edit_text_tmp = (EditText) findViewById(R.id.modelo_edit_text);
            modelo_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ProdutoDIC.MODELO)));

            final EditText preco_edit_text_tmp = (EditText) findViewById(R.id.preco_edit_text);
            preco_edit_text_tmp.setText( mCursor.getString( mCursor.getColumnIndex(ProdutoDIC.PRECO)));

        }
    }
 
    public void salvarOnClick(View button) {
        Map<String,String> elemento = new HashMap<String,String>();

        final EditText codigo_edit_text_tmp = (EditText) findViewById(R.id.codigo_edit_text);
        elemento.put( ProdutoDIC.CODIGO, (String) codigo_edit_text_tmp.getText().toString());

        final EditText nome_edit_text_tmp = (EditText) findViewById(R.id.nome_edit_text);
        elemento.put( ProdutoDIC.NOME, (String) nome_edit_text_tmp.getText().toString());

        final EditText modelo_edit_text_tmp = (EditText) findViewById(R.id.modelo_edit_text);
        elemento.put( ProdutoDIC.MODELO, (String) modelo_edit_text_tmp.getText().toString());

        final EditText preco_edit_text_tmp = (EditText) findViewById(R.id.preco_edit_text);
        elemento.put( ProdutoDIC.PRECO, (String) preco_edit_text_tmp.getText().toString());

        if (mModo == 0)
            mDbHelper.incluir(elemento);
        else;
            mDbHelper.alterar(elemento, mID);

        finish();
    }
}
