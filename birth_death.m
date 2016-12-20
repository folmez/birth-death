function g = birth_death(N)
% g = BIRTH_DEATH(N) calculates survival times of the simple birth-death
% process. Process starts with one individual. At any point, one individual
% of the population gives birth to a new individual or dies, with equal
% probability. That is, when population is n, it becomes n+1 with
% probability 1/2 and n-1 with probability 1/2. Time between birth-death
% events is exponentially distributed random variable.
%
% This algorithm is originally written to analyse the results published in
% Font-Clos, Francesc, et al. "The perils of thresholding." New Journal of
% Physics 17.4 (2015): 043066.

% Simulation time tolerance for long bout lengths before restarting
sim_time_tol = 10;             

g = zeros(N,1); % survival times vector
progress = 0;
tSIM = tic;
for i = 1:N
    % Observation begins with 1 individual
    n = 1;    
    time = toc(tSIM);
    while n > 0
        ts = exprnd(1/n);           % time step
        g(i) = g(i)+ts;             % update survival time
        b = (randi(2,1)-1.5)*2;     % {-1,1} with equal probability
        n = n+b;                    % update # of individuals
        
        % Reset beyond tolerance
        if toc(tSIM)-time > sim_time_tol
            time = toc(tSIM);
            fprintf('Long bout alert at [%3.2fm]!\n', toc(tSIM)/60);
            fprintf('Population = %i\n', n);
            n = 1;
            g(i) = 0;
            fprintf('Resetted!\n');
        end
    end
    if rem(i, N/10)==0
        progress = progress+10;        
        fprintf('%%%i [%3.2fm]\n', progress, toc(tSIM)/60);
    end
end

% Plot approximate PDF of survival times
nr_bins = min(round(N*0.1), 5e1);
gbins = logspace(log10(min(g)), log10(max(g)+1e-10), nr_bins);
[gn, gx] = hist(g, gbins);
bin_lengths = [gx(2)-gx(1), gx(3:end)-gx(1:end-2), gx(end)-gx(end-1)]*0.5;
gn = (gn./bin_lengths)/N;
nis = find(gn);
figure
loglog(gx(nis), gn(nis), 'b.' , 'MarkerSize', 10);
xlabel('Time');
title(['N=' num2str(N) ' survival times'], 'FontSize', 20);
legend('Approximate probability density');
end
