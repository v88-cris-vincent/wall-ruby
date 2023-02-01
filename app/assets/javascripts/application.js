//= require jquery
console.log("asdfsadf")
$(document).ready( () => {
    $("#login_form").on("submit", function (e) {
        e.preventDefault();
        let form = $(this);

        $.post(form.attr("action"), $(form).serialize(), (data) => {
            if(data.status) {
                window.location = "/wall";
            }
            else {
                alert(data.error);
            }
        }, "");

        return false;
    });

    $("#registration_form").on("submit", function () {
        let form = $(this);

        $.post(form.attr("action"), $(form).serialize(), (data) => {
            if(data.status) {
                location.reload();
                alert("Successfully created");
            }
            else {
                alert(data.error);
            }
        }, "json");

        return false;
    });

    $("#message_post").on("submit", function () {
        let form = $(this);

        $.post(form.attr("action"), $(form).serialize(), (data) => {
            if(data.status) {
                location.reload();
                alert("Successfully post a message");
            }
            else {
                alert(data.error);
            }
        }, "json");

        return false;
    });


    $("#message_delete").on("submit", function () {
        let form = $(this);

        $.post(form.attr("action"), $(form).serialize(), (data) => {
            if(data.status) {
                location.reload();
                alert("Successfully delete a message");
            }
            else {
                alert(data.error);
            }
        }, "json");

        return false;
    });

    $("#comment_post").on("submit", function () {
        let form = $(this);

        $.post(form.attr("action"), $(form).serialize(), (data) => {
            if(data.status) {
                location.reload();
                alert("Successfully post a comment");
            }
            else {
                alert(data.error);
            }
        }, "json");

        return false;
    });


    $("#comment_delete").on("submit", function () {
        let form = $(this);

        $.post(form.attr("action"), $(form).serialize(), (data) => {
            if(data.status) {
                location.reload();
                alert("Successfully delete a comment");
            }
            else {
                alert(data.error);
            }
        }, "json");

        return false;
    });
});