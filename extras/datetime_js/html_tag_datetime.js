/* Main javascript for HTML::Tag::Date and HTML::Tag::Datetime */

var MonthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var MonthNames = new Array('Gennaio','Febbraio','Marzo','Aprile','Maggio',
'Giugno','Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre');

var ver4 = (document.layers || document.all) ? 1 : 0;
var justKeyPressed;

function getEl (s_id) {
	return (document.all ? document.all[s_id] : (document.getElementById ? document.getElementById(s_id) : null));
}
       
function datetime_keydown(DnEvents) {
	if (justKeyPressed) return ;
	justKeyPressed = 1;
	var uevent = (ver4) ? window.event : DnEvents;
	k = (ver4) ?  window.event.keyCode : DnEvents.which ;
	eventType = (ver4) ? event.type : DnEvents.type;
	visibleElement = (ver4) ?  window.event.srcElement : DnEvents.currentTarget ;
	var visibleId = visibleElement.id.slice(2,-4);
	var visibleType = visibleElement.id.substring(visibleId.length+3);
	var visibleDateItem = visibleElement.id.substr(0,1);
	//alert (visibleId + " " + visibleType + " " + visibleDateItem  );
	//getEl('debug').innerHTML = "visibleElement: " + visibleElement.id + " - eventType: " + eventType + " - validate: "+datetime_validate(visibleElement,visibleDateItem)+ " - keypressed: " + k + "<br>" + getEl('debug').innerHTML;
	if (k==9 && !datetime_validate(visibleElement,visibleDateItem)) {
		//visibleElement.focus();
		if (ver4) {
				 uevent.cancelBubble = true;
   			 uevent.returnValue = false;
		} else {
				// non funziona in firefox
				uevent.preventDefault();
   			uevent.stopPropagation(); 
		}
		justKeyPressed = 0;
		return false;
	}
	var hiddenType = (visibleType == 'txt') ? 'sel' : 'txt';
	var hiddenElement = getEl(visibleDateItem  + "_" + visibleId + '_' + hiddenType );
	if (k == 27  || (((k>47 && k<58) ||(k>95 && k<106)) && visibleType == 'sel') || ((k == 9 || k == 0) && visibleType == 'txt') ) {
		if (visibleElement.value.toString().length == 1) visibleElement.value = '0' + visibleElement.value.toString();
		visibleElement.style.display='none';
		if (hiddenElement) {
			hiddenElement.value=visibleElement.value;
			hiddenElement.style.display='';
			hiddenElement.focus();
			if (hiddenElement.type == 'text') {
				if (ver4) {
					if (k == 27) hiddenElement.select();
				} else {
					hiddenElement.select();
				}
			}
			if (hiddenElement.type == 'text' && ver4 && k>47 && k<58) hiddenElement.value = k-48; 
			if (hiddenElement.type == 'text' && ver4 && k>95 && k<106) hiddenElement.value = k-96;			
		}
	}
	syncHidden(visibleId);
	justKeyPressed = 0;
}

function syncHidden(txtHiddenElementName) {
  	var hfield = getEl(txtHiddenElementName);
  	var giorno_obj 	= getEl("d_" + txtHiddenElementName + "_sel");
    var mese_obj 		= getEl("m_" + txtHiddenElementName + "_sel");
    var anno_obj 		= getEl("y_" + txtHiddenElementName + "_sel");

  	hfield.value= anno_obj.value + '-' + mese_obj.value + '-' + giorno_obj.value;
  }
  
  function syncVisible(txtHiddenElementName) {
  	var hfield  = getEl(txtHiddenElementName)
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
  	var giorno_obj 	= getEl("d_" + txtHiddenElementName + "_sel");
    var mese_obj 		= getEl("m_" + txtHiddenElementName + "_sel");
    var anno_obj 		= getEl("y_" + txtHiddenElementName + "_sel");
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
  var el = getEl(id);
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

function html_years(checked_value) {
  var checked ='';
  var cyear = (new Date()).getFullYear();
  with (document) {
    writeln('<OPTION VALUE=""' + checked + '></OPTION>');
    for (var num=cyear-100;num<cyear+100;num++) { 
    	var key = (num.toString().length == 1) ? '0' + num :  num;
    	var val = key;
    	checked = (checked_value == val || checked_value == num) ? ' checked' : '';
    	writeln('<OPTION VALUE="'+ key + '"' + checked + '>' + val + '</OPTION>');
    }
  }
}

function datetime_validate(el,dateTimeType) {
	var isValid = true;
	switch(dateTimeType)
        {
        case 'd':   isValid = validate_day(el); break       
        }
  return isValid;
}
