##
# @Odone
#
# programa que gera a classe helper do dicionário,
# baseado nos DAOs exitentes
#
#
class GeraCrudLista

  def executa(nome_arquivo_base, nome_app)

    classe = nome_arquivo_base.split(".")
    nome_tabela = classe[0].strip.downcase
    nome_prefix = nome_tabela.capitalize
    nome_dic    = "#{nome_prefix}DIC"
    nome_dao    = "#{nome_prefix}DAO"
    nome_classe = "#{nome_prefix}ACT"
    nome_lista  = "#{nome_prefix}LST"
    nome_pacote = "br.inf.intelidata.#{nome_app}"

    java = File.new( "src/#{nome_pacote}/#{nome_lista}.java", "w+")
    java.puts('package ' + nome_pacote + ';')

    java.puts('import android.app.ListActivity;')
    java.puts('import android.app.SearchManager;')
    java.puts('import android.content.Intent;')
    java.puts('import android.database.Cursor;')
    java.puts('import android.os.Bundle;')
    java.puts('import android.view.ContextMenu;')
    java.puts('import android.view.ContextMenu.ContextMenuInfo;')
    java.puts('import android.view.Menu;')
    java.puts('import android.view.MenuInflater;')
    java.puts('import android.view.MenuItem;')
    java.puts('import android.view.View;')
    java.puts('import android.widget.ListView;')
    java.puts('import android.widget.SimpleCursorAdapter;')
    java.puts("import #{nome_pacote}.#{nome_dic};")
    java.puts('')
    java.puts("public class #{nome_lista} extends ListActivity {")
    java.puts('')
    java.puts("    private #{nome_dao} mDbHelper;")
    java.puts('    SimpleCursorAdapter mAdapter;')
    java.puts('    Cursor mCursor;')
    java.puts('')
    java.puts('    @Override')
    java.puts('    public void onCreate(Bundle savedInstanceState) {')
    java.puts('        super.onCreate(savedInstanceState);')
    java.puts("        setContentView(R.layout.#{nome_tabela}_lista);")
    java.puts("        mDbHelper = new #{nome_dao}(this);")
    java.puts('        ListView lv = (ListView) findViewById(android.R.id.list);')
    java.puts('        registerForContextMenu(lv);')
    java.puts('        handleIntent(getIntent());')
    java.puts('    }')

    java.puts('    @Override')
    java.puts('    protected void onNewIntent(Intent intent) {')
    java.puts('        setIntent(intent);')
    java.puts('        handleIntent(intent);')
    java.puts('    }')
    java.puts('')
    java.puts('    private void handleIntent(Intent intent ) {')
    java.puts('        if (Intent.ACTION_SEARCH.equals(intent.getAction())) {')
    java.puts('            // handles a search query')
    java.puts('            String query = intent.getStringExtra(SearchManager.QUERY);')
    java.puts('            fillData(query);')
    java.puts('        }')
    java.puts('        else {')
    java.puts('            fillData("");')
    java.puts('        }')
    java.puts('    }')
    java.puts('')
    java.puts('    @Override')
    java.puts('    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenuInfo menuInfo) {')
    java.puts('        super.onCreateContextMenu(menu, v, menuInfo);')
    java.puts('        menu.setHeaderTitle(getString(R.string.menu_alterar_apagar));')
    java.puts('        MenuInflater inflater = getMenuInflater();')
    java.puts('        inflater.inflate(R.menu.menu_alterar_apagar, menu);')
    java.puts('    }')
    java.puts('')
    java.puts('    @Override')
    java.puts('    public boolean onContextItemSelected(MenuItem item) {')
    java.puts("        final int rowId = mCursor.getInt( mCursor.getColumnIndex(#{nome_dic}.ID));")
    java.puts('        switch (item.getItemId()) {')
    java.puts('        case R.id.menu_alterar:')
    java.puts('            alterar(Integer.toString(rowId));')
    java.puts('            return true;')
    java.puts('        case R.id.menu_apagar:')
    java.puts('            apagar(Integer.toString(rowId));')
    java.puts('            return true;')
    java.puts('        }')
    java.puts('        return super.onOptionsItemSelected(item);')
    java.puts('    }')
    java.puts('')
    java.puts('    @Override')
    java.puts('    public boolean onCreateOptionsMenu(Menu menu) {')
    java.puts('        boolean result = super.onCreateOptionsMenu(menu);')
    java.puts('        MenuInflater inflater = getMenuInflater();')
    java.puts('        inflater.inflate(R.menu.menu_incluir, menu);')
    java.puts('        return true;')
    java.puts('    }')
    java.puts('')
    java.puts('    @Override')
    java.puts('    public boolean onOptionsItemSelected(MenuItem item) {')
    java.puts('        switch (item.getItemId()) {')
    java.puts('        case R.id.menu_incluir:')
    java.puts('            incluir();')
    java.puts('            return true;')
    java.puts('        case R.id.search:')
    java.puts('            onSearchRequested();')
    java.puts('            return true;')
    java.puts('        }')
    java.puts('        return super.onOptionsItemSelected(item);')
    java.puts('    }')
    java.puts('')
    java.puts('    private void incluir() {')
    java.puts('        // intent para chamar a atividade com a tela')
    java.puts("        Intent intent = new Intent(this, #{nome_classe}.class);")
    java.puts('        intent.putExtra("rowID", "");')
    java.puts('        startActivity(intent);')
    java.puts('    }')
    java.puts('')
    java.puts('    private void alterar(String rowId) {')
    java.puts("        Intent intent = new Intent(this, #{nome_classe}.class);")
    java.puts('        intent.putExtra("rowID", rowId);')
    java.puts('        startActivity(intent);')
    java.puts('    }')
    java.puts('')
    java.puts('    private void apagar(String rowId) {')
    java.puts('        mDbHelper.excluir(rowId);')
    java.puts('        fillData("");')
    java.puts('    }')
    java.puts('')
    java.puts('    private void fillData(String query) {')
    java.puts('        mCursor = mDbHelper.listaTodos(query);')
    java.puts('        startManagingCursor(c);')
    java.puts("        String[] from = new String[] {#{nome_dao}.COLUNA_1, #{nome_dao}.COLUNA_2};")
    java.puts("        int[] to = new int[] { R.id.#{nome_tabela}_coluna_1, R.id.#{nome_tabela}_coluna_2 };")
    java.puts('        SimpleCursorAdapter cursor =')
    java.puts("              new SimpleCursorAdapter( this, R.layout.#{nome_tabela}_lista_linha, mCursor, from, to, 0 );")
    java.puts('        setListAdapter(cursor);')
    java.puts('    }')
    java.puts('}')
    java.close
    #
    # layout da lista
    #
    java = File.new( "res/layout/#{nome_tabela}_lista.xml", "w+")
    java.puts('<?xml version="1.0" encoding="utf-8"?>')
    java.puts('<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"')
    java.puts('    android:layout_width="wrap_content"')
    java.puts('    android:layout_height="wrap_content">')
    java.puts('')
    java.puts('    <ListView android:id="@android:id/list"')
    java.puts('        android:layout_width="wrap_content"')
    java.puts('        android:layout_height="wrap_content"/>')
    java.puts('')
    java.puts('    <TextView android:id="@id/android:empty"')
    java.puts('        android:layout_width="wrap_content"')
    java.puts('        android:layout_height="wrap_content"')
    java.puts('        android:text="@string/lista_vazia"/>')
    java.puts('')
    java.puts('</LinearLayout>')
    java.close
    #
    # layout da linha
    #
    java = File.new( "res/layout/#{nome_tabela}_lista_linha.xml", "w+")
    java.puts('<?xml version="1.0" encoding="utf-8"?>')
    java.puts('<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"')
    java.puts('    android:layout_width="wrap_content"')
    java.puts('    android:layout_height="wrap_content">')
    java.puts('')
    java.puts('    <TextView')
    java.puts('        android:id="@+id/' + nome_tabela + '_coluna_1"')
    java.puts('        android:layout_width="90dp"')
    java.puts('        android:layout_height="wrap_content"/>')
    java.puts('')
    java.puts('    <TextView')
    java.puts('        android:id="@+id/' + nome_tabela + '_coluna_2"')
    java.puts('        android:layout_width="180dp"')
    java.puts('        android:layout_height="wrap_content"/>')
    java.puts('')
    java.puts('</LinearLayout>')
    java.close
    ##
  end
end