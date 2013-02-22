##
# @Odone
#
# programa que gera a classe helper do dicionário,
# baseado nos DAOs exitentes
#
# recebe o nome da aplicaçao

require 'fileutils'
require 'nokogiri'

nome_arquivo_base = ARGV[0].strip
nome_app = ARGV[1].strip

classe = nome_arquivo_base.split(".")
nome_tabela = classe[0].strip.downcase
nome_prefix = nome_tabela.capitalize
nome_dic    = nome_prefix + "Dic"
nome_dao    = nome_prefix + "DAO"
nome_classe = nome_prefix + "Activity"
nome_pacote = "br.inf.intelidata." + nome_app
nome_layout = "res/layout/#{nome_tabela}_crud"
nome_xml    = "#{nome_layout}.xml"

java = File.new( "src/#{nome_pacote}/#{nome_classe}.java", "w+")
java.puts('package ' + nome_pacote + ';')

java.puts('import android.app.Activity;')
java.puts('import android.content.Intent;')
java.puts('import android.os.Bundle;')
java.puts('import android.view.View;')
java.puts('import android.widget.CheckBox;')
java.puts('import android.widget.EditText;')
java.puts('import android.widget.Spinner;')

java.puts("public class #{nome_classe} extends Activity {")

java.puts("    private #{nome_dao} mDbHelper;")
java.puts('    SimpleCursorAdapter mAdapter;')
java.puts(' ')
java.puts('    @Override')
java.puts('    public void onCreate(Bundle savedInstanceState) {')
java.puts('        super.onCreate(savedInstanceState);')
java.puts("        setContentView(R.layout.#{nome_layout});")
java.puts('    }')
java.puts(' ')

#
# le o xml do layout
#
doc = Nokogiri::XML.parse(File.read( nome_xml))
x = doc.at_css('Button')
#x.each do |atr|
  nome_evento = x['android:onClick']
#end
java.puts("    public void #{nome_evento}(View button) {")
java.puts('        Map<String,String> elemento = new HashMap<String,String>();')
java.puts('')
#
x = doc.css('EditText')
x.each do |atr|
    y = atr['android:id'].split('/')
    nome_campo = y[1]
    nome_atributo = nome_campo.split('_')[0].upcase
    java.puts("        final EditText #{nome_campo}_tmp = (EditText) findViewById(R.id.#{nome_campo});")
    java.puts("        elemento.put( #{nome_dic}.#{nome_atributo}, String #{nome_campo}_tmp.getText().toString();")
    java.puts('')
end
#
x = doc.css('Spinner')
x.each do |atr|
    y = atr['android:id'].split('/')
    nome_campo = y[1]
    nome_atributo = nome_campo.split('_')[0].upcase
    java.puts("        final Spinner #{nome_campo}_tmp = (Spinner) findViewById(R.id.#{nome_campo});")
    java.puts("        elemento.put( #{nome_dic}.#{nome_atributo}, String #{nome_campo}_tmp.getSelectedItem().toString();")
    java.puts('')
end
#
x = doc.css('CheckBox')
x.each do |atr|
    y = atr['android:id'].split('/')
    nome_campo = y[1]
    nome_atributo = nome_campo.split('_')[0].upcase
    java.puts("        final CheckBox #{nome_campo}_tmp = (CheckBox) findViewById(R.id.#{nome_campo});")
    java.puts("        elemento.put( #{nome_dic}.#{nome_atributo}, String #{nome_campo}_tmp.isChecked();")
    java.puts('')
end
#
java.puts('        mDbHelper.incluir(elemento);')
java.puts("    }")
java.puts("}")
