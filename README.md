APP Podekex - Complementação da avaliação da 1ª unidade de Programação de Dispositivos Móveis

Projeto Flutter com JSON-Server para Dados de Pokémon
Este projeto Flutter utiliza uma base de dados JSON de Pokémon para exibir informações sobre eles. Para o funcionamento correto, é necessário configurar um servidor JSON e ajustar as dependências no Flutter.

Pré-requisitos
Flutter instalado e configurado
Node.js para executar o json-server
Instruções de Configuração e Execução
1. Instalar Dependências Flutter
No terminal, execute o comando abaixo para obter as bibliotecas necessárias:

bash
Copiar código
flutter pub get
2. Gerar Classes JSON Serializable
Este projeto utiliza json_serializable para converter automaticamente JSON em classes Dart. Para criar essas classes, execute:

bash
Copiar código
dart run build_runner build
3. Configurar e Executar o JSON Server
Instale o json-server:

bash
Copiar código
npm install -g json-server
Baixe a Base de Dados de Pokémon:

Acesse o repositório [fanzeyi/pokemon.json](https://github.com/fanzeyi/pokemon.json/blob/master/pokedex.json) e baixe o JSON.
Salve o arquivo como db.json na pasta raiz do seu projeto.
Inicie o Servidor JSON:

No terminal, execute:

bash
Copiar código
json-server --watch db.json
Isso iniciará o servidor em http://localhost:3000 por padrão.

4. Configurar o config_providers.dart
No arquivo config_providers.dart do projeto, configure o baseUrl para o IP correto:

Dispositivo Móvel: Use o IP da sua máquina para baseUrl.
Emulador Android: Use 10.0.2.2 como baseUrl.
Exemplo de configuração:

dart
Copiar código
// config_providers.dart
const String baseUrl = 'http://<seu_ip_local>:3000';
Nota: Substitua <seu_ip_local> pelo IP da sua máquina.

5. Executar o Projeto Flutter
Com tudo configurado, execute o aplicativo:

bash
Copiar código
flutter run
Recursos e Links Úteis
https://www.npmjs.com/package/json-server
