window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.showUI) {
        $('.OurDiv').show();
        $('#mainDivTop').show();  // Use #Div1 to select by ID
    } else {
        $('.OurDiv').hide();
        $('#mainDivTop').hide();  // Use #Div1 to select by ID
    }
});
