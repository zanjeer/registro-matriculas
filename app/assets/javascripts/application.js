// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require autocomplete-rails
//= require bootstrap-sprockets
//= require Chart.bundle
//= require chartkick
//= require_tree .
//= require jquery.turbolinks
//= require turbolinks

// https://github.com/ruoso/jquery-regex-mask-plugin
(function ($){
    $.fn.regexMask = function (mask) {
        if (!mask) {
            throw 'mandatory mask argument missing';
        } else if (mask == 'float-ptbr') {
            mask = /^((\d{1,3}(\.\d{3})*(((\.\d{0,2}))|((\,\d*)?)))|(\d+(\,\d*)?))$/;
        } else if (mask == 'float-enus') {
            mask = /^((\d{1,3}(\,\d{3})*(((\,\d{0,2}))|((\.\d*)?)))|(\d+(\.\d*)?))$/;
        } else if (mask == 'integer') {
            mask = /^\d+$/;
        } else {
            try {
                mask.test("");
            } catch(e) {
                throw 'mask regex need to support test method';
            }
        }
        $(this).keypress(function (event) {
            if (!event.charCode) return true;
            var part1 = this.value.substring(0,this.selectionStart);
            var part2 = this.value.substring(this.selectionEnd,this.value.length);
            if (!mask.test(part1 + String.fromCharCode(event.charCode) + part2))
                return false;
        });
    };
})(jQuery);
