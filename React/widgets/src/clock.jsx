import React from 'react';

class Clock extends React.Component{

    constructor(props){
        // this.date = new Date()
        super(props);
        this.state = { time: new Date() };

        this.tick = this.tick.bind(this);
    }

    tick(){
        this.setState({ time: new Date() });
    }
    

    componentDidMount(){
        const timerObj = setInterval(this.tick, 1000);
        this.timerId = timerObj._id;
    }

    componentWillUnmount(){
        clearInterval(this.timerId);
        this.timerId = null;
    }

    render(){
        const time = this.state.time;
        return (
            <div>
                <h1>Clock</h1>
                <section className="clock-display">
                    <label htmlFor="time">Time:</label>
                    <p id="time grp">
                        {time.toTimeString()}:
                    </p>

                    <label htmlFor="date">Date:</label>
                    <p id="date grp">
                        {time.toDateString()} 

                    </p>
                </section>
            </div>
        );
    }

}
export default Clock;