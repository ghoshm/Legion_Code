function nGrams = n_gramsNumerical(dataVec, n)

% N_GRAMSNUMERICAL returns all of the n-grams in the numerical row vector
% dataVec.  Can be used instead of n_grams if data are not strings
%
% Input
%   dataVec - a row vector of numbers to be compressed
%   n       - the n in n-grams (also the number of columns in output
%             nGrams)
%
% Output
%   nGrams  - a length(dataVec) - n + 1 by n matrix containing all the
%             n-grams in dataVec
% 
% Copyright Medical Research Council 2013
% Andr? Brown, andre.brown@csc.mrc.ac.uk, aexbrown@gmail.com
% 
% 
% The MIT License
% 
% Copyright (c)  Medical Research Council 2015
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.



% check inputs
if size(dataVec, 1) ~= 1
    error('dataVec must be a row vector')
end

% make a matrix whose columns are the n-grams

% for small n, make the concatenation explicit since it runs much faster
% than the circshift version
switch n
    case 1
        nGrams = dataVec';
        return
    case 2 
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN]...
                  ];
    case 3
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN]...
                  ];
    case 4
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN];...
                  [dataVec(4:end) NaN NaN NaN]...
                  ];
    case 5
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN];...
                  [dataVec(4:end) NaN NaN NaN];...
                  [dataVec(5:end) NaN NaN NaN NaN]...
                  ];
    case 6
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN];...
                  [dataVec(4:end) NaN NaN NaN];...
                  [dataVec(5:end) NaN NaN NaN NaN];...
                  [dataVec(6:end) NaN NaN NaN NaN NaN]...
                  ];
    case 7
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN];...
                  [dataVec(4:end) NaN NaN NaN];...
                  [dataVec(5:end) NaN NaN NaN NaN];...
                  [dataVec(6:end) NaN NaN NaN NaN NaN];...
                  [dataVec(7:end) NaN NaN NaN NaN NaN NaN]...
                  ];
    case 8
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN];...
                  [dataVec(4:end) NaN NaN NaN];...
                  [dataVec(5:end) NaN NaN NaN NaN];...
                  [dataVec(6:end) NaN NaN NaN NaN NaN];...
                  [dataVec(7:end) NaN NaN NaN NaN NaN NaN];...
                  [dataVec(8:end) NaN NaN NaN NaN NaN NaN NaN]...
                  ];
    case 9
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN];...
                  [dataVec(4:end) NaN NaN NaN];...
                  [dataVec(5:end) NaN NaN NaN NaN];...
                  [dataVec(6:end) NaN NaN NaN NaN NaN];...
                  [dataVec(7:end) NaN NaN NaN NaN NaN NaN];...
                  [dataVec(8:end) NaN NaN NaN NaN NaN NaN NaN];...
                  [dataVec(9:end) NaN NaN NaN NaN NaN NaN NaN NaN]...
                  ];
    case 10
        nGrams = [dataVec;...
                  [dataVec(2:end) NaN];...
                  [dataVec(3:end) NaN NaN];...
                  [dataVec(4:end) NaN NaN NaN];...
                  [dataVec(5:end) NaN NaN NaN NaN];...
                  [dataVec(6:end) NaN NaN NaN NaN NaN];...
                  [dataVec(7:end) NaN NaN NaN NaN NaN NaN];...
                  [dataVec(8:end) NaN NaN NaN NaN NaN NaN NaN];...
                  [dataVec(9:end) NaN NaN NaN NaN NaN NaN NaN NaN];...
                  [dataVec(10:end) NaN NaN NaN NaN NaN NaN NaN NaN NaN]...
                  ];
    otherwise
        nGrams = NaN(n, length(dataVec));
        for ii = 1:n
            nGrams(n - ii + 1, :) = circshift(dataVec, [1, -(n - ii)]);
        end
        
end

% transpose nGrams
nGrams = nGrams';

% drop extra rows
nGrams = nGrams(1:end - n + 1, :);

