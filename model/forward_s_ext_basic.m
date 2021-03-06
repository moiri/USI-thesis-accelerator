%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% computation of the extended forward algorithm without scaling
%
% @param N:             number of states
% @param L:             number of observation symbols
% @param PI:            initial state probability vector. size N
% @param B:             matrix of emission probabilities. size N, L
% @param cdf_param:     parameters for the cdf
% @param oL:            indices of all observed symbols. size 1, L
% @param dL:            delays of all observed symbols. size 1, L
% @return Ps:           probability likelihood
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Ps] = forward_s_ext_basic(N, L, PI, B, cdf_param, oL, dL)
    % initialize forward variables
    for i=1:N,
        alpha(i) = PI(i)*B(i, oL(1));
    end
    % forward algorithm
    for k=2:L,
        % compute transistion probabilities
        tp = compute_tp(N, dL(k), cdf_param);
        for j=1:N,
            alpha_new(j) = 0;
            for i=1:N,
                alpha_new(j) += alpha(i) * tp(i, j);
            end
            alpha_new(j) *= B(j, oL(k));
        end
        alpha = alpha_new;
    end
    % compute likelihood
    Ps = 0;
    for i=1:N,
        Ps += alpha_new(i);
    end
end
