##
# @Odone
# programa que deverá ler um arquivo texto e
# -gerar um arquivo xml de layout para o android
# -gerar o arquivo de strings relacionado com a classe
#
#
#TODO usar os inputTypes para email, endereços e telefones


class GeraCrudLayout

  def underscore(string)
    string.split(' ').map{|e| e.capitalize}.join
    string.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").gsub(/\s+/, "").
        downcase
  end

  def camel_case(string)
    string = string.gsub(/\s+/, "")
    return string if string !~ /_/ && string =~ /[A-Z]+.*/
    string.split('_').map{|e| e.capitalize}.join
  end

  def escreve_label(xml, label)
    #
    # label do campo
    xml.puts('        <TableRow>')
    xml.puts('            <TextView android:text="@string/' + label +'"')
    xml.puts('                android:layout_width="wrap_content"')
    xml.puts('                android:layout_height="wrap_content"/>')
    xml.puts('        </TableRow>')
  end

  def escreve_string(xml, label, literal)
    xml.puts('    <string name="' + label + '">' + literal + '</string>')
  end


  def abre_string_xml( arquivo )
    classe = arquivo.split(".")
    xml = File.new( "res/values/#{underscore(classe[0])}_string.xml", "w+")
    xml.puts('<?xml version="1.0" encoding="utf-8"?>')
    xml.puts('<resources>')
    return xml
  end


  def abre_classe_xml( arquivo )
    classe = arquivo.split(".")
    xml = File.new( "res/layout/#{underscore(classe[0])}_crud.xml", "w+")
    xml.puts('<?xml version="1.0" encoding="utf-8"?>')
    xml.puts('<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"')
    xml.puts('   android:layout_width="match_parent"')
    xml.puts('   android:layout_height="match_parent">')
    xml.puts('   <TableLayout android:layout_width="match_parent"')
    xml.puts('                android:layout_height="match_parent">')
    return xml
  end


  def fecha_classe_xml(xml)
    xml.puts('   </TableLayout>')
    xml.puts('</ScrollView>')
  end


  def fecha_string_xml(xml)
    xml.puts('</resources>')
  end


  #
  #
  #########################################################################################
  #
  #
  # pega e testa os argumentos
  # arquivo_base_name = ARGV[0].strip
  # nome_app = ARGV[1].strip
  #
  # le cada linha e transforma em um array
  #
  # campos[0] = Nome do campo
  # campos[1] = Tipo do campo para efeitos de SQL
  # campos[2] = Label do campo
  # campos[3] = Hint do campo
  # campos[4] = Tipo de widget  para interface
  #             (L= TextView /E= EditText / B=Button/ I=ImageView /IB=ImageButton/ S=Spinner)
  # campos[5] = SubTipo ou Itens complementares do widget
  #             seleção (spiner) x|y|z    default = x
  #             InputType quando for EditText
  # campos[6] = [sem uso]
  #
  #


  def executa( arquivo_base_name, nome_app )

    #
    if File.exist?(arquivo_base_name)
      arquivo_base = File.open(arquivo_base_name)
    else
      puts "Arquivo nao existe"
      exit
    end

    classe = arquivo_base_name.split(".")
    nome_tabela = classe[0].strip.downcase
    classe_xml = abre_classe_xml(arquivo_base_name)
    string_xml = abre_string_xml(arquivo_base_name)

    while linha = arquivo_base.gets do


      if linha.start_with?("#")
          next
      end

      campos = linha.split(",")

      nome_campo =  underscore(campos[0])
      nome_label = "#{nome_tabela}_#{nome_campo}_label"
      nome_hint  = "#{nome_tabela}_#{nome_campo}_hint"
      nome_draw  = "#{nome_tabela}_#{nome_campo}_draw"
      #
      case campos[4].downcase.strip

        when "i"
          #
          # imagem
          escreve_label( classe_xml, nome_label)
          escreve_string( string_xml, nome_label, campos[2].strip )

          classe_xml.puts('        <TableRow>')
          classe_xml.puts('            <ImageView android:id="@+id/' +  nome_campo + '_image_view"')
          classe_xml.puts('                android:layout_width="wrap_content"')
          classe_xml.puts('                android:layout_height="wrap_content"')
          classe_xml.puts('                android:scaleType="fitXY"')
          classe_xml.puts('                android:src="@drawable/' +  nome_draw + '"/>')
          classe_xml.puts('        </TableRow>')

        when "ib"
          #
          # image button
          classe_xml.puts('        <TableRow>')
          classe_xml.puts('            <ImageButton android:id="@+id/' +  nome_campo + '_image_button"')
          classe_xml.puts('                android:layout_width="wrap_content"')
          classe_xml.puts('                android:layout_height="wrap_content"')
          classe_xml.puts('                android:scaleType="fitXY"')
          classe_xml.puts('                android:src="@drawable/' + nome_draw + '"/>')
          classe_xml.puts('                android:onClick="' + nome_campo + 'OnClick"' )
          classe_xml.puts('        </TableRow>')

        when "b"
          #
          # button
          escreve_string( string_xml, nome_label, campos[2].strip )
          #
          classe_xml.puts('        <TableRow>')
          classe_xml.puts('            <Button android:id="@+id/' +  nome_campo + '_button"')
          classe_xml.puts('                android:layout_width="wrap_content"')
          classe_xml.puts('                android:layout_height="wrap_content"')
          classe_xml.puts('                android:onClick="' + nome_campo + 'OnClick"' )
          classe_xml.puts('                android:text="@string/' + nome_label + '"/>')
          classe_xml.puts('        </TableRow>')

        when "l"
          #
          # label
          escreve_label( classe_xml, nome_label)
          escreve_string( string_xml, nome_label , campos[2].strip )

        when "e"
          #
          # edit
          escreve_label(classe_xml, nome_label)
          escreve_string( string_xml, nome_label, campos[2].strip )
          escreve_string( string_xml, nome_hint, campos[3].strip )
          #
          classe_xml.puts('        <TableRow>')
          classe_xml.puts('            <EditText android:id="@+id/' + nome_campo + '_edit_text"')
          classe_xml.puts('                android:layout_height="wrap_content"')
          classe_xml.puts('                android:layout_width="wrap_content"')
          classe_xml.puts('                android:hint="@string/' +  nome_hint + '"')

          if !campos[5].nil?
             classe_xml.puts('                android:InputType="' + campos[5].strip + '"')
          end
          classe_xml.puts('                android:layout_weight="1"/>')
          classe_xml.puts('        </TableRow>')


        when "s"
          #
          # spinner
          escreve_label( classe_xml, nome_label)
          escreve_string( string_xml, nome_label, campos[2].strip )
          #
          classe_xml.puts('        <TableRow>')
          classe_xml.puts('            <Spinner android:id="@+id/' + nome_campo + '_spinner"')
          classe_xml.puts('                android:layout_height="wrap_content"')
          classe_xml.puts('                android:layout_width="match_parent"')
          classe_xml.puts('                android:layout_weight="1"/>')
          classe_xml.puts('        </TableRow>')

      end
      #
    end

    fecha_classe_xml(classe_xml)
    fecha_string_xml(string_xml)
    classe_xml.close
    string_xml.close
    arquivo_base.close
    #
    ##########################
  end
end