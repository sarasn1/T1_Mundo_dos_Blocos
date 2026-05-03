# T1_Mundo_dos_Blocos

Repositório para o trabalho 1 da disciplina de IA. 

Alunos: Maria Sara Navarro [22051556] | Kevyn do Nascimento Paz Gondim  [22153920] | Iasmin Rocha dos Santos [22052625] | Sabrina Amorim da Penha [22152026]

---

# Projeto de Planejamento de Movimentos de Blocos

## Descrição

O problema consiste em um mundo formado por blocos que podem ser empilhados uns sobre os outros ou colocados diretamente sobre a mesa. Os blocos possuem **diferentes comprimentos (larguras)** e mesma altura, o que introduz restrições adicionais em relação ao problema clássico do mundo dos blocos.

O objetivo é gerar um plano de ações que transforme um **estado inicial** em um **estado final desejado**, respeitando as restrições físicas e lógicas do ambiente.

---

## Representação do Conhecimento

Para lidar com blocos de tamanhos diferentes, foi necessário estender a representação clássica do mundo dos blocos.

### Novos conceitos adicionados

- **largura(Bloco, Tamanho)**  
  Representa o tamanho horizontal de cada bloco.

- **ocupacao(PosicaoInicial, PosicaoFinal)**  
  Indica quais posições na mesa estão ocupadas por um bloco.

- **suporte_valido(Bloco, Destino)**  
  Garante que um bloco só pode ser colocado sobre outro se houver suporte suficiente.

- **livre(Bloco)**  
  Indica que não há nenhum bloco sobre ele.

- **livre_destino(Posicao)**  
  Verifica se há espaço disponível para posicionar um bloco.

---

## Ações e Regras

### Ação principal

- **move(Bloco, De, Para)**

### Pré-condições

- O bloco deve estar livre  
- A posição de destino deve estar livre  
- O movimento deve respeitar o suporte físico (largura)

### Efeitos

- Remove o bloco da posição atual  
- Atualiza as posições ocupadas  
- Atualiza quais blocos estão livres ou ocupados  

---

## Predicados

### Predicados Principais

- **plan(EstadoInicial, EstadoFinal, Plano)**  
  Gera um plano de ações para atingir o objetivo.

- **executar_plano(Plano, EstadoAtual, EstadoFinal)**  
  Executa o plano gerado.

---

### Predicados de Estado

- estado_inicial(Estado)  
- estado_final(Estado)  
- livre(Bloco, Estado)  
- livre_destino(Posicao, Estado)

---

### Predicados de Ação

- move(Bloco, De, Para, Estado, NovoEstado)  
- adds(Action, Effects)  
- regress(Goals, Action, RegressedGoals)  
- preconditions(Action, Preconditions)

---

## Planejamento (Abordagem)

O sistema utiliza **Goal Regression Planning**, onde:

- Parte-se do objetivo final  
- Regride-se até o estado inicial  
- Constrói-se um plano de ações válido  

O planejamento segue uma abordagem recursiva semelhante à busca em grafos.

---

## Resolução Manual (Situação 1)

### Objetivo: S0 → Sf1

Exemplo de plano manual:

1. mover bloco A para posição livre  
2. mover bloco B para posição desejada  
3. mover bloco C sobre B  
4. ajustar bloco D conforme restrição  

---

### Objetivo: S0 → S5

1. liberar blocos superiores  
2. reposicionar blocos intermediários  
3. empilhar conforme estado final  

---

### Objetivo: S0 → S7

1. reorganizar base  
2. garantir suporte adequado  
3. empilhar blocos finais  

---

## Geração de Plano com IA

Após a modelagem manual:

- Foi utilizado um chatbot de IA para auxiliar na geração do código  
- O código foi adaptado para suportar:
  - blocos com tamanhos diferentes  
  - restrições adicionais  

---

## Testes e Comparação

Foram realizados testes para:

- Situação 1  
- Situação 2  
- Situação 3  

### Comparação

| Critério | Plano Manual | Plano Gerado |
|----------|------------|--------------|
| Correção | Alta | Alta |
| Eficiência | Média | Alta |
| Complexidade | Baixa | Maior |

### Conclusão

- O plano gerado automaticamente foi mais otimizado  
- O plano manual ajudou na validação da lógica  

---

## Como Usar o Simulador

1. Carregar o código no SWI-Prolog

2. Executar:

```prolog
?- plan(estado_inicial, estado_final, Plano).
