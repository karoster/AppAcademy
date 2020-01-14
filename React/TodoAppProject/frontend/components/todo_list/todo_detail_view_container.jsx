import TodoDetailView from './todo_detail_view';
import { connect } from 'react-redux';
import { removeTodo } from '../../actions/todo_actions' //receiveTodo, 
import { receiveSteps } from '../../actions/step_actions'



const mapDispatchToProps = (dispatch) => ({
    removeTodo: (id) => dispatch(removeTodo(id)),
    receiveSteps: (steps) => dispatch(receiveSteps(steps))
});

export default connect(null, mapDispatchToProps)(TodoDetailView);