# T1_Mundo_dos_Blocos

Repositório referente ao Trabalho 1 da disciplina de Inteligência Artificial.

**Alunos:**  
Maria Sara Navarro [22051556] | Kevyn Gondim | Iasmin Rocha | Sabrina Penha

---

# Projeto de Planejamento de Movimentos de Blocos

## Introdução

Este trabalho aborda o problema do Mundo dos Blocos com extensão para blocos de diferentes tamanhos. O objetivo é desenvolver um planejador capaz de transformar um estado inicial em um estado final desejado, respeitando restrições físicas.

A solução foi implementada em Prolog utilizando técnicas de planejamento automático.

---

## Descrição do Problema

O ambiente consiste em blocos (a, b, c e d) que podem ser posicionados sobre a mesa ou empilhados.

- O eixo horizontal (X) varia de **0 a 6**
- O eixo vertical (H) representa altura (sem limite superior)
- H = 0 representa o solo

Os blocos possuem tamanhos diferentes:

- a → tamanho 1  
- b → tamanho 1  
- c → tamanho 2  
- d → tamanho 3  

---

# Regras do Domínio

## Espaço e Ocupação

- O espaço horizontal é dividido em intervalos unitários:
  - (0–1), (1–2), (2–3), (3–4), (4–5), (5–6)
- Blocos podem ocupar múltiplos espaços dependendo do tamanho
- Um bloco só pode ocupar uma região se ela estiver livre

---

## Altura (H)

- H = 0 → solo (não precisa de suporte)
- H > 0 → precisa obrigatoriamente de suporte (outro bloco abaixo)

---

## Estado Inicial

```prolog
estado_inicial([
bloco(a, 3, 4, 0),
bloco(b, 5, 6, 0),
bloco(c, 0, 2, 0),
bloco(d, 3, 6, 1)
]).