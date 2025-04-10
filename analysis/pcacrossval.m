function Q2 = pcacrossval(x,A,G)

K = size(x,2);
Q2 = zeros(1,A);

for a=1:A
    PRESS = 0;
    for g=1:G
        % split into training and testing data with G=g
        x_rand = x(randperm(size(x,1)),:);
        split_location = round(size(x,1)*0.75);
        x_tr = x_rand(1:split_location,:);
        x_te = x_rand(split_location+1:end,:);
    
        % build model with training data and A components 
        [t,p,r2] = nipalspca(x_tr,a);
    
        % predict new points from testing data
        t_new = zeros(length(x_te),a);
        x_hat_new = zeros(length(x_te),K);
        for i=1:length(x_te)
            t_new(i,:) = x_te(i,:)*p;
            x_hat_new(i,:) = t_new(i,:)*p';
        end
    
        % calculate error
        E_new = x_te - x_hat_new;
    
        % add new E to press
        PRESS = PRESS + sum(E_new.^2);
    end
    % calculate Q2
    denom = sum((x_te - mean(x_te)).^2);
    Q2(a) = 1 - PRESS/denom;
end