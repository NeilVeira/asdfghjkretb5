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

var tour
var scores = {a: '0',b: '0',c: '0',d: '0',e: '0',f: '0',g: '0',h: '0',i: '0',j: '0', k: '0', l: '0', n: '0'}
var holes = {a: '1',b: '1',c: '1',d: '1',e: '1',f: '1',g: '1',h: '1',i: '1',j: '1', k: '1', l: '1', n: '1'}

function updatescores(){

    for (var key in holes){
        if (parseInt(holes[key])<18){
            if(Math.random() < 0.3){
                holes[key] = String(parseInt(holes[key])+1)
                scoreprob = Math.random()
                if (scoreprob < 0.10){
                    scores[key] = String(parseInt(holes[key])+2)
                }else if(scoreprob < 0.20 && scoreprob >= 0.10){
                    scores[key] = String(parseInt(holes[key])-4)
                }else if(scoreprob < 0.35 && scoreprob >= 0.20){
                    scores[key] = String(parseInt(holes[key])-3)
                }else if(scoreprob < 0.50 && scoreprob >= 0.35){
                    scores[key] = String(parseInt(holes[key])+1)
                }
            }
        } 
    }
}

function traverse(){
    for (var key in holes){
        console.log(key)
        console.log(scores[key])
    }
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
        	data.d = [{name: 'K.Lowry', score: scores.a, hole: holes.a}, 
          	 {name: 'J.Sullinger', score:  scores.b, hole: holes.b},
             {name: 'D.Carroll', score:  scores.c, hole: holes.c},
             {name: 'C.Joseph', score:  scores.d, hole: holes.d},
             {name: 'N.Powell', score:  scores.e, hole: holes.e}];
         } else if (tournament==='Loren Place'){
         			data.d = [{name: 'L.James', score: scores.f, hole: holes.f}, 
          	 {name: 'K.Irving', score: scores.g, hole: holes.g},
             {name: 'J.Smith', score: scores.h, hole: holes.h},
             {name: 'K.Love', score: scores.i, hole: holes.i}];
         }else if (tournament === 'CME Group Tour'){
         		data.d = [{name: 'S.Curry', score: scores.j, hole: holes.j}, 
          	 {name: 'K.Durant', score: scores.k, hole: holes.k},
             {name: 'K.Thompson', score: scores.l, hole: holes.l},
             {name: 'D.Green', score: scores.n, hole: holes.n}];
         }
        for(var i=0; i< data.d.length; i++){
        	html += '<tr><td>' + data.d[i].name + '</td><td>'+data.d[i].score+'</td><td>' + data.d[i].hole + '</td></tr>';
        }
        $("#tournamentstatus tr").first().after(html);
    });

    $("#message").click(function(){
        alert("Message sent!")
    });
    setInterval(updatescores, 60000);
    //traverse();
});

$(document).ready(function() {
  $('.flexslider').flexslider({
    animation: "animation"
  });

});


