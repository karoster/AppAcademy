import React from 'react';
import { uniqueId } from '../../util/utils';

class StepForm extends React.Component{
    constructor(props){
        super(props);
        this.state = { title:"", description:"" };

        this.changeTitle = this.changeTitle.bind(this);
        this.changeDescription = this.changeDescription.bind(this);
        this.addStep = this.addStep.bind(this);
    }

    changeTitle(event){
        const input = event.currentTarget;
        this.setState({ title: input.value })
    }

    changeDescription(event){
        const input = event.currentTarget;
        this.setState({ description: input.value })

    }

    addStep(event){
        event.preventDefault()
        const stepObj = Object.assign({}, this.state);
        stepObj.id = uniqueId()
        this.props.receiveStep(stepObj);
        this.clearInputs();
        this.setState({ title: "", description: "" });
    }

    clearInputs(){
        document.getElementById('step-form-title').value = "";
        document.getElementById('step-form-description').value = "";
    }

    render(){
        return(
            <div>
                <label htmlFor="step-form-title">Title</label>
                <br/>
                <input onChange={this.changeTitle} id="step-form-title" type="text"/>
                <br/>
                <label htmlFor="step-form-description">Description</label>
                <br/>
                <input onChange={this.changeDescription} id="step-form-description" type="text"/>
                <br/>
                <input onClick={this.addStep} type="submit" value="Add Step"/>
                <br/>

            </div>
        );
    }

}

export default StepForm;