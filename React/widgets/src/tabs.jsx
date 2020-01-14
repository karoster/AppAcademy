import React from 'react';


class Tabs extends React.Component{
    constructor(props){
        super(props);
        this.state = {selectedIndex: 0};


        this.changeTab = this.changeTab.bind(this);
    }

    componentDidMount(){
        const target = document.querySelector(".nav-tab li");
        target.classList.add('selected');

    }

    componentDidUpdate(){
        const target = document.querySelectorAll(".nav-tab li")[this.state.selectedIndex];
        const currSelected = document.getElementsByClassName('selected')[0];
        if(currSelected){
            currSelected.classList.remove('selected');
            target.classList.add('selected');
        }

    }


    changeTab(e){
        const target = e.currentTarget;
        this.setState({selectedIndex: target.id});
    }

    render(){
        const selectedIndex = this.state.selectedIndex
        return(
            
            <div>
                <h1>Tabs</h1>
                <div className="tabs">
                    <div className="nav-tab-background">
                        <ul className="nav-tab">
                            { this.props.tabList.map( (tab,idx) => <li key={idx} id={idx} onClick={this.changeTab}><h1>{tab.title}</h1></li> ) }
                        </ul>
                    </div>
                    <article className="tab-content">
                        { this.props.tabList[selectedIndex].content }
                    </article>
                </div>
            </div>

        );
    }

}

export default Tabs;