/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function validateForm() {
    var password = document.forms["register-form"]["password"].value;
    var repass = document.forms["register-form"]["repassword"].value;

    var i = 0;

    // Check validate password 
    const regexPassword = new RegExp('[a-zA-Z0-9]{8,16}');
    var passF = document.getElementById("passwordFail");
    if (regexPassword.test(password)) {
        passF.style.display = "none";
    } else {
        document.getElementById("passwordFail").innerHTML = "Invalid password";
        passF.style.display = "block";
        i++;
    }
//  Check match Re-password
    var rep = document.getElementById("repassFail");
    if (repass === password) {
        rep.style.display = "none";
    } else {
        document.getElementById("repassFail").innerHTML = "Password not match";
        rep.style.display = "block";
        i++;
    }
//////////////////////
    if (i == 0) {
        return true;
    } else {
        return false;
    }
}

