% ANALYZE_PERFORMANCE_BY_RAT provides summary statistics for each
% rat and each condition in BEHAVIOR_TABLE.CSV
function [] = analyze_performance_by_rat()
    add_folders_to_path;
    P = get_parameters;
    fprintf('Fetching protocol data...')
    T=readtable(P.behavior_table_path);    
    [~,idx] = sort(T.sessid);
    T = T(idx,:);
    sessids = concatenate_for_sql(T.sessid);
    [PD,fetched_sessids] =bdata(['select protocol_data, sessid from sessions s where s.sessid in (' sessids ')']);
    % make sure the elements of PD and rows of T are th same and in the
    % same order.
    [~,i_T, i_fetched] = intersect(T.sessid, fetched_sessids);
    T=T(i_T,:);
    PD = PD(i_fetched);
    fprintf(' done\n')
    fprintf('Removing trials and unnecessary fields and empty sessions...')
    for i = 1:numel(PD)
        PD{i} = remove_trials_from_pd(PD{i});
        PD{i}.pokedR = (PD{i}.sides == 'r' &  PD{i}.hits) | ...
                       (PD{i}.sides == 'l' & ~PD{i}.hits);
        PD{i} = rmfield(PD{i}, setdiff(fieldnames(PD{i}), {'n_left', 'n_right', 'pokedR', 'hits'}));
    end
    nonempty = cellfun(@(x) numel(x.pokedR), PD) > 0;
    PD = PD(nonempty);
    T = T(nonempty,:);
    fprintf(' done\n')
    fprintf('Fitting psychometric functions to each rat and tethering condition...')
    By_rat = struct;
    k = 0;
    unique_rat_names = unique(T.rat);
    for i = 1:numel(unique_rat_names)
        for tethered = [0,1]
            idx = strcmp(T.rat, unique_rat_names{i}) & ...
                  T.tethered == tethered;
            pd = cellfun(@struct2table, PD(idx), 'uni', 0);
            pd = vertcat(pd{:});
            Psych = fit_psychometric(pd);
            k = k + 1;
            By_rat.rat{k,1} = unique_rat_names{i};
            By_rat.tethered(k,1) = tethered;
            By_rat.sens(k,1) = Psych.sens;
            By_rat.bias(k,1) = Psych.bias;
            By_rat.gamma0(k,1) = Psych.gamma0;
            By_rat.gamma1(k,1) = Psych.gamma1;
            By_rat.lapse(k,1) = Psych.lapse;
            By_rat.n_trials(k,1) = size(pd,1);
            By_rat.prct_correct(k,1) = sum(pd.hits)/numel(pd.hits)*100;
            trials_done = cellfun(@(x) numel(x.hits), PD(idx));
            By_rat.trials_done(k,1) =nanmedian(trials_done);
        end
    end
    By_rat.abs_bias=abs(By_rat.bias);
    By_rat = struct2table(By_rat);
    writetable(By_rat, P.performance_by_rat_path);
    fprintf(' done\n')
end