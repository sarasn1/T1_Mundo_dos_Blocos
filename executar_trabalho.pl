% =========================================================
% PLANEJADOR HÍBRIDO (FORWARD + REGRESSÃO REVERSA)
% IA - ICOMP/UFAM (Referência: T1_MundoDosBlocos_via_chaBot.pdf)
% =========================================================

:- dynamic bloco/4.

% 1. Definições de Dimensões e Espaço
tamanho(a, 1). tamanho(b, 1). tamanho(c, 2). tamanho(d, 3).
posicao_x(X) :- member(X, [0,1,2,3,4,5,6]).
altura(H) :- member(H, [0,1,2,3]).

% --- ESTADO INICIAL (S0) ---
estado_inicial([
    %Estado Inicial da Situação 1
    bloco(c, 0, 2, 0), 
    bloco(a, 3, 4, 0),
    bloco(b, 5, 6, 0), 
    bloco(d, 3, 6, 1)
               
   %Estado Inicial da Situação 2
%    bloco(c, 0, 2, 0), 
%    bloco(a, 0, 1, 1),
%    bloco(b, 1, 2, 1), 
%    bloco(d, 3, 6, 0)
               
   %Estado Inicial da Situação 3
%    bloco(c, 0, 2, 0), 
%    bloco(a, 3, 4, 0),
%    bloco(b, 5, 6, 0), 
%    bloco(d, 3, 6, 1)
               
]).

% --- REGRAS DE FÍSICA E ESTABILIDADE ---
colisao(X1, X2, H, Estado, ID) :-
    member(bloco(OID, BX1, BX2, BH), Estado),
    OID \= ID, BH == H, BX1 < X2, BX2 > X1.

livre_topo(ID, Estado) :-
    member(bloco(ID, X1, X2, H), Estado),
    H1 is H + 1, not(colisao(X1, X2, H1, Estado, ID)).

tem_suporte(_, _, 0, _, _). % Chão
tem_suporte(X1, X2, H, Estado, ID) :-
    H > 0, HB is H - 1, Centro is (X1 + X2) / 2,
    member(bloco(BID, SX1, SX2, HB), Estado),
    BID \= ID, SX1 =< Centro, SX2 >= Centro.

% --- AÇÃO DE MOVIMENTO ---
acao(Estado, move(ID, NX1, NX2, NH), NovoEstado) :-
    member(bloco(ID, OX1, OX2, OH), Estado),
    livre_topo(ID, Estado),
    tamanho(ID, T), posicao_x(NX1), altura(NH),
    NX2 is NX1 + T, NX2 =< 6,
    (NX1 \= OX1 ; NH \= OH),
    not(colisao(NX1, NX2, NH, Estado, ID)),
    tem_suporte(NX1, NX2, NH, Estado, ID),
    delete(Estado, bloco(ID, OX1, OX2, OH), Temp),
    append([bloco(ID, NX1, NX2, NH)], Temp, NovoEstado).

% --- MOTOR FORWARD ---
resolver_forward(Estado, Meta, [], _, Estado) :- 
    subset(Meta, Estado).
resolver_forward(Estado, Meta, [move(ID, X1, X2, H)|Resto], Visitados, EstadoFinal) :-
    acao(Estado, move(ID, X1, X2, H), Prox),
    not(member(Prox, Visitados)),
    resolver_forward(Prox, Meta, Resto, [Prox|Visitados], EstadoFinal).

% --- MOTOR DE REGRESSÃO (GOAL REGRESSION) ---
% Mostra as submetas necessárias de trás para frente[cite: 1, 2]
exibir_regressao_reversa([]).
exibir_regressao_reversa([move(ID, NX1, _, NH) | Resto]) :-
    exibir_regressao_reversa(Resto), % Recursão primeiro para inverter a ordem
    format('  -> Submeta: Para consolidar o estado, o bloco ~w deve estar em (X:~w, H:~w)~n', [ID, NX1, NH]).

% --- EXECUTOR FINAL ---
planejar_multi_metas([], _, []).
planejar_multi_metas([Meta|Resto], EstadoInicial, [PlanoF|Outros]) :-
    format('~n--- Resolvendo Meta: ~w ---~n', [Meta]),
    length(PlanoF, _),
    resolver_forward(EstadoInicial, Meta, PlanoF, [EstadoInicial], EstadoInter),
    format('Plano de Execução (Forward): ~w~n', [PlanoF]),
    format('Regressão de Metas (Backward Ordering):~n'),
    exibir_regressao_reversa(PlanoF), % Exibe o caminho reverso das dependências[cite: 1]
    planejar_multi_metas(Resto, EstadoInter, Outros).

executar_trabalho :-
    estado_inicial(S0),
    Metas = [
        %Situação 1 Sf1
        [bloco(d, 3, 6, 0)], % Meta 1
        [bloco(b, 5, 6, 1)], % Meta 2
        [bloco(a, 4, 5, 1)], % Meta 3
        [bloco(c, 4, 6, 2)]  % Meta 4
        
        %Situação 1 Sf2
%        [bloco(d, 3, 6, 0)], % Meta 1
%        [bloco(c, 4, 6, 1)], % Meta 2
%        [bloco(b, 5, 6, 2)], % Meta 3
%        [bloco(c, 4, 5, 2)]  % Meta 4     
            
%        %Situação 1 Sf3
%        [bloco(b, 5, 6, 0)], % Meta 1
%        [bloco(c, 0, 2, 0)], % Meta 2
%        [bloco(a, 2, 3, 0)], % Meta 3
%        [bloco(d, 0, 3, 1)]  % Meta 4
            
        %Situação 1 Sf4
%        [bloco(b, 5, 6, 0)], % Meta 1
%        [bloco(c, 0, 2, 0)], % Meta 2
%        [bloco(d, 2, 5, 0)], % Meta 3
%        [bloco(a, 0, 1, 2)]  % Meta 4     
         
        %Situação 2
%        [bloco(b, 2, 3, 0)], % S1
%        [bloco(a, 2, 3, 1)], % S2
%        [bloco(c, 4, 6, 1)], % S3
%        [bloco(a, 4, 5, 2)], % S4
%        [bloco(b, 5, 6, 2)]  % S5
            
        %Situação 3
%        [bloco(d, 0, 3, 1)], % S1
%        [bloco(a, 5, 6, 1)], % S2
%        [bloco(d, 2, 5, 0)], % S3
%        [bloco(a, 0, 1, 1)], % S4
%        [bloco(b, 1, 2, 1)], % S5
%        [bloco(b, 1, 2, 1)], % S6
%        [bloco(d, 3, 6, 0)] % S7
            
    ],
    planejar_multi_metas(Metas, S0, _).