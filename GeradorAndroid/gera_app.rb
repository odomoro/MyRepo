###
#
# script que ira chamar todas as classes geradoras
#
require './gera_crud_layout'
require './gera_crud_lista'
require './gera_crud_dao'
require './gera_crud_atividade'
require './gera_crud_dicionario'
require './gera_app_menu'
require './gera_app_dashboard'
require './gera_app_manifesto'
require './gera_app_helper'
require 'fileutils'

#
nome_app = ARGV[0]
nome_pacote = 'br.inf.intelidata.' + nome_app

#
# cria estrutura da aplicação
FileUtils.mkdir_p('res/layout') unless File.exists?('res/layout')
FileUtils.mkdir_p('res/values') unless File.exists?('res/values')
FileUtils.mkdir_p('res/menu') unless File.exists?('res/menu')
FileUtils.mkdir_p('res/xml') unless File.exists?('res/xml')
FileUtils.mkdir_p("src/#{nome_pacote}") unless File.exists?("src/#{nome_pacote}")

#
# pega todos os arquivos do tipo *.gat para gerar individualmente as classes
arquivos = Dir.glob('./*.gat')
arquivos.each do |arquivo_name|

  #
  classe = arquivo_name.split("/")
  arquivo_base_nome = classe[-1]

  #
  # gera_crud_layout
  GeraCrudLayout.new.executa(arquivo_base_nome,nome_app)
  # gera_crud_dicionario
  GeraCrudDicionario.new.executa(arquivo_base_nome,nome_app)
  # gera_crud_dao
  GeraCrudDAO.new.executa(arquivo_base_nome,nome_app)

  # gera_crud_lista
  GeraCrudLista.new.executa(arquivo_base_nome,nome_app)
  # gera_crud_atividade
  GeraCrudAtividade.new.executa(arquivo_base_nome,nome_app)
  #
end

# as classe abaixo são executadas 1X por aplicação e
# são baseadas nos arquivos gerados na primeira parte
# gera_app_helper
GeraAppHelper.new.executa(nome_app)
# gera_app_menu = partes fixas de menus e strings
GeraAppMenu.new.executa()
# gera_app_manifesto
GeraAppManifesto.new.executa(nome_app)
# gera_app_dashboard
GeraAppDashBoard.new.executa(nome_app)
#
puts("Geracao concluida!")
exit



#
#########################################################################################
#
