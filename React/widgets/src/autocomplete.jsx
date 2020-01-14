import React from 'react';

class AutoComplete extends React.Component{
    constructor(props){
        super(props)
        this.state = { inputVal: ""}

        this.renderNames = this.renderNames.bind(this);
        this.inputChange = this.inputChange.bind(this);
    }

    renderNames(){
        const inputStart = this.state.inputVal;

        let names = this.props.names.map((nameObj, idx) => {
            const name = nameObj.name;

            if(name.startsWith(inputStart)){
                return( <li key={idx}>{name}</li> );
            }

        });
        return names;
    }

    inputChange(e){
        const target = e.currentTarget;
        this.setState({ inputVal: target.value });
    }

    render(){
        return(
            <div>
                <h1>AutoComplete:</h1>
                <section className="autocomplete">
                    <input onChange={this.inputChange} className="search-bar" type="text" placeholder="search..."/>
                    <ul className="name-list">
                        {this.renderNames()}
                    </ul>

                </section>
            </div>

        );
    }
}

export default AutoComplete;