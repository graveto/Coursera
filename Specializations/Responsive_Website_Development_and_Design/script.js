/**
 * Created by graveto on 9/29/2015.
 */
var showEnglish = function() {
  $(this).html("School of Japanese");
};

var showJapanese = function() {
  $(this).text("日本の学校");
};

$("h1").hover(showEnglish, showJapanese);

