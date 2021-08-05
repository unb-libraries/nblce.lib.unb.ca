# Basic functionality testing.
# Ref : phase2/behat-suite
# http://behat-drupal-extension.readthedocs.io/en/3.1/drupalapi.htm

@api
Feature: Core
  In order to know the website is running properly
  I need to verify expected elements/regions exist and that authenticated editors may create content

  Scenario: Test for NBLCE logo in header region
    Given I am on the homepage
    Then I should see the "img" element with the "alt" attribute set to "NBLCE" in the "header" region

  Scenario: Test for Navigation menu in header region
    Given I am on the homepage
    Then I should see the "nav ul.navbar-nav" element in the "header" region

  Scenario: Test for sidebar container in main content region
    Given I am on the homepage
    Then I should see the "div.sidebar-first-wrapper" element in the "main" region

  Scenario: Test for level one heading + main page content block within page content region
    Given I am on the homepage
    Then I should see the "h1" element in the "page content" region
    And I should see the ".block-system-main-block" element in the "page content" region

  Scenario: Test for UNB Libraries logo in footer region
    Given I am on the homepage
    Then I should see the "img" element with the "alt" attribute set to "UNB Libraries" in the "footer" region
