%
% Copyright 2019 The MathWorks, Inc.
%
function err_vec = compareData(reference,actual,figure_number,textstring)

% Vector input only
if ~isvector(reference) || ~isvector(actual)
    error('Input signals must be vector');
else
    if isrow(reference)
        reference = transpose(reference);
    end
    if isrow(actual)
        actual = transpose(actual);
    end
end

% Make signals same length if necessary
if length(reference) ~= length(actual)
%     warning(['Length of reference (%d) is not the same as actual signal (%d).'...
%         ' Truncating the longer input.'],length(reference),length(actual));
    len = 1:min(length(reference),length(actual));
    reference = reference(len);
    actual = actual(len);
end

% Turn complex into vector
if xor(isreal(reference),isreal(actual))
    error('Input signals are not both real or both complex');
elseif ~isreal(reference)
    ref_vec = double([real(reference) imag(reference)]);
    act_vec = double([real(actual) imag(actual)]);
    tag = {'(Real)','(Imag)'};
else
    ref_vec = double(reference);
    act_vec = double(actual);
    tag = {''};
end

% Configure figure
if iscell(figure_number)
    if size(ref_vec,2) > 1 % complex
        error('Cannot yet subplot multiple complex inputs');
    else
        figure(figure_number{1})
    end
else
    figure(figure_number)
end
c = get(groot,'defaultAxesColorOrder');

% Compute error
err_vec = ref_vec - act_vec;
max_err = max(abs(err_vec));
max_ref = max(abs(ref_vec));
fprintf('\nMaximum error for %s out of %d values\n',textstring,length(actual));


for n = 1:size(ref_vec,2)
    fprintf('%s %d (absolute), %d (percentage)\n',tag{n},max_err(n),max_err(n)/max_ref(n)*100);
    if iscell(figure_number)
        total_plot = figure_number{2};
        plot_num = figure_number{3};
    else
        total_plot = size(ref_vec,2);
        plot_num = n;
    end
    subplot(total_plot,1,plot_num)
    plot(ref_vec(:,n),'Color',c(3,:));
    hold on
    plot(act_vec(:,n),'Color',c(1,:));
    plot(err_vec(:,n),'Color',c(2,:));
    legend('Reference','Actual','Error')
    hold off
    title(sprintf('%s %s, max error = %.3d',textstring,tag{n},max_err(n)));
end
end
