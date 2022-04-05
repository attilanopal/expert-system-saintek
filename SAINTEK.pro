% Start Rules (Knowledge Base)
/* Knowledge Base */
jurusan(sistem_informasi) :-
    matematika(yes),
    berlogika(yes),
    ngoding(yes).

jurusan(sistem_informasi) :-
    matematika(yes),
    berlogika(yes),
    ngoding(yes),
    otak_atik_peralatan(yes).

jurusan(sistem_informasi) :-
    matematika(yes),
    berlogika(yes),
    ngoding(no).

jurusan(sistem_informasi) :-
    matematika(yes),
    berlogika(yes),
    ngoding(no),
    otak_atik_peralatan(yes).

jurusan(teknik_informatika) :-
    matematika(yes),
    berlogika(yes),
    ngoding(yes),
    fisika(yes).

jurusan(kedokteran) :- 
    berlogika(yes),
    biologi(yes),
    bidang_kesehatan(yes).

jurusan(teknik_elektro) :-
    matematika(yes),
    fisika(yes),
    otak_atik_peralatan(yes).



% Start User Interface
/* Asking the user */
matematika(X):-
    menuask(matematika,X, [yes, no]).
berlogika(X):-
    menuask(berlogika,X, [yes, no]).
ngoding(X):-
    menuask(ngoding, X, [yes, no]).
fisika(X):-
    menuask(fisika ,X, [yes, no]).
bidang_kesehatan(X):-
    menuask(bidang_kesehatan, X, [yes, no]).
biologi(X):-
    menuask(biologi, X, [yes, no]).
otak_atik_peralatan(X):-
    menuask(otak_atik_peralatan, X, [yes, no]).


/* Menus for user & Remembering the answer*/
menuask(A, V, _):-
    known(ya, A, V), % succeed if true
    !. % stop looking
menuask(A,V,_):-
    alreadyasked(ya, A), !, fail.
menuask(A, V, MenuList) :-
    write('apakah kamu suka '), write(A), write('?'), nl,
    write(MenuList), nl,
    read(X),
    check_val(X, A, V, MenuList),
    asserta( known(ya, A, X) ),
    asserta( alreadyasked(ya, A) ),
    X == V. 
 
/* Check input */
check_val(X, _A, _V, MenuList) :-
    member(X, MenuList),
    !.
check_val(X, A, V, MenuList) :-
    write(X), write(' gk boleh ketik itu, coba lagi'), nl,
    menuask(A, V, MenuList). 
 
/* Member rules */
member(X,[X|_]).
member(X,[_|T]):-member(X,T).
% End User Interface
 
% Start Simple Shell
/* Simple shell */
top_goal(X) :- jurusan(X). 
 
solve :-
    abolish(known, 3),
    abolish(alreadyasked, 2),
    top_goal(X),
    write('Kamu cocok di '), write(X), nl.
solve :-
    write('Programnya kurang pinter.'), nl. 
 
/* Command loop */
go :-  
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X == keluar.
 
greeting :-
    write('Program untuk mengetahui jurusan yang tepat untuk kamu disaintek (Teknik Eletkro, Kedokteran, Teknik Informatika)'), nl,
    write('Tekan mulai atau keluar di comand prompt.'), nl.
 
/* Running Program */
do(mulai) :-
    solve,
    !. 
 
/* Quit Program */
do(keluar).
do(X) :-
    write(X),
    write('gak boleh ketik itu gan'), nl,
    fail. 
% End Simple Shell
 
/* handle undefined procedure */
:- unknown(trace, fail).