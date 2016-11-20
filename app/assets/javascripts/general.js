function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none"; 
    }
    slideIndex++;
    if (slideIndex > x.length) {slideIndex = 1} 
    x[slideIndex-1].style.display = "block"; 
    setTimeout(carousel, 2000); // Change image every 2 seconds
}


$(document).ready(function(){
	var data = {};
	
	$("#tournamentstatus").hide();

    $("#livetournaments tr").click(function(){
        var tournament = $(this).children("td#TName").text();
        console.log(tournament);
        $("#tournamentstatus").show();
        $('#tournamentstatus tr').not(':first').remove();
        var html = '';
        if (tournament==='Augusta'){
        	data.d = [{name: 'K.Lowry', score: '-2', hole: '6'}, 
          	 {name: 'J.Sullinger', score: '+1', hole: '7'},
             {name: 'D.Carroll', score: '+3', hole: '2'},
             {name: 'C.Joseph', score: '-4', hole: '11'},
             {name: 'N.Powell', score: '-6', hole: '14'}];
         } else if (tournament==='Loren Place'){
         			data.d = [{name: 'L.James', score: '-1', hole: '16'}, 
          	 {name: 'K.Irving', score: '-4', hole: '11'},
             {name: 'J.Smith', score: '+3', hole: '15'},
             {name: 'K.Love', score: '-2', hole: '13'}];
         }else if (tournament === 'CME Group Tour'){
         		data.d = [{name: 'S.Curry', score: '-3', hole: '3'}, 
          	 {name: 'K.Durant', score: '-3', hole: '8'},
             {name: 'K.Thompson', score: '-2', hole: '6'},
             {name: 'D.Green', score: '-1', hole: '9'}];
         }
        for(var i=0; i< data.d.length; i++){
        	html += '<tr><td>' + data.d[i].name + '</td><td>'+data.d[i].score+'</td><td>' + data.d[i].hole + '</td></tr>';
        }
        $("#tournamentstatus tr").first().after(html);
    });
});
