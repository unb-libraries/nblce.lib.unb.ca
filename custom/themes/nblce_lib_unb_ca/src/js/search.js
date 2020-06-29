/**
 * @file
 * Search nblce_lib_unb_ca improvements.
 *
 */
(function ($, Drupal) {
    'use strict';

    Drupal.behaviors.nblce_lib_unb_ca = {
        attach: function (context, settings) {
            $(".search-content .view-empty span#search-query ").text(function() {
                return $(this).text().replace("your search", "'" + $("input[name='query']").attr('value') + "'" );
            });
            $(".search-content .search-header-result").text(function() {
                return $(this).text().replace("Found 1 search results", "Found 1 search result");
            });
        }
    }
})(jQuery, Drupal);