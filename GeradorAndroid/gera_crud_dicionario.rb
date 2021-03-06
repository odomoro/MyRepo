##
# @Odone
#
# programa que gera a classe de dicionario
#
# pega e testa os argumentos

class GeraCrudDicionario

  def executa(arquivo_base_name, nome_app)

    if File.exist?(arquivo_base_name)
      # abre o arquivo para leitura
      arquivo_base = File.open(arquivo_base_name)
    else
      puts "Arquivo nao existe"
      exit
    end

    #
    # campos[0] = Nome do campo
    # campos[1] = Tipo do campo para efeitos de SQLite3
    #             ["S" => "TIPO_TEXTO", "I" => "TIPO_INTEIRO", "N" => "TIPO_NULL", "R" => "TIPO_REAL", "B" => "TIPO_BLOB"]
    # campos[7] = #coluna da lista
    #

    nome_tipos = Hash["S" => "TIPO_TEXTO", "I" => "TIPO_INTEIRO", "N" => "TIPO_NULL", "R" => "TIPO_REAL", "B" => "TIPO_BLOB"]

    classe = arquivo_base_name.split(".")
    nome_tabela = classe[0].strip.downcase
    nome_classe = nome_tabela.capitalize + 'DIC'
    nome_pacote = "br.inf.intelidata." + nome_app

    java = File.new( "src/#{nome_pacote}/#{nome_classe}.java", "w+")
    java.puts('package ' + nome_pacote + ';')
    java.puts('import android.provider.BaseColumns;')
    java.puts('//')
    java.puts('public abstract class ' + nome_classe + ' implements BaseColumns {')
    java.puts('    //')
    java.puts('    public void ' + nome_classe + '(){}')
    java.puts('    //')
    java.puts('    private static final String TIPO_TEXTO = " text";')
    java.puts('    private static final String TIPO_INTEIRO = " integer";')
    java.puts('    private static final String TIPO_NULL = " null";')
    java.puts('    private static final String TIPO_REAL = " real";')
    java.puts('    private static final String TIPO_BLOB = " blob";')
    java.puts('    private static final String OR = " OR ";')
    java.puts('    private static final String LIKE = " LIKE value ";')
    java.puts('    private static final String VIRGULA = ",";')
    java.puts('    //')
    java.puts('    public static final String TABELA_NOME = "' + nome_tabela + '";')
    java.puts('    public static final String ID = "_id";')
    java.puts('    //')

    sql_insert = '    ID  + " integer primary key autoincrement" + '
    sql_query  = ''

    while linha = arquivo_base.gets do

      if linha.start_with?("#")
        next
      end

      campos = linha.split(",")
      nome_campo =  campos[0].strip
      tipo_campo =  campos[1].strip.upcase

      if tipo_campo == ''
         next
      end

      sql_insert += "VIRGULA + \n\t\t#{nome_campo.upcase} + #{nome_tipos[tipo_campo ]} + "
      if sql_query == ''
         sql_query  = "#{nome_campo.upcase} + LIKE"
      else
         sql_query += " + OR + #{nome_campo.upcase} + LIKE"
      end

      java.puts('    public static final String ' + nome_campo.upcase + '= "' + nome_campo.downcase + '";')
      #
      #coluna da lista
      #
      if !campos[7].nil?
        java.puts('    public static final String COLUNA_' + campos[7].strip + ' = "' + nome_campo.downcase + '";')
      end

    end
    #
    java.puts('    //')
    java.puts("    public static final String SQL_QUERY = #{sql_query};")
    java.puts('    //')
    java.puts('    public static final String SQL_CRIA_TABELA = "CREATE TABLE " + TABELA_NOME + " (" + ')
    java.puts('    ' + sql_insert + '" )";' )
    java.puts('    //')
    java.puts('    public static final String SQL_APAGA_TABELA = "DROP TABLE IF EXISTS " + TABELA_NOME;')
    java.puts('    //')
    java.puts('}')
    java.close
    #
  end
end