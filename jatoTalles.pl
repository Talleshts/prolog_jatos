% Jato inteligente
:- module(jatoTalles, [obter_controles/2]).

% Regras para avaliar posição na arena (ajustadas para 800x600)
proximo_parede_esquerda(Sensores) :-
    Sensores = [X,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    X < 250.  % Aumentado para ter mais margem

proximo_parede_direita(Sensores) :-
    Sensores = [X,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    X > 550.  % Reduzido para ter mais margem

proximo_parede_superior(Sensores) :-
    Sensores = [_,Y,_,_,_,_,_,_,_,_,_,_,_,_,_],
    Y < 250.  % Aumentado para ter mais margem

proximo_parede_inferior(Sensores) :-
    Sensores = [_,Y,_,_,_,_,_,_,_,_,_,_,_,_,_],
    Y > 350.  % Reduzido para ter mais margem

inimigo_na_mira(Sensores) :-
    Sensores = [_,_,_,_,_,S5,_,_,_,_,_,_,_,_,_],
    S5 > 0.2, S5 < 0.8.

inimigo_esquerda(Sensores) :-
    Sensores = [_,_,_,S1,S2,S3,S4,_,_,_,_,_,_,_,_],
    Soma is S1 + S2 + S3 + S4,
    Soma > 0.1.

inimigo_direita(Sensores) :-
    Sensores = [_,_,_,_,_,_,S7,S8,S9,S10,_,_,_,_,_],
    Soma is S7 + S8 + S9 + S10,
    Soma > 0.1.

% Detecção de perigo mais sensível
em_perigo_parede(Sensores) :- 
    Sensores = [_,_,_,S1,S2,S3,_,_,_,_,S8,S9,S10,_,_],
    (S1 > 0.05; S2 > 0.05; S3 > 0.05; S8 > 0.05; S9 > 0.05; S10 > 0.05).

perigo_critico_parede(Sensores) :-
    Sensores = [_,_,_,S1,S2,S3,_,_,_,_,S8,S9,S10,_,_],
    (S1 > 0.2; S2 > 0.2; S3 > 0.2; S8 > 0.2; S9 > 0.2; S10 > 0.2).

muito_rapido(Sensores) :-
    Sensores = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,SPEED],
    SPEED > 1.2.

% Ações mais suaves
acao_fuga_emergencia([0,1,1,0,0]).     % desacelerar e virar forte à esquerda
acao_fuga_direita([0,1,0,1,0]).        % desacelerar e virar à direita
acao_fuga_esquerda([0,1,1,0,0]).       % desacelerar e virar à esquerda
acao_evasao_direita([0,1,0,1,0]).      % desacelerar e virar à direita
acao_evasao_esquerda([0,1,1,0,0]).     % desacelerar e virar à esquerda
acao_ataque_direto([0,0,0,0,1]).       % apenas atirar
acao_busca([0,0,0,0,0]).               % manter curso
acao_padrao([0,0,0,0,0]).              % manter curso

% Predicado principal que decide as ações
obter_controles(Sensores, Controles) :-
    % Prioridade 1: Evasão de emergência se muito perto da parede
    (perigo_critico_parede(Sensores) -> 
        acao_fuga_emergencia(Controles)
    ;
    % Prioridade 2: Evasão preventiva baseada na posição
    proximo_parede_esquerda(Sensores) -> 
        acao_fuga_direita(Controles)
    ;
    proximo_parede_direita(Sensores) -> 
        acao_fuga_esquerda(Controles)
    ;
    proximo_parede_superior(Sensores) -> 
        acao_fuga_direita(Controles)
    ;
    proximo_parede_inferior(Sensores) -> 
        acao_fuga_esquerda(Controles)
    ;
    % Prioridade 3: Controle de velocidade
    muito_rapido(Sensores) ->
        acao_padrao(Controles)
    ;
    % Prioridade 4: Ataque se tiver alvo e estiver seguro
    inimigo_na_mira(Sensores), \+ em_perigo_parede(Sensores) ->
        acao_ataque_direto(Controles)
    ;
    % Caso padrão: manter velocidade atual
    acao_busca(Controles)
    ).

% Regra de fallback
obter_controles(_, [0,0,0,0,0]).