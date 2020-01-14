import StepListItem from './step_list_item';
import { connect } from 'react-redux';
import { receiveStep, removeStep } from '../../actions/step_actions'

const mapDispatchToProps = (dispatch) => ({
    removeStep: (id) => dispatch(removeStep(id)),
    receiveStep: (step) => dispatch(receiveStep(step))

});

export default connect(null, mapDispatchToProps)(StepListItem);