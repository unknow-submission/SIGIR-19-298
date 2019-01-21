function [B, W] = train_OUR (X,T,L,A, nbits)

%Parameter Setting
Iter_num=5;
param_alpha=0.9;
param_beta=0.9;
param_theta=0.9;

% -----------use random to initialize -----------

% %%%%%% B - initialize %%%%%%%%%%%%%%%%%%%%%%%%
B=randn(size(X,1),nbits)>0;B=B*2-1;
% %%%%%% Z - initialize %%%%%%%%%%%%%%%%%%%%%%%%
Z=B;
% %%%%%% F - initialize %%%%%%%%%%%%%%%%%%%%%%%%
F=randn(size(X,1),nbits);
% %%%%%% W - initialize %%%%%%%%%%%%%%%%%%%%%%%%
W=X'*B;

%---------------------------- Training--------------------------------------------------------------
for iter=1:Iter_num
    
    
    fprintf('%d... ',iter);
    
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % ----------------------- F-step -----------------------%
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    fprintf('F-step... ');
    F_A=param_alpha*L; F_B=param_beta*Z'*Z; F_C=nbits*param_beta*T'*Z;
    F=lyap(F_A,F_B,-F_C);
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % ----------------------- Z-step -----------------------%
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    fprintf('Z-step... ');
    Z=(param_beta*nbits*T*F+param_theta*B)*inv(param_beta*F'*F+param_theta*eye(nbits));  
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % ----------------------- W-step -----------------------%
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    fprintf('W-step... ');
    W=A*B;
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % ----------------------- B-step -----------------------%
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    fprintf('B-step... \n');
    B=sign(param_theta*Z+X*W);
    
end

B=B>0;

end



