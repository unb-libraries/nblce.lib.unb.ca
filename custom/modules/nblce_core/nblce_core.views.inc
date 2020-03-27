<?php

/**
 * @file
 * Provides support for custom views field plugin.
 */

/**
 * Implements hook_views_data_alter().
 */
function nblce_core_views_data_alter(array &$data) {
  $data['node']['node_parent_menu_link_title'] = [
    'title' => t('Parent Menu Link Title'),
    'group' => t('Parent Menu'),
    'field' => [
      'title' => t('Parent Menu Link Title'),
      'help' => t("Provide the title of a node's parent menu link."),
      'id' => 'node_parent_menu_link_title',
    ],
  ];
}
