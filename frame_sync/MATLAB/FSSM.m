%%%%%%%%%%%%%%%%%
% Frame Sync SM %
%%%%%%%%%%%%%%%%%

classdef FSSM
    properties
        currentState;
    end

    methods
        function self = init(self)
            self.currentState = FSSM_States.init_st;
        end

        function self = tick(self, newSample)
            % State updates
            switch self.currentState
                case FSSM_States.init_st

                case FSSM_States.coldStart_st
                
                case FSSM_States.onePeak_st
                
                case FSSM_States.twoPeaks_st
                
                case FSSM_States.locked_st
                
                case FSSM_States.onePeak_st
                
                case FSSM_States.twoPeaks_st
            end

            % State actions
            switch self.currentState
                case FSSM_States.init_st

                case FSSM_States.coldStart_st
                
                case FSSM_States.onePeak_st
                
                case FSSM_States.twoPeaks_st
                
                case FSSM_States.locked_st
                
                case FSSM_States.onePeak_st
                
                case FSSM_States.twoPeaks_st
            end
        end
    end
end


