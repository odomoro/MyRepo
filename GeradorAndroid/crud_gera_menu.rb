##
# @Odone
#
# programa que gera o xml do menu (fixo)
#

xml = File.new( 'res/menu/menu.xml', 'w+')
xml.puts('<menu xmlns:android="http://schemas.android.com/apk/res/android" >')
xml.puts('<item')
xml.puts('    android:id="@+id/menu_incluir"')
xml.puts('    android:orderInCategory="100"')
xml.puts('    android:showAsAction="never"')
xml.puts('    android:title="@string/menu_incluir" />')
xml.puts('')
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
xml = File.new( 'res/values/menu_string.xml', 'w+')
xml.puts('<?xml version="1.0" encoding="utf-8"?>')
xml.puts('<resources>')
xml.puts('    <string name="menu_incluir">Incluir</string>')
xml.puts('    <string name="menu_alterar">Alterar</string>')
xml.puts('    <string name="menu_apagar">Excluir</string>')
xml.puts('    <string name="lista_vazia">Sem informacoes</string>') #usada nas listas
xml.puts('</resources>')
xml.close
#