function bert11(block)
%BERT11 based on 
%MSFUNTMPL_BASIC A Template for a Level-2 MATLAB S-Function
%   The MATLAB S-function is written as a MATLAB function with the
%   same name as the S-function. Replace 'msfuntmpl_basic' with the 
%   name of your S-function.

%   Copyright 2003-2018 The MathWorks, Inc.

%%%
%%% The setup method is used to set up the basic attributes of the
%%% S-function such as ports, parameters, etc. Do not add any other
%%% calls to the main body of the function.
%%%
setup(block);

%endfunction

%%% Function: setup ===================================================
%%% Abstract:
%%%   Set up the basic characteristics of the S-function block such as:
%%%   - Input ports
%%%   - Output ports
%%%   - Dialog parameters
%%%   - Options
%%%
%%%   Required         : Yes
%%%   C MEX counterpart: mdlInitializeSizes
%%%
function setup(block)

% Register number of ports
block.NumInputPorts  = 3;
block.NumOutputPorts = 3;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
% block.InputPort(1).Dimensions  = 1;
% block.InputPort(1).DatatypeID  = 0;  % double
% block.InputPort(1).Complexity  = 'Real';

block.InputPort(1).DirectFeedthrough = false;
block.InputPort(2).DirectFeedthrough = false;
block.InputPort(3).DirectFeedthrough = false;

% Override output port properties
% block.OutputPort(1).Dimensions  = 1;
% block.OutputPort(1).DatatypeID  = 0; % double
% block.OutputPort(1).Complexity  = 'Real';

block.OutputPort(1).SamplingMode = 'Sample';
block.OutputPort(2).SamplingMode = 'Sample';
block.OutputPort(3).SamplingMode = 'Sample';


% Register parameters
block.NumDialogPrms     = 0;

% Register sample times
%  [0 offset]            : Continuous sample time
%  [positive_num offset] : Discrete sample time
%
%  [-1, 0]               : Inherited sample time
%  [-2, 0]               : Variable sample time
block.SampleTimes = [-1 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'CustomSimState',  < Has GetSimState and SetSimState methods
%    'DisallowSimState' < Error out when saving or restoring the model sim state
block.SimStateCompliance = 'DefaultSimState';

%%% -----------------------------------------------------------------
%%% The MATLAB S-function uses an internal registry for all
%%% block methods. You should register all relevant methods
%%% (optional and required) as illustrated below. You may choose
%%% any suitable name for the methods and implement these methods
%%% as local functions within the same file. See comments
%%% provided for each function for more information.
%%% -----------------------------------------------------------------

block.RegBlockMethod('SetInputPortSamplingMode',@DoSetInputPortSamplingMode);
block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);     % Required
block.RegBlockMethod('Update', @Update);
% block.RegBlockMethod('Derivatives', @Derivatives);
% block.RegBlockMethod('Terminate', @Terminate); % Required

%end setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DoSetInputPortSamplingMode(s, port, mode)
s.InputPort(port).SamplingMode = mode;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% PostPropagationSetup:
%%%   Functionality    : Setup work areas and state variables. Can
%%%                      also register run-time methods here
%%%   Required         : No
%%%   C MEX counterpart: mdlSetWorkWidths
%%%
function DoPostPropSetup(block)

  %setup Dwork
  N = 2047;
  block.NumDworks = 6;
  
  % initialize the first Dwork vector
  block.Dwork(1).Name            = 'A';
  block.Dwork(1).Dimensions      = N;
  block.Dwork(1).DatatypeID      = 0;      % double
  block.Dwork(1).Complexity      = 'Real'; % real
  block.Dwork(1).UsedAsDiscState = true;
  
  % initialize the second Dwork vector
  block.Dwork(2).Name            = 'T';
  block.Dwork(2).Dimensions      = 1;
  block.Dwork(2).DatatypeID      = 0;      % double
  block.Dwork(2).Complexity      = 'Real'; % real
  block.Dwork(2).UsedAsDiscState = true;
  
  % initialize the third Dwork vector
  block.Dwork(3).Name            = 'E';
  block.Dwork(3).Dimensions      = 1;
  block.Dwork(3).DatatypeID      = 0;      % double
  block.Dwork(3).Complexity      = 'Real'; % real
  block.Dwork(3).UsedAsDiscState = true;
  
  % initialize the fourth Dwork vector
  block.Dwork(4).Name            = 'bitCount';
  block.Dwork(4).Dimensions      = 1;
  block.Dwork(4).DatatypeID      = 0;      % double
  block.Dwork(4).Complexity      = 'Real'; % real
  block.Dwork(4).UsedAsDiscState = true;
  
  % initialize the fifth Dwork vector
  block.Dwork(5).Name            = 'bertEnable';
  block.Dwork(5).Dimensions      = 1;
  block.Dwork(5).DatatypeID      = 0;      % double
  block.Dwork(5).Complexity      = 'Real'; % real
  block.Dwork(5).UsedAsDiscState = true;
  
  % initialize the fifth Dwork vector
  block.Dwork(6).Name            = 'PN';
  block.Dwork(6).Dimensions      = N;
  block.Dwork(6).DatatypeID      = 0;      % double
  block.Dwork(6).Complexity      = 'Real'; % real
  block.Dwork(6).UsedAsDiscState = false;

% end DoPostPropSetup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% InitializeConditions:
%%%   Functionality    : Called at the start of simulation and if it is 
%%%                      present in an enabled subsystem configured to reset 
%%%                      states, it will be called when the enabled subsystem
%%%                      restarts execution to reset the states.
%%%   Required         : No
%%%   C MEX counterpart: mdlInitializeConditions
%%%
function InitializeConditions(block)

%end InitializeConditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Start:
%%%   Functionality    : Called once at start of model execution. If you
%%%                      have states that should be initialized once, this 
%%%                      is the place to do it.
%%%   Required         : No
%%%   C MEX counterpart: mdlStart
%%%
function Start(block)

N = 2047;

% initialize Dwork
block.Dwork(1).Data = zeros(1,N);
block.Dwork(2).Data = 0;
block.Dwork(3).Data = 0;
block.Dwork(4).Data = 0;
block.Dwork(5).Data = 0;


block.Dwork(6).Data = [1 -1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1  ...
-1 -1 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 1  ...
-1 1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 1 -1 1  ...
-1 -1 -1 -1 -1 1 1 1 -1 -1 1 -1 -1 -1 1 1  ...
-1 1 1 1 -1 1 -1 1 1 1 -1 1 -1 1 -1 -1  ...
-1 1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 1 -1  ...
-1 1 -1 -1 -1 1 -1 1 -1 1 1 -1 1 -1 1 -1  ...
-1 -1 -1 1 1 -1 -1 -1 -1 1 -1 -1 1 1 1 1  ...
-1 -1 1 -1 1 1 1 -1 -1 1 1 1 -1 -1 1 -1  ...
1 1 1 1 -1 1 1 1 -1 -1 1 -1 -1 1 -1 1  ...
-1 1 1 1 -1 1 1 -1 -1 -1 -1 1 -1 1 -1 1  ...
1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 1 1 -1 1  ...
-1 -1 1 -1 -1 1 -1 1 -1 -1 1 1 -1 1 1 -1  ...
-1 -1 1 1 1 1 -1 1 1 1 -1 1 1 -1 -1 1  ...
-1 1 -1 1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 1  ...
-1 -1 1 1 -1 -1 -1 -1 1 -1 1 1 1 1 1 -1  ...
-1 1 -1 -1 1 -1 -1 -1 1 1 1 -1 1 1 -1 1  ...
-1 1 1 -1 1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1  ...
1 1 1 -1 1 1 1 1 -1 1 1 -1 1 -1 1 -1  ...
-1 1 -1 1 1 -1 -1 -1 -1 1 1 -1 -1 1 1 1  ...
-1 -1 1 1 1 1 1 1 -1 1 1 1 1 -1 -1 -1  ...
-1 1 -1 1 -1 -1 1 1 -1 -1 1 -1 -1 -1 1 1  ...
1 1 1 1 -1 1 -1 1 1 -1 -1 -1 -1 1 -1 -1  ...
-1 1 1 1 -1 -1 1 -1 1 -1 1 1 -1 1 1 1  ...
-1 -1 -1 -1 1 1 -1 1 -1 1 1 -1 -1 1 1 1  ...
-1 -1 -1 1 1 1 1 1 -1 1 1 -1 1 1 -1 -1  ...
-1 1 -1 1 1 -1 1 1 1 -1 1 -1 -1 1 1 -1  ...
1 -1 1 -1 -1 1 1 1 1 -1 -1 -1 -1 1 1 1  ...
-1 -1 1 1 -1 -1 1 1 -1 1 1 1 1 1 1 1  ...
1 1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 1 -1  ...
-1 -1 -1 -1 1 -1 1 1 -1 1 -1 -1 -1 1 -1 -1  ...
1 1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 -1 -1  ...
-1 -1 1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 -1  ...
1 1 1 1 1 -1 -1 -1 1 1 1 -1 -1 -1 1 1  ...
-1 1 1 -1 1 1 -1 1 1 1 -1 1 1 -1 1 1  ...
-1 1 -1 1 -1 1 1 -1 1 1 -1 -1 -1 -1 -1 1  ...
1 -1 1 1 1 -1 -1 -1 1 1 1 -1 1 -1 1 1  ...
-1 1 1 -1 1 -1 -1 -1 1 1 -1 1 1 -1 -1 1  ...
-1 1 1 1 -1 1 1 1 1 -1 -1 1 -1 1 -1 1  ...
-1 -1 1 1 1 -1 -1 -1 -1 -1 1 1 1 -1 1 1  ...
-1 -1 -1 1 1 -1 1 -1 1 1 1 -1 1 1 1 -1  ...
-1 -1 1 -1 1 -1 1 -1 1 1 -1 1 -1 -1 -1 -1  ...
-1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 1 1 1 1  ...
-1 1 -1 -1 1 1 -1 -1 -1 1 -1 -1 1 1 1 1  ...
1 -1 1 -1 1 1 1 -1 -1 -1 1 -1 -1 -1 1 -1  ...
1 1 -1 1 -1 1 -1 1 -1 -1 1 1 -1 -1 -1 -1  ...
-1 -1 1 1 1 1 1 -1 -1 -1 -1 1 1 -1 -1 -1  ...
1 1 -1 -1 1 1 1 1 -1 1 1 1 1 1 1 -1  ...
-1 1 -1 1 -1 -1 -1 -1 1 1 1 -1 -1 -1 1 -1  ...
-1 1 1 -1 1 1 -1 1 -1 1 1 1 1 -1 1 1  ...
-1 -1 -1 1 -1 -1 1 -1 1 1 1 -1 1 -1 1 1  ...
-1 -1 1 -1 1 -1 -1 -1 1 1 1 1 -1 -1 -1 1  ...
-1 1 1 -1 -1 1 1 -1 1 -1 -1 1 1 1 1 1  ...
1 -1 -1 1 1 1 -1 -1 -1 -1 1 1 1 1 -1 1  ...
1 -1 -1 1 1 -1 -1 1 -1 1 1 1 1 1 1 1  ...
1 -1 -1 1 -1 -1 -1 -1 -1 -1 1 1 1 -1 1 -1  ...
-1 -1 -1 1 1 -1 1 -1 -1 1 -1 -1 1 1 1 -1  ...
-1 1 1 -1 1 1 1 -1 1 1 1 1 1 -1 1 -1  ...
1 -1 1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 1 -1 1  ...
-1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 1 -1 -1 1  ...
-1 1 -1 -1 -1 1 -1 1 1 -1 -1 -1 1 -1 1 -1  ...
-1 1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1 -1 -1  ...
1 -1 1 1 -1 1 -1 -1 1 1 -1 -1 1 1 -1 -1  ...
1 1 1 1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1  ...
-1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 -1 -1 1 1 1  ...
1 -1 -1 -1 -1 -1 1 1 -1 -1 1 1 -1 -1 -1 1  ...
1 1 1 1 1 1 1 -1 1 1 -1 -1 -1 -1 -1 -1  ...
1 -1 1 1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1  ...
-1 -1 1 -1 1 1 -1 -1 1 1 1 1 -1 -1 1 1  ...
1 1 1 -1 -1 1 1 1 1 -1 -1 -1 1 1 1 1  ...
-1 -1 1 1 -1 1 1 -1 -1 1 1 1 1 1 -1 1  ...
1 1 1 1 -1 -1 -1 1 -1 1 -1 -1 -1 1 1 -1  ...
1 -1 -1 -1 1 -1 1 1 1 -1 -1 1 -1 1 -1 -1  ...
1 -1 1 1 1 -1 -1 -1 1 1 -1 -1 1 -1 1 1  ...
-1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 -1 -1 1  ...
1 1 1 1 -1 -1 1 -1 1 1 -1 -1 -1 1 1 1  ...
-1 -1 1 1 1 -1 1 1 -1 1 1 1 1 -1 1 -1  ...
1 1 -1 1 -1 -1 1 -1 -1 -1 1 1 -1 -1 1 1  ...
-1 1 -1 1 1 1 1 1 1 1 -1 -1 -1 1 -1 -1  ...
-1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 1 1 1 -1  ...
-1 -1 -1 1 -1 1 1 -1 1 1 -1 -1 1 -1 -1 1  ...
1 -1 1 1 1 1 -1 1 1 1 1 -1 1 -1 -1 1  ...
-1 1 -1 -1 1 -1 -1 1 1 -1 -1 -1 1 1 -1 1  ...
1 1 1 1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 1  ...
-1 1 -1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1  ...
-1 1 -1 -1 -1 1 1 1 1 -1 1 -1 1 -1 1 1  ...
-1 -1 1 -1 -1 -1 -1 -1 1 1 1 1 -1 1 -1 -1  ...
-1 1 1 -1 -1 1 -1 -1 1 -1 1 1 1 1 1 -1  ...
1 1 -1 -1 1 -1 -1 -1 1 -1 1 1 1 1 -1 1  ...
-1 1 -1 -1 1 -1 -1 1 -1 -1 -1 -1 1 1 -1 1  ...
1 -1 1 -1 -1 1 1 1 -1 1 1 -1 -1 1 1 1  ...
-1 1 -1 1 1 1 1 1 -1 1 -1 -1 -1 1 -1 -1  ...
-1 1 -1 -1 1 -1 1 -1 1 -1 1 -1 1 1 -1 -1  ...
-1 -1 -1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1 1  ...
1 -1 1 1 -1 -1 -1 -1 1 1 1 -1 1 1 1 -1  ...
-1 1 1 -1 1 -1 1 -1 1 1 1 1 1 -1 -1 -1  ...
-1 -1 1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 -1 1  ...
1 1 1 -1 1 -1 -1 -1 -1 1 -1 -1 1 -1 -1 1  ...
-1 -1 1 -1 1 1 -1 1 1 -1 1 1 -1 -1 1 1  ...
-1 1 1 -1 1 1 1 1 1 1 -1 1 1 -1 1 -1  ...
-1 -1 -1 1 -1 1 1 -1 -1 1 -1 -1 1 -1 -1 1  ...
1 1 1 -1 1 1 -1 1 1 1 -1 -1 1 -1 1 1  ...
-1 1 -1 1 1 1 -1 -1 1 1 -1 -1 -1 1 -1 1  ...
1 1 1 1 1 -1 1 -1 -1 1 -1 -1 -1 -1 1 -1  ...
-1 1 1 -1 1 -1 -1 1 -1 1 1 1 1 -1 -1 1  ...
1 -1 -1 1 -1 -1 1 1 1 1 1 1 1 -1 1 1  ...
1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 -1 -1 -1 1  ...
-1 -1 -1 -1 1 1 1 -1 1 -1 1 -1 -1 1 1 -1  ...
1 -1 -1 -1 -1 1 1 1 1 -1 -1 1 -1 -1 1 1  ...
-1 -1 1 1 1 -1 1 1 1 1 1 1 1 -1 1 -1  ...
1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 1  ...
-1 1 -1 -1 1 -1 1 -1 1 -1 -1 -1 1 1 -1 -1  ...
-1 -1 -1 1 -1 1 1 1 1 -1 -1 -1 1 -1 -1 1  ...
-1 -1 1 1 -1 1 -1 1 1 -1 1 1 1 1 -1 -1  ...
-1 1 1 -1 1 -1 -1 1 1 -1 1 1 1 -1 -1 1  ...
1 1 1 -1 1 -1 1 1 1 1 -1 -1 1 -1 -1 -1  ...
1 -1 -1 1 1 1 -1 1 -1 1 -1 1 1 1 -1 1  ...
-1 -1 -1 -1 -1 1 -1 1 -1 -1 1 -1 -1 -1 1 -1  ...
-1 -1 1 1 -1 1 -1 1 -1 1 -1 1 1 1 -1 -1  ...
-1 -1 -1 -1 -1 1 -1 1 1 -1 -1 -1 -1 -1 1 -1  ...
-1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1 -1  ...
1 -1 -1 1 -1 1 -1 1 1 -1 -1 1 1 -1 -1 -1  ...
-1 1 1 1 1 1 1 1 -1 -1 1 1 -1 -1 -1 -1  ...
-1 1 1 1 1 1 1 -1 -1 -1 1 1 -1 -1 -1 -1  ...
1 1 -1 1 1 1 1 -1 -1 1 1 1 -1 1 -1 -1  ...
1 1 1 1 -1 1 -1 -1 1 1 1 -1 -1 1 -1 -1  ...
1 1 1 -1 1 1 1 -1 1 1 1 -1 1 -1 1 -1  ...
1 -1 1 -1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ];

%end Start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Outputs:
%%%   Functionality    : Called to generate block outputs in
%%%                      simulation step
%%%   Required         : Yes
%%%   C MEX counterpart: mdlOutputs
%%%
function Outputs(block)

bertEnable = block.Dwork(5).Data;

if bertEnable ~= 0
    
    N = 2047;
    
    A = block.Dwork(1).Data;
    T = block.Dwork(2).Data;
    E = block.Dwork(3).Data;
    PN = block.Dwork(6).Data;
    
    b = block.InputPort(1).Data;
    a = 2*b-1;
    
    A(1:N-1) = A(2:N);
    A(N) = a;
    
    temp = PN'*A;
    if temp >= 1639
        e = (N-temp)/2;
        E = E + e;
        T = T + N;
        block.OutputPort(1).Data = E;
        block.OutputPort(2).Data = T;
        block.OutputPort(3).Data = E/T;
    end
    
    b = block.InputPort(2).Data;
    a = 2*b-1;
    
    A(1:N-1) = A(2:N);
    A(N) = a;
    
    temp = PN'*A;
    if temp >= 1639
        e = (N-temp)/2;
        E = E + e;
        T = T + N;
        block.OutputPort(1).Data = E;
        block.OutputPort(2).Data = T;
        block.OutputPort(3).Data = E/T;
    end
    
    block.Dwork(1).Data = A;
    block.Dwork(2).Data = T;
    block.Dwork(3).Data = E;
end

%end Outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Update:
%%%   Functionality    : Called to update discrete states
%%%                      during simulation step
%%%   Required         : No
%%%   C MEX counterpart: mdlUpdate
%%%
function Update(block)

bitCount = block.Dwork(4).Data;
bertEnable = block.Dwork(5).Data;


if bertEnable == 0
    bitCount = bitCount + 2;
    if bitCount > block.InputPort(3).Data
        bertEnable = 1;
    end
end

block.Dwork(4).Data = bitCount;
block.Dwork(5).Data = bertEnable;

%end Update
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%
%%% Derivatives:
%%%   Functionality    : Called to update derivatives of
%%%                      continuous states during simulation step
%%%   Required         : No
%%%   C MEX counterpart: mdlDerivatives
%%%
%function Derivatives(block)

%end Derivatives

%%%
%%% Terminate:
%%%   Functionality    : Called at the end of simulation for cleanup
%%%   Required         : Yes
%%%   C MEX counterpart: mdlTerminate
%%%
%function Terminate(block)

%end Terminate

