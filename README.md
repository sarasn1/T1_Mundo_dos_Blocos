# T1_Mundo_dos_Blocos

Repositório referente ao Trabalho 1 da disciplina de Inteligência Artificial.

**Alunos:**  
Maria Sara Navarro [22051556] | Kevyn Gondim | Iasmin Rocha | Sabrina Penha

---

# Projeto de Planejamento de Movimentos de Blocos

## Introdução

Este trabalho aborda o problema do Mundo dos Blocos, estendido para um cenário onde os blocos possuem diferentes dimensões horizontais. O objetivo é desenvolver um planejador capaz de transformar um estado inicial em um estado final desejado, respeitando restrições físicas.

A solução foi implementada em Prolog utilizando técnicas de planejamento automático.

---

## Descrição do Problema

O ambiente consiste em blocos (a, b, c e d) que podem ser posicionados sobre a mesa ou empilhados. Diferentemente do modelo clássico, cada bloco ocupa um intervalo no eixo horizontal (X = 0 até X = 6), exigindo controle de ocupação e suporte.

---

## Representação do Conhecimento

Para modelar o problema, foram definidos os seguintes conceitos:

- largura(Bloco, Tamanho)  
- ocupacao(PosInicial, PosFinal)  
- livre(Bloco)  
- livre_destino(Posicao)  
- suporte_valido(Bloco, Destino)  

Esses elementos permitem garantir que os blocos sejam posicionados corretamente, respeitando limitações físicas.

---

## Ações e Planejamento

A ação principal é:

- move(Bloco, Origem, Destino)

O sistema utiliza **Goal Regression Planning**, partindo do estado final e regredindo até o estado inicial para gerar o plano.

Execução no Prolog:

```prolog
?- executar_trabalho.