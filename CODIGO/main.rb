require 'webrick'

# Configurando o diretório público
public_dir = File.join(File.dirname(__FILE__), 'public')

# Configurando o servidor
server = WEBrick::HTTPServer.new(Port: 8000, DocumentRoot: public_dir)

# Definindo rotas para cada página
server.mount_proc '/' do |req, res|
  serve_file(req, res, 'home.html')
end

server.mount_proc '/curiosidades' do |req, res|
  serve_file(req, res, 'curiosidades.html')
end

server.mount_proc '/sobre' do |req, res|
  serve_file(req, res, 'sobre.html')
end

# Método auxiliar para servir arquivos estáticos
def serve_file(req, res, filename)
  File.open(File.join(File.dirname(__FILE__), 'public', filename)) do |file|
    res.body = file.read
  end
end

# Capturando o sinal de interrupção para encerrar o servidor
trap('INT') { server.shutdown }

# Adicionando mensagem de inicialização
puts "SERVIDOR RODANDO EM http://localhost:8000/"

# Iniciando o servidor
server.start
