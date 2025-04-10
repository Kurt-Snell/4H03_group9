function Q2 = plscrossval(x,y,A,G)

K = size(x,2);
M = size(y,2);
data_all = [x y];
Q2 = zeros(1,A);

for a=1:A
    PRESS = 0;
    for g=1:G
        % split into training and testing data with G=g
        xy_rand = data_all(randperm(size(data_all,1)),:);
        split_location = round(size(xy_rand,1)*0.75);
        x_tr = xy_rand(1:split_location,1:K);
        x_te = xy_rand(split_location+1:end,1:K);
        y_tr = xy_rand(1:split_location,K+1:end);
        y_te = xy_rand(split_location+1:end,K+1:end);
    
        % build model with training data and A components 
        [t, u, w_star, w, c, p, R2] = nipalspls(x_tr,y_tr,A);
    
        % predict new points from testing data
        y_hat_new = zeros(length(y_te),M);
        for i=1:length(y_te)
            y_hat_new(i,:) = x_te(i,:)*w_star*c';
        end
    
        % calculate error
        E_new = y_te - y_hat_new;
    
        % add new E to press
        PRESS = PRESS + sum(E_new.^2);
    end
    % calculate Q2
    denom = sum((y_te - mean(y_te)).^2);
    Q2(a) = 1 - PRESS/denom;
end