var prices = {}
var maxes = {}
var zone = null
var sound = new Audio('sound.wav');
    sound.volume = 1.0;

function closeMain() {
	$("body").css("display", "none");
}
function openMain() {
	$("body").css("display", "block");
}
function closeAll() {
	$(".body").css("display", "none");
}
$(".close").click(function(){
    $.post('https://lab-TopCriminals/quit', JSON.stringify({}));
});
$(".btn").on("mouseenter", ".close", function() {
	sound.play();
});

window.addEventListener('message', function (event) {

	var item = event.data;

	if (item.message == "show") {
		$( ".table-holder" ).empty()
		openMain();
		$( ".table-holder" ).append('<table style="width:90%; margin-left:5%;table-layout: auto;"></table>')
		$( "table" ).append('<tr>' +
		'<th class="divider">Name</th>' +
		'<th class="divider">Organisation</th>' +
		'<th class="divider">Score</th>' +
	  	'</tr>')
	}

	if (item.message == "add") {
		$( "table" ).append('<tr>' +
		'<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.label + '</span></b></td>' +
		'<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.type + '</span></b></td>' +
		'<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.score + '</span></b></td>' +
		'</tr>')
	}

	if (item.message == "hide") {
		closeMain();
	}
});

