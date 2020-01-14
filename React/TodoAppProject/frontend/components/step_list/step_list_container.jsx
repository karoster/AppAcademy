import StepList from './step_list';
import { connect } from 'react-redux';
import { receiveStep } from '../../actions/step_actions'

import { stepsByTodoId } from "../../reducers/selectors";



const mapStateToProps = (state, { todo_id }) => ({
    steps: stepsByTodoId(state.steps, todo_id),

});

const mapDispatchToProps = (dispatch) => ({
    receiveStep: (step) => dispatch(receiveStep(step))
});

export default connect(mapStateToProps, mapDispatchToProps)(StepList)