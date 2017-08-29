Rails App desenvolvido para o challenge da <a href="https://www.rapidoo.com.br">Rapidoo</a>.

<p>Após ter clonado o repositório, por favor execute:</p>
<ul>
  <li><code>bundle install</code> ~> Instalar as gems necessárias</li>
  <li><code>rails db:migrate</code> ~> Executar as migrações necessárias</li>
</ul>

<p>Requisitos de software:</p>
<p>Versão ruby usada: <code>ruby 2.3.3p222</code></p>
<p>Versão rails usada: <code>Rails 5.1.3</code></p>
<p>Feito isso, você pode testar a aplicação locamente, com o seguinte comando:</p>
<p><code>rails s</code> e acessar http://localhost:3000</p>

<tr></tr>

Os objetivos desse app são:
<ul>
  <li>Persistir as informações do cliente em um banco de dados (no caso, postgresql)</li>
  <ul>
    <li>Nome</li>
    <li>Email</li>
    <li>Nome da empresa</li>
    <li>Faturamento mensal da empresa</li>
    <li>Valor do título</li>
    <li>O prazo até o vencimento (dias) do título;</li>
  </ul>
</ul>
Apos isso, o cliente obtem as seguintes informações:
<ul>
  <li>Qual a taxa total (em %) que será descontado do seu título</li>
  <li>Qual valor ele receberá, caso aceite antecipar o título</li>
</ul>

<tr></tr>
<p>Bonus point: A Taxa-base é dinâmica variando com o faturamento mensal das empresas (p.e acima de 100k/mês é 1.5% e abaixo de 50k/mês é 1.8%);</p>
<p>Bonus point: A demo da aplicação pode ser encontrada <a href="https://guarded-plateau-29367.herokuapp.com/">aqui</a> (heroku deploy)</p>
