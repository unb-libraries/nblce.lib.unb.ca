<?php

namespace Drupal\nblce_core\Plugin\views\field;

use Drupal\views\Plugin\views\field\FieldPluginBase;
use Drupal\views\ResultRow;

/**
 * Field handler to flag the node type.
 *
 * @ingroup views_field_handlers
 *
 * @ViewsField("node_parent_menu_link_title")
 */
class NodeParentMenuLinkTitle extends FieldPluginBase {

  /**
   * Leave empty.
   *
   * @{inheritdoc}
   */
  public function query() {
    // Leave empty to avoid a query on this field.
  }

  /**
   * Provides Parent Menu Link Title as a field in Views UI.
   *
   * @{inheritdoc}
   */
  public function render(ResultRow $values) {
    $node = $values->_entity;
    $node_id = $node->id();

    $menu_link_manager = \Drupal::service('plugin.manager.menu.link');
    $links = $menu_link_manager->loadLinksByRoute('entity.node.canonical', ['node' => $node_id]);
    if ($link = reset($links)) {
      if ($parent = $link->getParent()) {
        $parent = $menu_link_manager->createInstance($parent);
        $parent_title = $parent->getTitle();
      }
    }
    else {
      $parent_title = NULL;
    }

    return $this->t('@title', ['@title' => $parent_title]);
  }

}
