import React from 'react';

class Calculator extends React.Component{
  constructor(props){
    super(props);
    //your code here

    this.state = { input1: "", input2: "", result: 0 }
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.clearInput = this.clearInput.bind(this);
    this.add = this.add.bind(this)
    this.subtract = this.subtract.bind(this)
    this.multiply = this.multiply.bind(this)
    this.divide = this.divide.bind(this)
  }

  setNum1(e){
    const valStr = e.currentTarget.value;
    this.setState( {input1: valStr} );

  }

  setNum2(e){
    const valStr = e.currentTarget.value;
    this.setState( {input2: valStr} );

  }

  clearInput(e){
    this.setState({ input1:"", input2:"", result:0 });
  }

  add(e){
    const ints = this.parseInts();
    this.setState({ result: ints[0] + ints[1] });

  }

  subtract(){
    const ints = this.parseInts();
    this.setState({ result: ints[0] - ints[1] });
  }

  multiply(){
    const ints = this.parseInts();
    this.setState({ result: ints[0] * ints[1] });
  }

  divide(){
    const ints = this.parseInts();
    if (ints[1] === 0){
      this.setState({ result: "Infinity" });

    }
    else{
      this.setState({ result: ints[0] / ints[1] });
    }
  }

  parseInts(){
    const int1 = parseInt(this.state.input1) || 0;// if couldn't parse int assign 0 to this int...
    const int2 = parseInt(this.state.input2) || 0;
    return[int1, int2];
  }

  //your code here

  render(){
    const {input1, input2, result} = this.state;
    return (
      <div>
        <h1>{result}</h1>
        <input type="text" onChange={this.setNum1} value={input1}/>
        <input type="text" onChange={this.setNum2} value={input2}/>
        <button onClick={this.clearInput}>Clear</button>
        <br/>

        <button onClick={this.add}>+</button>
        <button onClick={this.subtract}>-</button>
        <button onClick={this.multiply}>*</button>
        <button onClick={this.divide}>/</button>

      </div>
    );
  }
}

export default Calculator;
