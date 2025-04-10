function [T, U, W_star, W, C, P, R2] = nipalspls(x,y,A)

K = size(x,2);
N = size(x,1);
M = size(y,2);

% initialize matrices to store scores and loadings vectors
W = zeros(K,A);
T = zeros(N,A);
U = zeros(N,A);
C = zeros(M,A);
P = zeros(K,A);

x0 = x;
y0 = y;

for a = 1:A
    ua0 = y0(:,1);                      % choose first column of y for ua
    for i = 1:500
        wa = 1/(ua0'*ua0)*ua0'*x0;      % regress columns of Xa-1 onto ua
        wa = wa';
        wa = wa/norm(wa);               % normalize wa
        ta = 1/(wa'*wa)*x0*wa;          % regress rows of Xa-1 onto wa
        ca = 1/(ta'*ta)*ta'*y0;         % regress columns of Ya-1 onto ta
        ca = ca';
        ua = 1/(ca'*ca)*y0*ca;          % regress rows of Ya-1 onto ca
        if norm(ua - ua0) <= sqrt(eps)  % check convergence
            T(:,a) = ta;                % if converged, assign ta, wa, ua, ca to matrices and end loop
            W(:,a) = wa;
            U(:,a) = ua;
            C(:,a) = ca;
            break
        end
        ua0 = ua;                       % assign new ua to ua0 for next iteration
    end
    pa = 1/(ta'*ta)*x0'*ta;             % regress columns of Xa-1 onto ta to get loadings
    P(:,a) = pa;
    x0 = x0 - T(:,a)*P(:,a)';           % deflate Xa-1 to Xa
    y0 = y0 - T(:,a)*C(:,a)';           % deflate Ya-1 to Ya
end

W_star = W*(P'*W)^-1;                   % compute W_star

% calculate R2 for each additional component
R2 = zeros(1,A);

for a = 1:A
    y_pred = T(:,1:a)*C(:,1:a)';
    SSE = sum((y_pred - y).^2);
    denom = sum((y - mean(y)).^2);
    R2(a) = 1 - SSE/denom;
end




