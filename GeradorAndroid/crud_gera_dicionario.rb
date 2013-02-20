##
# @Odone
#
# programa que gera a classe de dicionario
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

#
# campos[0] = Nome do campo
# campos[1] = Tipo do campo para efeitos de SQLite3
#             ["S" => "TIPO_TEXTO", "I" => "TIPO_INTEIRO", "N" => "TIPO_NULL", "R" => "TIPO_REAL", "B" => "TIPO_BLOB"]
#

nome_tipos = Hash["S" => "TIPO_TEXTO", "I" => "TIPO_INTEIRO", "N" => "TIPO_NULL", "R" => "TIPO_REAL", "B" => "TIPO_BLOB"]

classe = arquivo_base_name.split(".")
nome_tabela = classe[0].strip.downcase
nome_classe = nome_tabela.capitalize + "Dic"
nome_pacote = "br.inf.intelidata." + nome_tabela

java = File.new( "src_" + nome_pacote + "_" + nome_classe + ".java", "w+")
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
java.puts('    private static final String VIRGULA = ",";')
java.puts('    //')
java.puts('    public static final String TABELA_NOME = "' + nome_tabela + '";')
java.puts('    public static final String ID = "_id";')
java.puts('    //')

sql_insert =  '    ID  + " integer primary key autoincrement" + '

while linha = arquivo_base.gets do

  campos = linha.split(",")
  if campos[0].start_with?("#")
    next
  end

  nome_campo =  campos[0].strip
  tipo_campo =  campos[1].strip.upcase

  sql_insert += "VIRGULA + \n\t\t#{nome_campo.upcase} + #{nome_tipos[tipo_campo ]} + "

  java.puts('    public static final String ' + nome_campo.upcase + '= "' + nome_campo.downcase + '";')

end
java.puts('    //')
java.puts('    public static final String SQL_CRIA_' + nome_tabela.upcase + ' = "CREATE TABLE " + TABELA_NOME + " = (" + ')
java.puts('    ' + sql_insert + '" )";' )
java.puts('    //')
java.puts('    public static final String SQL_APAGA_'  + nome_tabela.upcase + ' = "DROP TABLE IF EXISTS " + TABELA_NOME;')
java.puts('    //')
java.puts('}')
java.close
exit
#
######
