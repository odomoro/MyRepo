##
# @Odone
#
# programa que gera a classe dao
#
# pega e testa os argumentos
arquivo_base_name = ARGV[0]
if arquivo_base_name.nil?
  puts "Arquivo nao existe"
  exit
end

if File.exist?(arquivo_base_name)
  # abre o arquivo para leitura
  arquivo_base = File.open(arquivo_base_name)
else
  puts "Arquivo nao existe"
  exit
end

classe = arquivo_base_name.split(".")
nome_tabela = classe[0].strip.downcase
nome_prefix = nome_tabela.capitalize
nome_dicionario = nome_prefix + "Dic"
nome_classe = nome_prefix + "DAO"
nome_pacote = "br.inf.intelidata." + nome_tabela


#
# leitura do arquivo base
# campos[0] = Nome do campo
#
lista_campos = ""
while linha = arquivo_base.gets do
  campos = linha.split(",")
  if campos[0].start_with?("#")
    next
  end
  if lista_campos == ""
      lista_campos +=  "#{nome_dicionario}.#{campos[0].strip.upcase}"
  else
      lista_campos +=  ",\n\t\t#{nome_dicionario}.#{campos[0].strip.upcase}"
  end
end


java = File.new( "src_" + nome_pacote + "_" + nome_classe + ".java", "w+")
java.puts('package ' + nome_pacote + ';')
java.puts('import java.util.Map;')
java.puts('import android.content.ContentValues;')
java.puts('import android.content.Context;')
java.puts('import android.database.Cursor;')
java.puts('import android.database.SQLException;')
java.puts('import android.database.sqlite.SQLiteDatabase;')
java.puts('import android.util.Log;')
java.puts('//')
java.puts('public abstract class ' + nome_classe + ' extends ' + nome_dicionario +  ' {')
java.puts('    //')
java.puts('    private SQLiteDatabase db = null;')
java.puts('    private DbDicionarioHelper dbHelper= null;')
java.puts('    //')
java.puts('    public ' + nome_classe + '(Context context) {')
java.puts('        dbHelper = new DicHelper(context);')
java.puts('    }')
java.puts(' ')
java.puts('    //')
java.puts('    //')
java.puts('    public long incluir(Map<String,String> elemento) throws SQLException{')
java.puts('        ContentValues cv = new ContentValues();')
java.puts('        for (Map.Entry<String, String> entry : elemento.entrySet()) {')
java.puts('            cv.put( entry.getKey(), entry.getValue());')
java.puts('        }')
java.puts('        this.db = dbHelper.getWritableDatabase();')
java.puts('        long retorno = db.insert( ' + nome_dicionario + '.TABELA_NOME, null, cv);')
java.puts('        db.close();')
java.puts('        Log.i( "APP", "Registro criado com sucesso.");')
java.puts('        return retorno;')
java.puts('    }')
java.puts(' ')
java.puts('    //')
java.puts('    //')
java.puts('    public int alterar(Map<String,String> elemento) throws SQLException{')
java.puts('        String rowid = "";')
java.puts('        ContentValues cv = new ContentValues();')
java.puts('        for (Map.Entry<String, String> entry : elemento.entrySet()) {')
java.puts('            if (entry.getKey()=="_id") {')
java.puts('                rowid = entry.getValue();')
java.puts('            }')
java.puts('            cv.put( entry.getKey(), entry.getValue());')
java.puts('        }')
java.puts('        this.db = dbHelper.getWritableDatabase();')
java.puts('        int retorno = db.update(' + nome_dicionario + '.TABELA_NOME, cv, "id = ?", new String[]{ rowid.toString() });')
java.puts('        db.close();')
java.puts('        Log.i("APP", "Registro atualizado com sucesso.");')
java.puts('        return retorno;')
java.puts('    }')
java.puts(' ')
java.puts('    //')
java.puts('    //')
java.puts('    public int excluir(String rowid)throws SQLException{')
java.puts('        this.db = dbHelper.getWritableDatabase();')
java.puts('        int retorno = db.delete( ' + nome_dicionario + '.TABELA_NOME, "id = ?", new String[]{ rowid.toString() });')
java.puts('        db.close();')
java.puts('        Log.i( "APP", "Registro excluido com sucesso.");')
java.puts('        return retorno;')
java.puts('    }')
java.puts(' ')
java.puts('    //')
java.puts('    //')
java.puts('    public Cursor listaTodos() {')
java.puts('        this.db = dbHelper.getReadableDatabase();')
java.puts('        return db.query('  + nome_dicionario + '.TABELA_NOME,')
java.puts('        new String[] { ' + lista_campos + '},')
java.puts('        null, null, null, null, null);')
java.puts('    }')
java.puts(' ')
java.puts('    //')
java.puts('    //')
java.puts('    public Cursor listaUm( String rowid) {')
java.puts('        this.db = dbHelper.getReadableDatabase();')
java.puts('        return db.query('  + nome_dicionario + '.TABELA_NOME,')
java.puts('        new String[] { ' + lista_campos + '},')
java.puts('        ' + nome_dicionario + '.ID + "=" + rowid,')
java.puts('        null, null, null, null);')
java.puts('    }')
java.puts('}')
java.close
exit
#
######
