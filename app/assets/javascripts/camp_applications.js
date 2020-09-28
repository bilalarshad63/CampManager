function auto_update_user()
{
	var first_name = $("#first-name").val();
	var middle_name = $("#middle-name").val();
	var last_name = $("#last-name").val();
	var email = $("#email").val();
	var phone_number = $("#phone-number").val();
	var date_of_birth = $("#date-of-birth").val();
	console.log()
	if($("#gender-man").val())
	{	var gender='man' }
	else if($("#gender-women").val()) 
	{	var gender='women' }
	else if($("#gender-other").val()) 
	{	var gender='other' }

	var form_data = {first_name: first_name, middle_name: middle_name, last_name: last_name,
 		email: email, phone_number: phone_number, date_of_birth: date_of_birth, gender: gender}
 	console.log(form_data);
 	$.post('auto_save', { user: form_data} , function(result){
 			console.log(result);
 		});
}

   
function auto_update_camp_application()
{
	var education = $("#education").val();
	var camp_preferences = $("#camp-preferences").val();
	var technology_requirements = $("#technology-requirements").val();
	var social_media = $("#social-media").val();

	var form_data = {education: education, camp_preferences: camp_preferences, technology_requirements: technology_requirements,
		social_media: social_media}
 	console.log(form_data);
 	$.post('auto_save', { camp_application: form_data} , function(result){
 			console.log(result);
 		});	
}

