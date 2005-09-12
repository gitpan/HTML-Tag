/* Main javascript for HTML::Tag::Date and HTML::Tag::Datetime */

var MonthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var MonthNames = new Array('Gennaio','Febbraio','Marzo','Aprile','Maggio',
'Giugno','Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre');




function syncHidden(txtHiddenElementName) {
  	var hfield = document.getElementById(txtHiddenElementName)
  	var giorno_obj 	= document.getElementById(txtHiddenElementName + "_giorno");
    var mese_obj 		= document.getElementById(txtHiddenElementName + "_mese");
    var anno_obj 		= document.getElementById(txtHiddenElementName + "_anno");

  	hfield.value= anno_obj.value + '-' + mese_obj.value + '-' + giorno_obj.value;
  }
  
  function syncVisible(txtHiddenElementName) {
  	var hfield  = document.getElementById(txtHiddenElementName)
  	var dta		= hfield.value.split('-');
  	if (dta.length == 3) {
			var time  = dta[2].split(' ');
			if (time.length == 2) {
				// date and time
				dta[2] = time[0];
				time = time[1].split(':');
			}
  		setDateVisibleElement(txtHiddenElementName,dta[2],dta[1],dta[0]);
  	}
  }
  
  function setDateVisibleElement(txtHiddenElementName,giorno,mese,anno) {
  	var giorno_obj 	= document.getElementById(txtHiddenElementName + "_giorno");
    var mese_obj 		= document.getElementById(txtHiddenElementName + "_mese");
    var anno_obj 		= document.getElementById(txtHiddenElementName + "_anno");
    if (giorno_obj) giorno_obj.value=giorno;
    if (mese_obj) mese_obj.value=mese;     
    if (anno_obj) anno_obj.value=anno;

  }
  
 // This function gets called when the end-user clicks on some date.
function selected(cal, date) {
  cal.sel.value = date; // just update the date in the input field.
  if (cal.dateClicked ) {
    var y = cal.date.getFullYear();
      var m = cal.date.getMonth();     // integer, 0..11
      var d = cal.date.getDate();      // integer, 1..31
      m=m+1;
      if (m.toString().length == 1) m = '0' + m;
      if (d.toString().length == 1) d = '0' + d;
      setDateVisibleElement(_dynarch_popupCalendar.sel.name,d,m,y);
      cal.callCloseHandler();
  }
}

// And this gets called when the end-user clicks on the _selected_ date,
// or clicks on the "Close" button.  It just hides the calendar without
// destroying it.
function closeHandler(cal) {
  cal.hide();                        // hide the calendar
//  cal.destroy();
  _dynarch_popupCalendar = null;
  
}

// This function shows the calendar under the element having the given id.
// It takes care of catching "mousedown" signals on document and hiding the
// calendar if the click was outside.
function showCalendar(button,id, format, showsTime, showsOtherMonths) {
  var el = document.getElementById(id);
  if (_dynarch_popupCalendar != null) {
    // we already have some calendar created
    _dynarch_popupCalendar.hide();                 // so we hide it first.
  } else {
    // first-time call, create the calendar.
    var cal = new Calendar(1, null, selected, closeHandler);
    // uncomment the following line to hide the week numbers
    // cal.weekNumbers = false;
    if (typeof showsTime == "string") {
      cal.showsTime = true;
      cal.time24 = (showsTime == "24");
    }
    if (showsOtherMonths) {
      cal.showsOtherMonths = true;
    }
    _dynarch_popupCalendar = cal;                  // remember it in the global var
    cal.setRange(1900, 2070);        // min/max year allowed.
    cal.create();
  }
  _dynarch_popupCalendar.setDateFormat(format);    // set the specified date format
  _dynarch_popupCalendar.parseDate(el.value);      // try to parse the text in field
  _dynarch_popupCalendar.sel = el;                 // inform it what input field we use

  // the reference element that we pass to showAtElement is the button that
  // triggers the calendar.  In this example we align the calendar bottom-right
  // to the button.
  _dynarch_popupCalendar.showAtElement(button, "Br");        // show the calendar

  return false;
}

function html_days(checked_value) {
  var checked ='';
  with (document) {
    
    writeln('<OPTION VALUE=""' + checked + '></OPTION>');
    for (var num=1;num<32;num++) { 
    	var val = (num.toString().length == 1) ? '0' + num :  num;
    	checked = (checked_value == val || checked_value == num) ? ' checked' : '';
    	writeln('<OPTION VALUE="'+ val + '"' + checked + '>' + val + '</OPTION>');
    }
  }
}

function html_months(checked_value) {
  var checked ='';
  with (document) {
    writeln('<OPTION VALUE=""' + checked + '></OPTION>');
    for (var num=1;num<13;num++) { 
    	var key = (num.toString().length == 1) ? '0' + num :  num;
    	var val = MonthNames[num-1];
    	checked = (checked_value == val || checked_value == num) ? ' checked' : '';
    	writeln('<OPTION VALUE="'+ key + '"' + checked + '>' + val + '</OPTION>');
    }
  }
}
