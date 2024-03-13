function sendMail (){
  var params = {
    name: document.getElementById("nome").value ,
    email: document.getElementById("email").value ,
    message: document.getElementById("testo"). value ,
  };

const serviceID = "service_ao585bo";
const templeteID = "template_ymaapmx";

emailjs.send(serviceID, templeteID, params)
.then (
  res =>{
    document.getElementById("nome").value = "";
    document.getElementById("email").value = "";
    document.getElementById("testo").value = "";
    console.log (res);
    alert ("your message sent successfully")
  })

.catch (err=>console.log(err));
}