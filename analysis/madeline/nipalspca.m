function [T, P, R2] = nipalspca(x,A)

K = size(x,2);
N = size(x,1);

% initialize P and T matrices to store p and t vectors
P = zeros(K,A);
T = zeros(N,A);

x0 = x;

for a = 1:A
    ta0 = x(:,1);                      % choose first column of x for ta
    for i = 1:500
        pa = 1/(ta0'*ta0)*ta0'*x0;      % regress columns of Xa-1 onto ta
        pa = pa';
        pa = pa/norm(pa);               % normalize pa
        ta = 1/(pa'*pa)*x0*pa;          % regress rows of Xa-1 onto pa
        if norm(ta - ta0) <= sqrt(eps)  % check convergence
            P(:,a) = pa;                % if converged, assign pa and ta to matrices and end loop
            T(:,a) = ta;
            break
        end
        ta0 = ta;                       % assign new ta to ta0 for next iteration
    end
    x0 = x0 - T(:,a)*P(:,a)';           % deflate Xa-1 to Xa
end

% calculate R2 for each additional component
R2 = zeros(1,A);

for a = 1:A
    x_pred = T(:,1:a)*P(:,1:a)';
    SSE = sum((x_pred - x).^2);
    denom = sum((x - mean(x)).^2);
    R2(a) = 1 - SSE/denom;
end




