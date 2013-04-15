class GeraAppManifesto


  def executa(nome_app)

    nome_pacote = "br.inf.intelidata.#{nome_app}"
    nome_classe = nome_app.capitalize
    #
    require 'fileutils'
    #
    lmx = File.new( 'res/values/manifesto_string.xml', 'w+')
    lmx.puts('<?xml version="1.0" encoding="utf-8"?>')
    lmx.puts('<resources>')
    #
    xml = File.new( 'AndroidManifest.xml', 'w+')
    xml.puts('<?xml version="1.0" encoding="utf-8"?>')
    xml.puts('<manifest xmlns:android="http://schemas.android.com/apk/res/android"')
    xml.puts('    package="' + nome_pacote +'"')
    xml.puts('    android:versionCode="1"')
    xml.puts('    android:versionName="1.0">')
    xml.puts('    <application')
    xml.puts('        android:theme="@style/Theme.D1"')
    xml.puts('        android:icon="@drawable/icon"')
    xml.puts('        android:label="@string/' + nome_app + '">')
    xml.puts('        <activity android:name=".' + nome_classe + '"')
    xml.puts('            android:label="@string/' + nome_app + '">')
    xml.puts('            <intent-filter>')
    xml.puts('                <action android:name="android.intent.action.MAIN" />')
    xml.puts('                <category android:name="android.intent.category.LAUNCHER" />')
    xml.puts('            </intent-filter>')
    xml.puts('        </activity>')

    #
    # pega os arquivos DAO

    arquivos = Dir.glob("src/#{nome_pacote}/*LST.java")

    arquivos.each do |arquivo_base_name|

      classe = arquivo_base_name.split('/')
      nome_arquivo = classe[-1]
      nome_classe = nome_arquivo.split('.')[0].strip
      classe = nome_arquivo.split('LST')
      nome_tabela = classe[0].strip.downcase
      nome_prefix = nome_tabela.capitalize
      #
      #
      #TODO: colocar dados das atividades de search e intent
      xml.puts('        <activity android:name="' + nome_classe +'"')
      xml.puts('            android:theme="@style/Theme.D1"')
      xml.puts('            android:label="@string/' + nome_tabela + '_app_titulo"')
      xml.puts('            android:launchMode="singleTop">')
      xml.puts('            <intent-filter>')
      xml.puts('                <action android:name="android.intent.action.SEARCH" />')
      xml.puts('            </intent-filter>')
      xml.puts('            <meta-data android:name="android.app.searchable"')
      xml.puts('                android:resource="@xml/searchable"/>')
      xml.puts('        /activity>')
      #
      # grava  string
      lmx.puts('    <string name="' + nome_tabela + '_app_titulo">' + nome_prefix + '</string>')
    end
    #
    # tela de ABOUT
    xml.puts('        <activity android:name=".AboutActivity"')
    xml.puts('            android:theme="@style/Theme.D1"')
    xml.puts('            android:label="@string/titulo_sobre"')
    xml.puts('        /activity>')
    xml.puts('')
    xml.puts('    </application>')
    xml.puts('    <uses-sdk android:minSdkVersion="8" />')
    xml.puts('</manifest>')
    xml.close
    #
    lmx.puts('    <string name="titulo_sobre">Sobre</string>')
    lmx.puts('</resources>')
    lmx.close
  end
end
#TODO: colocar outros arquivos??
#
