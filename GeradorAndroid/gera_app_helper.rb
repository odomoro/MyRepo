##
# @Odone
#
# programa que gera a classe helper do dicionário,
# baseado nos DAOs exitentes
#
# recebe o nome da aplicaçao

class GeraAppHelper

  def executa( nome_app)

    require 'fileutils'

    #nome_app = ARGV[1].strip

    #
    # pega os arquivos DAO

    nome_pacote = "br.inf.intelidata.#{nome_app}"

    arquivos = Dir.glob("src/#{nome_pacote}/*DAO.java")

    java = File.new( "src/#{nome_pacote}/DicHelper.java", "w+")
    java.puts('package ' + nome_pacote + ';')
    java.puts('import android.content.Context;')
    java.puts('import android.database.sqlite.SQLiteDatabase;')
    java.puts('import android.database.sqlite.SQLiteOpenHelper;')

    sql_create = Array.new
    sql_delete = Array.new

    arquivos.each do |arquivo_base_name|

      classe = arquivo_base_name.split("/")
      nome_arquivo = classe[-1]
      classe = nome_arquivo.split('DAO')
      nome_tabela = classe[0].strip.downcase
      nome_prefix = nome_tabela.capitalize
      nome_dicionario = nome_prefix + 'DIC'

      sql_create.push(  "db.execSQL(#{nome_dicionario}.SQL_CRIA_TABELA);" )
      sql_delete.push(  "db.execSQL(#{nome_dicionario}.SQL_APAGA_TABELA);" )

      java.puts("import br.inf.intelidata.#{nome_app}.#{nome_dicionario};")

    end
    java.puts('public class DicHelper extends SQLiteOpenHelper{')
    java.puts('    public static final int DATABASE_VERSION = 1;')
    java.puts('    public static final String DATABASE_NAME = "' + nome_app + '";')
    java.puts('    public DbDicionarioHelper(Context context) {')
    java.puts('        super(context, DATABASE_NAME, null, DATABASE_VERSION);')
    java.puts('    }')
    #
    java.puts('    public void onCreate(SQLiteDatabase db) {')
    while linha=sql_create.pop do
      java.puts('        ' + linha )
    end
    java.puts('    }')
    #
    java.puts('    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {')
    java.puts('        if (newVersion > oldVersion) {')
    while linha=sql_delete.pop do
      java.puts('           ' + linha )
    end
    java.puts('        }')
    java.puts('        onCreate(db);')
    java.puts('    }')
    java.puts('}')

  end

end