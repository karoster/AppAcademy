import {RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP} from '../actions/step_actions'



const initialState = {
    
    1: { // this is the step with id = 1
        id: 1,
        title: 'walk to store',
        done: false,
        todo_id: 1
    },

    2: { // this is the step with id = 2
        id: 2,
        title: 'buy soap',
        done: false,
        todo_id: 1
    }
}

const stepReducer = (state = initialState, action) => {
    switch(action.type){
        case RECEIVE_STEP:
            const dupedState = Object.assign({}, state);
            dupedState[action.step.id] = action.step;
            return(dupedState);

        case RECEIVE_STEPS:
            const stepHash = {};
            action.steps.forEach( (step) => stepHash[step.id] = step );
            return(stepHash);

        case REMOVE_STEP:
            const newState = Object.assign({}, state);
            delete newState[action.id];
            return newState;

        default:
            return state;
    }

}

export default stepReducer;
