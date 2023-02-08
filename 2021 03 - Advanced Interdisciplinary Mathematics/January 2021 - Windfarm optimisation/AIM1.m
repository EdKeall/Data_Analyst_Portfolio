%% maximising power output
c=[8 5];
% constraints Ax =< b
A = [ 0.25*1.367*pi , 0.25*0.906*pi ; 4,2.5 ; -1,0 ; 0,-1 ] ;
b = [196 ; 1500 ; 0 ; 0] ;
intcon= [1 2];
[x, fval]=intlinprog(-c,intcon,A,b);
disp(x)
disp(-fval)


%% maximising power output and minimising cost
% X_1 is the number of turbines of type 1
% X_2 is the number of turbines of type 2
% objective functions
fun = @(X)[ X*[-8; -5]; X*[4; 2.5] ] ;
goal = [-1000;1500] ;
weight = [1;10] ;
% constraints Ax =< b
A = [ 0.25*1.367*pi,0.25*0.906*pi ; -1,0 ; 0,-1 ] ;
b = [196 ; 0 ; 0] ;
%initial point
x0 = [0,0] ;
[X1,fval] = fgoalattain(fun,x0,goal,weight,A,b) ;
disp(X1)
%disp(fval)

%%
