#TODO criar o arquivo string com os dados das activities
#TODO usar os inputTypes para email, endereços e telefones
#
class GeraAppManifesto

  def gera_menu()
                         2
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
    xml = File.new( 'res/values/menu_string.xml', 'w+')
    xml.puts('<?xml version="1.0" encoding="utf-8"?>')
    xml.puts('<resources>')
    xml.puts('    <string name="menu_incluir">Incluir</string>')
    xml.puts('    <string name="menu_alterar">Alterar</string>')
    xml.puts('    <string name="menu_apagar">Excluir</string>')
    xml.puts('    <string name="lista_vazia">Sem informacoes</string>') #usada nas listas
    xml.puts('    <string name="menu_alterar_apagar">Acoes</string>') #usada nas listas
    xml.puts('</resources>')
    xml.close
    #
  end

  def gera_manifesto()

  end
end
=begin
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="br.inf.intelidata.helloapp"
    android:versionCode="1"
    android:versionName="1.0" >

    <uses-sdk
        android:minSdkVersion="11"
        android:targetSdkVersion="17" />

    <application
        android:allowBackup="true"
        android:icon="@drawable/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/AppTheme" >
        <activity
            android:name="br.inf.intelidata.helloapp.Univendas"
            android:label="@string/app_name" >
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        <activity
            android:name="br.inf.intelidata.helloapp.PreferenciaDisplay"
            android:label="@string/title_activity_display_message"
            android:parentActivityName="br.inf.intelidata.helloapp.MyMainActivity" >
            <meta-data
                android:name="android.support.PARENT_ACTIVITY"
                android:value="br.inf.intelidata.helloapp.MyMainActivity" />
        </activity>
        <activity
            android:name="br.inf.intelidata.helloapp.PreferenciaActivity"
            android:label="@string/title_activity_preference"
            android:parentActivityName="br.inf.intelidata.helloapp.MyMainActivity" >
            <meta-data
                android:name="android.support.PARENT_ACTIVITY"
                android:value="br.inf.intelidata.helloapp.MyMainActivity" />
        </activity>
        <activity
            android:name="br.inf.intelidata.helloapp.PreferenciaFragment"
            android:label="@string/title_activity_preference_frag"
            android:parentActivityName="br.inf.intelidata.helloapp.MyMainActivity" >
            <meta-data
                android:name="android.support.PARENT_ACTIVITY"
                android:value="br.inf.intelidata.helloapp.MyMainActivity" />
        </activity>
        <activity
            android:name="br.inf.intelidata.helloapp.ClientesLista"
            android:label="@string/title_activity_clientes"
            android:parentActivityName="br.inf.intelidata.helloapp.MyMainActivity" >
            <meta-data
                android:name="android.support.PARENT_ACTIVITY"
                android:value="br.inf.intelidata.helloapp.MyMainActivity" />
        </activity>
        <activity
            android:name="br.inf.intelidata.helloapp.ClientesCRUD"
            android:label="@string/title_activity_clientes_crud"
            android:parentActivityName="br.inf.intelidata.helloapp.ClientesLista" >
            <meta-data
                android:name="android.support.PARENT_ACTIVITY"
                android:value="br.inf.intelidata.helloapp.ClientesLista" />
        </activity>
    </application>

</manifest>
=end
