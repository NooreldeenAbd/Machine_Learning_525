% Initialize p and t
p = [1 2 3 1 2 4 ; 4 5 3.5 0.5 2 0.5];
t = [1 1 1 0 0 0];

% make initial gusses
W = [0 0];
b = 0;

% This block was debugging ***************
% pc = p(:,1);
% n = dot(W, pc) + b;
% a = hardlim(n);
% e = t(1) - a;
% W = W + e* transpose(pc);
% b = b + e;
% End of debugging block ****************

%initialize flag
flag = ones(1,6); 

while sum(flag) ~= 0
    
    % initialize flag
    flag = ones(1,6); 
    
    for k = 1:6  % based on number of points
        
        % Compute a and e
        pc = p(:,k);
        n = dot(W, pc) + b;
        a = hardlim(n);
        e = t(k) - a;
        
        if e == 0
            flag(k) = 0;
        end
        
        % Update W and b
        W = W + e* transpose(pc);
        b = b + e;
        
    end

end

% Plot decison boundary
x = -1:0.1:6;
y = (-W(1)*x -b)/W(2);
plot (x,y)
xlim([-1 6])


% Plot class 1
hold on
for k = 1:3
    pc = p(:,k);
    plot (pc(1), pc(2), 'x')
end 

% Plot class 2
hold on
for k = 4:6
    pc = transpose ( p(:,k));
    plot (pc(1), pc(2), 'o')    
end 

% Display final values
caption = sprintf('W1 = %d, W2 = %d, b = %d', W(1),W(2), b);
title(caption, 'FontSize', 12);

% %Quick check (should equal t matrix)
% for k = 1:6  
%         pc = p(:,k);
%         n = dot(W, pc) + b;
%         a = hardlim(n);
%         if a ~= t(k)
%             fprintf('Error: a%d \n', k,a)
%         end
%         fprintf('a%d = %d \n', k,a)
% end
