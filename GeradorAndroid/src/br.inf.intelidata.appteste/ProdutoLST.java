package br.inf.intelidata.appteste;
import android.app.ListActivity;
import android.app.SearchManager;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;
import br.inf.intelidata.appteste.ProdutoDIC;

public class ProdutoLST extends ListActivity {

    private ProdutoDAO mDbHelper;
    SimpleCursorAdapter mAdapter;
    Cursor mCursor;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.produto_lista);
        mDbHelper = new ProdutoDAO(this);
        ListView lv = (ListView) findViewById(android.R.id.list);
        registerForContextMenu(lv);
        handleIntent(getIntent());
    }
    @Override
    protected void onNewIntent(Intent intent) {
        setIntent(intent);
        handleIntent(intent);
    }

    private void handleIntent(Intent intent ) {
        if (Intent.ACTION_SEARCH.equals(intent.getAction())) {
            // handles a search query
            String query = intent.getStringExtra(SearchManager.QUERY);
            fillData(query);
        }
        else {
            fillData("");
        }
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        menu.setHeaderTitle(getString(R.string.menu_alterar_apagar));
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_alterar_apagar, menu);
    }

    @Override
    public boolean onContextItemSelected(MenuItem item) {
        final int rowId = mCursor.getInt( mCursor.getColumnIndex(ProdutoDIC.ID));
        switch (item.getItemId()) {
        case R.id.menu_alterar:
            alterar(Integer.toString(rowId));
            return true;
        case R.id.menu_apagar:
            apagar(Integer.toString(rowId));
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        boolean result = super.onCreateOptionsMenu(menu);
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_incluir, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
        case R.id.menu_incluir:
            incluir();
            return true;
        case R.id.search:
            onSearchRequested();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private void incluir() {
        // intent para chamar a atividade com a tela
        Intent intent = new Intent(this, ProdutoACT.class);
        intent.putExtra("rowID", "");
        startActivity(intent);
    }

    private void alterar(String rowId) {
        Intent intent = new Intent(this, ProdutoACT.class);
        intent.putExtra("rowID", rowId);
        startActivity(intent);
    }

    private void apagar(String rowId) {
        mDbHelper.excluir(rowId);
        fillData("");
    }

    private void fillData(String query) {
        mCursor = mDbHelper.listaTodos(query);
        startManagingCursor(c);
        String[] from = new String[] {ProdutoDAO.COLUNA_1, ProdutoDAO.COLUNA_2};
        int[] to = new int[] { R.id.produto_coluna_1, R.id.produto_coluna_2 };
        SimpleCursorAdapter cursor =
              new SimpleCursorAdapter( this, R.layout.produto_lista_linha, mCursor, from, to, 0 );
        setListAdapter(cursor);
    }
}
