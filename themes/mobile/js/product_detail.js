/*-------------------------------------------------------------------------------------------------------------------------------*/
/*This is main JS file that contains custom scripts used in this template*/
/*-------------------------------------------------------------------------------------------------------------------------------*/
/* Template Name: Site Title*/
/* Version: 1.0 Initial Release*/
/* Build Date: 22-04-2015*/
/* Author: Unbranded*/
/* Website: http://
/* Copyright: (C) 2015 */
/*-------------------------------------------------------------------------------------------------------------------------------*/

/*--------------------------------------------------------*/
/* TABLE OF CONTENTS: */
/*--------------------------------------------------------*/
/* 01 - VARIABLES */
/* 02 - page calculations */
/* 03 - function on document ready */
/* 04 - function on page load */
/* 05 - function on page resize */
/* 06 - function on page scroll */
/* 07 - swiper sliders */
/* 08 - buttons, clicks, hovers */
/*-------------------------------------------------------------------------------------------------------------------------------*/

$(function() {

	"use strict";

	var minVal = parseInt($('.min-price span').text());
	var maxVal = parseInt($('.max-price span').text());
	$( "#prices-range" ).slider({
		range: true,
		min: minVal,
		max: maxVal,
		step: 5,
		values: [ minVal, maxVal ],
		slide: function( event, ui ) {
			$('.min-price span').text(ui.values[ 0 ]);
			$('.max-price span').text(ui.values[ 1 ]);
		}
	});

});