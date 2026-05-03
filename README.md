# T1_Mundo_dos_Blocos

Repositório referente ao Trabalho 1 da disciplina de Inteligência Artificial.

## Alunos
* **Maria Sara Navarro** [22051556]
* **Kevyn do Nascimento Paz Gondim** [22153920]
* **Iasmin Rocha dos Santos** [22052625]
* **Sabrina Amorim da Penha** [22152026]

---

## Projeto de Planejamento de Movimentos de Blocos

### Introdução
Este trabalho aborda o problema do Mundo dos Blocos com extensão para blocos de diferentes tamanhos. O objetivo é desenvolver um planeador capaz de transformar um estado inicial num estado final desejado, respeitando restrições físicas.

A solução foi implementada em Prolog utilizando técnicas de planeamento automático.

### Descrição do Problema
O ambiente consiste em blocos (a, b, c e d) que podem ser posicionados sobre a mesa ou empilhados.

* **O eixo horizontal (X)**: varia de 0 a 6.
* **O eixo vertical (H)**: representa altura (sem limite superior), onde H=0 representa o solo.

#### Tamanho dos blocos:
* **a**: tamanho 1
* **b**: tamanho 1
* **c**: tamanho 2
* **d**: tamanho 3

### Regras do Domínio

#### Espaço e Ocupação
* O espaço horizontal é dividido em intervalos unitários: (0–1), (1–2), (2–3), (3–4), (4–5), (5–6).
* Blocos podem ocupar múltiplos espaços dependendo do tamanho.
* Um bloco só pode ocupar uma região se ela estiver livre.

#### Altura (H)
* **H = 0**: solo (não precisa de suporte).
* **H > 0**: precisa obrigatoriamente de suporte (outro bloco abaixo).

### Estado Inicial
```prolog
estado_inicial([
   bloco(a, 3, 4, 0),
   bloco(b, 5, 6, 0),
   bloco(c, 0, 2, 0),
   bloco(d, 3, 6, 1)
]).

````
### Movimentação
* **Movimento Lateral (X)**: Não pode atravessar blocos; só pode ocupar espaço livre.
* **Movimento Vertical (H)**: Requer suporte abaixo; o bloco deve estar livre.
* **Regra de Gravidade**: Blocos sem suporte caem automaticamente para o nível mais baixo possível.

## Planeamento
Utiliza *Goal Regression Planning*.

### Execução
```prolog
?- executar_trabalho.
```
### Resultados

### Situação 1 (Sf1)

#### Meta
```prolog
[
    bloco(d, 3, 6, 0),
    bloco(b, 5, 6, 1),
    bloco(a, 4, 5, 1),
    bloco(c, 4, 6, 2)
]
```

#### Plano
```prolog
[
    move(d, 0, 3, 1),
    move(a, 2, 3, 0),
    move(d, 1, 4, 1),
    move(b, 0, 1, 1),
    move(d, 3, 6, 0),
    move(b, 5, 6, 1),
    move(a, 4, 5, 1),
    move(c, 4, 6, 2)
]
```

### Conclusão
O planeador resolve corretamente a maioria dos cenários, respeitando as restrições do problema. Apenas um caso apresentou falha parcial.

### Melhorias Futuras
* Otimização do algoritmo.
* Interface visual.
* Verificação de estabilidade.
