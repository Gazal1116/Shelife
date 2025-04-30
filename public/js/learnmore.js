document.addEventListener("DOMContentLoaded", () => {
    const stars = document.querySelectorAll(".star");
    const reviewText = document.getElementById("review-text");
    const submitButton = document.getElementById("submit-review");
    const reviewOutput = document.getElementById("review-output");
    let rating = 0;

    stars.forEach(star => {
        star.addEventListener("click", () => {
            rating = star.getAttribute("data-value");
            updateStars();
        });
    });

    function updateStars() {
        stars.forEach(star => {
            if (star.getAttribute("data-value") <= rating) {
                star.classList.add("selected");
            } else {
                star.classList.remove("selected");
            }
        });
    }

    submitButton.addEventListener("click", () => {
        const review = reviewText.value;
        if (rating > 0 && review) {
            reviewOutput.innerHTML += <p>Rating: ${rating} Stars<br>Review: ${review}</p>;
            reviewText.value = '';
            rating = 0;
            updateStars();
        } else {
            alert("Please provide a rating and a review.");
        }
    });
});