##
# @Odone
#
# programa que gera a classe helper do dicionário,
# baseado nos DAOs exitentes
#
# recebe o nome da aplicaçao

class GeraCrudAtividade

  def executa( nome_arquivo_base, nome_app)
    require 'fileutils'
    require 'nokogiri'

    classe = nome_arquivo_base.split(".")
    nome_tabela = classe[0].strip.downcase
    nome_prefix = nome_tabela.capitalize
    nome_dic    = "#{nome_prefix}DIC"
    nome_dao    = "#{nome_prefix}DAO"
    nome_classe = "#{nome_prefix}ACT"
    nome_pacote = "br.inf.intelidata.#{nome_app}"
    nome_layout = "#{nome_tabela}_crud"
    nome_xml    = "res/layout/#{nome_layout}.xml"

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
    java.puts('    private int mModo;')
    java.puts('    private String mID;')
    java.puts('')
    java.puts('    @Override')
    java.puts('    public void onCreate(Bundle savedInstanceState) {')
    java.puts('        super.onCreate(savedInstanceState);')
    java.puts("        setContentView(R.layout.#{nome_layout});")
    java.puts("        mDbHelper = new #{nome_dao}(this);")
    java.puts('        Intent intent = getIntent();')
    java.puts('        mID = intent.getStringExtra("rowID");')
    java.puts('')
    java.puts('        mModo = 0; // inserir')
    java.puts('        if ( !mID.isEmpty()) {')
    java.puts('            mModo = 1; //alterar')
    java.puts('            final Cursor mCursor = mDbHelper.listaUm(mID);')
    java.puts('            try')
    java.puts('            {')
    java.puts('                mCursor.moveToFirst();')
    java.puts('            }')
    java.puts('            catch(Exception e)')
    java.puts('            {')
    java.puts('                e.printStackTrace();')
    java.puts('            }')

    #
    # le o xml do layout
    #
    doc = Nokogiri::XML.parse(File.read( nome_xml))
    #
    x = doc.css('EditText')
    x.each do |atr|
      y = atr['android:id'].split('/')
      nome_campo = y[1]
      nome_atributo = nome_campo.split('_')[0].upcase
      java.puts("            final EditText #{nome_campo}_tmp = (EditText) findViewById(R.id.#{nome_campo});")
      java.puts("            #{nome_campo}_tmp.setText( mCursor.getString( mCursor.getColumnIndex(#{nome_dic}.#{nome_atributo})));")
      java.puts('')
    end
    #
    #TODO: testar com spinner
    x = doc.css('Spinner')
    x.each do |atr|
      y = atr['android:id'].split('/')
      nome_campo = y[1]
      nome_atributo = nome_campo.split('_')[0].upcase
      java.puts("            final Spinner #{nome_campo}_tmp = (Spinner) findViewById(R.id.#{nome_campo});")
      java.puts("            #{nome_campo}_tmp.setSelectedItem( mCursor.getString( mCursor.getColumnIndex(#{nome_dic}.#{nome_atributo})));")
      java.puts('')
    end
    #
    #TODO: testar com checkBox
    x = doc.css('CheckBox')
    x.each do |atr|
      y = atr['android:id'].split('/')
      nome_campo = y[1]
      nome_atributo = nome_campo.split('_')[0].upcase
      java.puts("            final CheckBox #{nome_campo}_tmp = (CheckBox) findViewById(R.id.#{nome_campo});")
      java.puts("            #{nome_campo}_tmp.setChecked( mCursor.getString( mCursor.getColumnIndex(#{nome_dic}.#{nome_atributo})));")
      java.puts('')
    end
    java.puts('        }')
    java.puts('    }')
    java.puts(' ')

    #
    # re-le o xml do layout
    #
    # doc = Nokogiri::XML.parse(File.read( nome_xml))
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
        java.puts("        elemento.put( #{nome_dic}.#{nome_atributo}, (String) #{nome_campo}_tmp.getText().toString());")
        java.puts('')
    end
    #
    x = doc.css('Spinner')
    x.each do |atr|
        y = atr['android:id'].split('/')
        nome_campo = y[1]
        nome_atributo = nome_campo.split('_')[0].upcase
        java.puts("        final Spinner #{nome_campo}_tmp = (Spinner) findViewById(R.id.#{nome_campo});")
        java.puts("        elemento.put( #{nome_dic}.#{nome_atributo}, (String) #{nome_campo}_tmp.getSelectedItem().toString());")
        java.puts('')
    end
    #
    x = doc.css('CheckBox')
    x.each do |atr|
        y = atr['android:id'].split('/')
        nome_campo = y[1]
        nome_atributo = nome_campo.split('_')[0].upcase
        java.puts("        final CheckBox #{nome_campo}_tmp = (CheckBox) findViewById(R.id.#{nome_campo});")
        java.puts("        elemento.put( #{nome_dic}.#{nome_atributo}, (String) #{nome_campo}_tmp.isChecked());")
        java.puts('')
    end
    #
    java.puts('        if (mModo == 0)')
    java.puts('            mDbHelper.incluir(elemento);')
    java.puts('        else;')
    java.puts('            mDbHelper.alterar(elemento, mID);')
    java.puts('')
    java.puts('        finish();')
    java.puts("    }")
    java.puts("}")
  end
end