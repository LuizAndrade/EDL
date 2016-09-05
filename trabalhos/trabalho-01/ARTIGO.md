# Perl

## Introdução
  Perl é uma linguagem de programação multiparadigma e software livre,  criada em 1987, por Larry Wall, criada com o intuito de reportar strings mais facilmente em tarefas administrativas UNIX, quatro anos antes da criação do Linux.

  Atualmente é ultilizada em aplicações Web, computação gráfica, programas financeiros e bioinformática, porém, tal como seu *slogan "There's more than one way to do it"* Perl possui capacidade e flexibilidade para atender diversas situações.
## Origens e Influências
  Influenciada por C, AWK, sed e Bourne Shell, Perl foi desenvolvida para reunir o melhor de cada linguagem em uma só, algo que funcionou pela maioria dos administradores UNIX por um período, somente na versão 5, lançada em 1994, com a reescrita completa de seu interpretador e adição de objetos, módulos e referências, Perl atingiu o patamar de ser uma linguagem completa.
## Classificação
  * Multiparadigma:
    * Funcional
    * Imperativa
    * Orientada à objetos
    * Reflexiva


  * Interpretada
    * Possui um interpretador que durante o tempo de execução transforma o código fonte em código intermediário, para em seguida gerar o código de máquina.


  * Tipagem Dinâmica e Fraca
    * Os tipos das variáveis não precisam ser declaradas e são mutáveis ao longo da execução.


  * Portabilidade
    * Em maioria dos sistemas baseados em UNIX já possuem interpretador Perl instalados, já em Windows e MACOS é necessario a instalação no site oficial da linguagem.


  * Software Livre
    * Perl possui o CPAN(Comprehensive Perl Archive Network), onde a comunidade interage criando e distribuindo diversos módulos grátis. Existe desde 1995 e continua crescendo até hoje. *"You can never have too many Perl modules"*

## Avaliação Comparativa
#### Sequencia de Fibonacci em Perl
```
#!/usr/bin/perl
# Este comando serve principalmente para, em sistemas UNIX, localizar
# executáveis do código, porém, mesmo que nao esteja em um sistema UNIX
# o uso desse path serve para a portabilidade entre sistemas operacionais

use strict;
use warnings;
# Estes dois comandos acima servem de "aviso" ao interpretador,
# onde qualquer erro ou provável erro devem ser tratado como erro e impedir a compilação.
# Retirar qualquer um dos dois comandos é considerado uma
# má pratica de programação Perl.

# Functions em Perl são chamadas de subrotinas.
# Não definimos os parametros na declaração da função.

sub main {

print "\nDigite quantos numeros da sequência deseja ver\n";

# Todas as variaveis de Perl devem ser declaradas com o $
# e por sua tipagem dinâmica não precisamos declarar o tipo.
# Usamos o <STDIN> para receber os dados do stdin usual.

my $n = <STDIN>;
# O uso do my na variavel serve para definir como uma variavel local
# utilizando do escopo léxico da linguagem.

chomp $n;
# O comando chomp serve para retirar o "\n" do STDIN ao
# digitar no teclado, evitando prováveis erros na manipulação da variavel.

fibonacci($n);

exit 0;
}

sub fibonacci {
  $a = 0;
  $b = 1;

  # Os parâmetros em Perl ficam alocados em um array chamado "@_".
  # Para acessá-los devemos utilizar $_[n], onde n é qualquer número
  # de 0 até n-1.
  my $n = $_[0];

  # Este for tambem pode ser reescrito como for(my $i = 0; $i < $n; $i++).
  # Isso mostra as divesas diferenças de uma palavra chave numa mesma linguagem.
  for (0...$n-1){
    printf "%d\n", $a;
    my $sum = $a + $b;
    $a = $b;
    $b = $sum;
  }
}

main;
```

#### Sequencia de Fibonacci em Perl, porém com outra solução
```
# Repetindo o uso de strict e warnings como boa prática.
use strict;
use warnings;

sub make_fibonnaci {

  # Nessa declaração, é utilizada a atribuiçao múltipla.
  # Neste caso, seria o mesmo do que declarar:
  # my $current = 0;
  # my $next = 1;

    my ( $current, $next ) = ( 0, 1 );

    # Uso de funções anônimas, ou seja, funções que nao possuem nomes
    # declarados, são executadas em tempo de execução e possuem escopo
    # local, tornando-as mais rapidas e com uso de memória menor do que
    # definir uma nova subrotina.

    return sub {
        my $fibonacci = $current;

        # Utilizando a mesma ideia que a primeira declaração, onde:
        # $current = $next;
        # $next = $current + next;

        ( $current, $next ) = ( $next, $current + $next );
        return $fibonacci;
    };
}
# Associação de uma função(subrotina) à uma variável, mostrando
# a eficiencia da programação funcional.
my $iterator = make_fibonnaci();


for ( 1 .. 10 ) {
  # Como definimos anteriormente a variavel $iterator agora faz referência
  # à subrotina make_fibonnaci, com isso, precisamos chamar o método com o "->".
    my $fibonacci = $iterator->();
    print "$fibonacci\n";
}
```
#### Sequencia de Fibonacci em C
```

# Obrigatório esta biblioteca para qualquer uso de I/O.
#include<stdio.h>

int main()
{
  # Uso da tipagem estática de C deixa mais claro a futura intenção das variáveis.
   int n, first = 0, second = 1, next, c;

   printf("Digite quantos numeros da sequência deseja ver\n");

   # Para acessar ao stdin somente precisamos de uma função, como abaixo, ao
   # inves de digitar no código, como em Perl.
   scanf("%d",&n);

   for ( c = 0 ; c < n ; c++ )
   {
      if ( c <= 1 )
         next = c;
      else
      {
         next = first + second;
         first = second;
         second = next;
      }
      printf("%d\n",next);
   }

   return 0;
}
```

* Readability:

  A primeira vista, Perl pode se tornar algo desagrável para ler, pois com sua diversas influencias, trouxe aspectos mais variaveis para a linguagem, deixando-a única e assim, mais complexa, todavia C aparenta uma linguagem muito mais simples, por conta de sua tipagem estática e programação imperativa, mas no fim ambas linguagens possuem uma boa readability.

* Writability:

  Perl possui uma sintaxe mais complexa do que C, pois com a tipagem dinamica, o uso de $, escopo léxico e subrotinas que podem ser atribuidas à variaveis, podem causar confusões para maioria dos programadores, já em C com sua sintaxe mais básica é mais "user friendly", o que deixa mais fácil a sua escrita.

* Expressividade:

  Ambas as linguagens possuem expressividade, no entanto, Perl se supera a C, pois Perl sendo uma linguagem multiparadigma, possui um "raio de ação" mais abrangente do que em C, nos códigos anteriores, uma soluçao em Perl trazia um código estruturado, mais proximo a C, enquanto a segunda solução já apresentava soluções funcionais e orientação a objetos, se afastando de C. No fim, a comparação, ao meu ver, entre as duas linguagens se torna: "Tudo que C faz, Perl também consegue, mas nem tudo que Perl faz, C consegue replicar".

## Conclusão

  C e Perl são linguagens "anciãs" que sem elas o mundo de desenvolvimento de softwares certamente seria diferente, mesmo assim, C alcançou o topo de sua capacidade de programação, enquanto Perl continua a ser o "canivete suíço da internet", o qual permite que em certas situações, um codigo Perl pode ser a salvação do programa.


## Bibliografia
  * https://en.wikipedia.org/wiki/Perl
  * https://pt.wikipedia.org/wiki/Perl
  * https://www.perl.org/
  * http://www.softpanorama.org/Scripting/Perlbook/Ch01/perl_history.shtml
  * http://www.cpan.org/
