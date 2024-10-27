document.addEventListener('DOMContentLoaded', function() {
    var modal = document.getElementById("register-modal");
    var btn = document.getElementById("register-btn");
    var span = document.getElementsByClassName("close")[0];

    // Open the modal
    btn.onclick = function() {
        modal.style.display = "block";
    }

    // Close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // Close the modal if the user clicks outside of it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
