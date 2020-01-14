document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });



  // adding SF places as list items
const addFavorite = (e) => {
  e.preventDefault();
  const favoriteUl = document.getElementById("sf-places");
  const favoriteInputs = document.getElementsByClassName("favorite-input");
  const li = document.createElement("li");

  li.textContent = favoriteInputs[0].value;

  favoriteInputs[0].value = "";
  favoriteUl.appendChild(li);
}


const els = document.getElementsByClassName("favorite-submit")[0].addEventListener("click", addFavorite);


  

// --- your code here!

const showNewPhotoForm = (e) => {
  const photoForm = document.getElementsByClassName("photo-form-container")[0];
  if (photoForm.className === "photo-form-container hidden"){
    photoForm.className = "photo-form-container";

  } else{
    photoForm.className = "photo-form-container hidden";

  }


}

const showButton = document.getElementsByClassName("photo-show-button")[0];
showButton.addEventListener("click", showNewPhotoForm);


// adding new photos



// --- your code here!

const addNewPhoto = (e) => {
  e.preventDefault();

  const photoInput = document.getElementsByClassName("photo-url-input")[0];
  const dogPhotoUl = document.getElementsByClassName("dog-photos")[0];

  const newLi = document.createElement('li');
  const image = document.createElement("img");
  image.src = photoInput.value;
  photoInput.value = "";

  newLi.appendChild(image);
  dogPhotoUl.appendChild(newLi);

} 
const addPhoto = document.getElementsByClassName("photo-url-submit")[0];
addPhoto.addEventListener("click", addNewPhoto)



});
