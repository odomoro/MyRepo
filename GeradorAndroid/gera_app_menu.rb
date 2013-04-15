#TODO criar o arquivo string com os dados das activities
#
class GeraAppMenu

  def executa()

    ##
    # @Odone
    #
    # programa que gera o xml do menu (fixo)
    # generico que é utilizado por todas as apps
    #

    xml = File.new( 'res/menu/menu_incluir.xml', 'w+')
    xml.puts('<menu xmlns:android="http://schemas.android.com/apk/res/android" >')
    xml.puts('<item')
    xml.puts('    android:id="@+id/menu_incluir"')
    xml.puts('    android:orderInCategory="100"')
    xml.puts('    android:showAsAction="always"')
    xml.puts('    android:title="@string/menu_incluir" />')
    xml.puts('</menu>')
    xml.close

    #
    # menu de contexto da lista/atividade2
    xml = File.new( 'res/menu/menu_alterar_apagar.xml', 'w+')
    xml.puts('<menu xmlns:android="http://schemas.android.com/apk/res/android" >')
    xml.puts('<item')
    xml.puts('    android:id="@+id/menu_alterar"')
    xml.puts('    android:orderInCategory="100"')
    xml.puts('    android:showAsAction="never"')
    xml.puts('    android:title="@string/menu_alterar" />')
    xml.puts('')
    xml.puts('<item')
    xml.puts('    android:id="@+id/menu_apagar"')
    xml.puts('    android:orderInCategory="100"')
    xml.puts('    android:showAsAction="never"')
    xml.puts('    android:title="@string/menu_apagar" />')
    xml.puts('</menu>')
    xml.close

    #
    # strings usadas no menu
    xml = File.new( 'res/values/menu_string.xml', 'w+')
    xml.puts('<?xml version="1.0" encoding="utf-8"?>')
    xml.puts('<resources>')
    xml.puts('    <string name="menu_incluir">Incluir</string>')
    xml.puts('    <string name="menu_alterar">Alterar</string>')
    xml.puts('    <string name="menu_apagar">Excluir</string>')
    xml.puts('    <string name="lista_vazia">Sem informacoes</string>') #usada nas listas
    xml.puts('    <string name="menu_alterar_apagar">Acoes</string>')   #usada nas listas
    xml.puts('    <string name="pesquisa_label">Pesquisa</string>')     #usada na pesquisa
    xml.puts('    <string name="pesquisa_hint">Pesquisa</string>')      #usada na pesquisa
    xml.puts('</resources>')
    xml.close

    #
    # arquivo de configuração da pesquisa
    xml = File.new( 'res/xml/searchable.xml', 'w+')
    xml.puts('<?xml version="1.0" encoding="utf-8"?>')
    xml.puts('<searchable xmlns:android="http://schemas.android.com/apk/res/android"')
    xml.puts('    android:label="@string/pesquisa_label"')
    xml.puts('    android:hint="@string/pesquisa_hint"')
    xml.puts('    android:includeInGlobalSearch="true">')
    xml.puts('</searchable>')
    xml.close
  end
end