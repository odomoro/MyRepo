##
# @Odone
#
# programa que gera a classe helper do dicionário,
# baseado nos DAOs exitentes
#
# recebe o nome da aplicaçao

nome_arquivo_base = ARGV[0].strip
nome_app = ARGV[1].strip

classe = nome_arquivo_base.split(".")
nome_tabela = classe[0].strip.downcase
nome_prefix = nome_tabela.capitalize
nome_dic    = "#{nome_prefix}Dic"
nome_dao    = "#{nome_prefix}DAO"
nome_classe = "#{nome_prefix}Activity"
nome_lista  = "#{nome_prefix}Lista"
nome_pacote = "br.inf.intelidata.#{nome_app}"

java = File.new( "src/#{nome_pacote}/#{nome_lista}.java", "w+")
java.puts('package ' + nome_pacote + ';')
java.puts('import java.util.HashMap;')
java.puts('import java.util.Map;')
java.puts('import android.app.ListActivity;')
java.puts('import android.database.Cursor;')
java.puts('import android.os.Bundle;')
java.puts('import android.view.Menu;')
java.puts('import android.view.MenuItem;')
java.puts('import android.widget.SimpleCursorAdapter;')
java.puts("import #{nome_pacote}.#{nome_dic};")
java.puts('')
java.puts("public class #{nome_lista} extends ListActivity {")
java.puts('')
java.puts("    private #{nome_dao} mDbHelper;")
java.puts('    SimpleCursorAdapter mAdapter;')
java.puts('')
java.puts('    @Override')
java.puts('    public void onCreate(Bundle savedInstanceState) {')
java.puts('        super.onCreate(savedInstanceState);')
java.puts("        setContentView(R.layout.#{nome_tabela}_lista);")
java.puts("        mDbHelper = new #{nome_dao}(this);")
java.puts('        mDbHelper.open();')
java.puts('        fillData();')
java.puts('    }')
java.puts('')
java.puts('    @Override')
java.puts('    public boolean onCreateOptionsMenu(Menu menu) {')
java.puts('        boolean result = super.onCreateOptionsMenu(menu);')
java.puts('        MenuInflater inflater = getMenuInflater();')
java.puts('        inflater.inflate(R.menu.menu, menu);')
java.puts('        return true;')
java.puts('    }')
java.puts('')
java.puts('    @Override')
java.puts('    public boolean onOptionsItemSelected(MenuItem item) {')
java.puts('        switch (item.getItemId()) {')
java.puts('        case R.id.menu_incluir:')
java.puts('            incluir();')
java.puts('            return true;')
java.puts('        case R.id.menu_alterar:')
java.puts('            alterar();')
java.puts('            return true;')
java.puts('        case R.id.menu_apagar:')
java.puts('            apagar();')
java.puts('            return true;')
java.puts('        }')
java.puts('        return super.onOptionsItemSelected(item);')
java.puts('    }')
java.puts('')
java.puts('    private void incluir() {')
java.puts('        // intent para chamar a atividade com a tela')
java.puts("        Intent intent = new Intent(this, #{nome_classe}.class);")
java.puts('        startActivity(intent);')
java.puts('    }')
java.puts('')
java.puts('    private void alterar() {')
java.puts("        Intent intent = new Intent(this, #{nome_classe}.class);")
java.puts('        // pegar o id do registro selecionado da lista e passar no intent')
java.puts('        // intent.putExtra(EXTRA_MESSAGE, message);')
java.puts('        startActivity(intent);')
java.puts('    }')
java.puts('')
java.puts('    private void apagar() {')
java.puts("        Intent intent = new Intent(this, #{nome_classe}.class);")
java.puts('        // pegar o id do registro selecionado da lista e chamar o metodo de exclusao do helper')
java.puts('        // ou fazer uma tela para exclusao e chamar ')
java.puts('        // intent.putExtra(EXTRA_MESSAGE, message);')
java.puts('    }')
java.puts('')

#TODO decidir como determinar quais os campos irao compor a lista
java.puts('    private void fillData() {')
java.puts('        Cursor c = mDbHelper.listaTodos();')
java.puts('        startManagingCursor(c);')
java.puts('        String[] from = new String[] {  DbClientes.COLUNA_CODIGO, DbClientes.COLUNA_NOME  };')
java.puts('        int[] to = new int[] { R.id.coluna_1, R.id.coluna_2 };')
java.puts('        SimpleCursorAdapter cursor =')
java.puts("              new SimpleCursorAdapter( this, R.layout.#{nome_tabela}_lista_linha, c, from, to, 0 );")
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
java.puts('    <ListView android:id="@id/android:list"')
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
java.puts('        android:id="@+id/coluna_1"')
java.puts('        xmlns:android="http://schemas.android.com/apk/res/android"')
java.puts('        android:layout_width="wrap_content"')
java.puts('        android:layout_height="wrap_content"/>')
java.puts('')
java.puts('    <TextView')
java.puts('        android:id="@+id/coluna_2"')
java.puts('        xmlns:android="http://schemas.android.com/apk/res/android"')
java.puts('        android:layout_width="wrap_content"')
java.puts('        android:layout_height="wrap_content"/>')
java.puts('')
java.puts('</LinearLayout>')
java.close
##