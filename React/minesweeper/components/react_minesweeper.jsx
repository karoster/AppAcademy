import React from "react"
import ReactDOM from "react-dom"
import Game from "./game"

document.addEventListener("DOMContentLoaded", ()=>{
    ReactDOM.render(
    <div>
        <h1>Minesweeper</h1>
        <p>Click to explore a tile</p>
        <p>Alt+Click to flag a tile</p>
        <Game/>
    </div>
    ,document.getElementById('main'))

})