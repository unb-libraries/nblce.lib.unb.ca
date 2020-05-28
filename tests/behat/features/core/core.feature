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

  Scenario: Test for level one heading in page content region
    Given I am on the homepage
    Then I should see the "h1" element in the "page content" region

  Scenario: Test for UNB Libraries logo in footer region
    Given I am on the homepage
    Then I should see the "img" element with the "alt" attribute set to "UNB Libraries" in the "footer" region

  Scenario: Login as a user with Content Editor role and create a node for each content type
    Given users:
      | name        | status |
      | Test Editor | 1      |
    When I am logged in as a user with the "content_editor" role
    And "author_page" content:
      | title             | author      | body             | promote | field_sort_name |
      | Article by Editor | Test Editor | AUTHOR PAGE BODY | 1       | Editor, Test    |
    And "basic_page" content:
      | title             | author      | body             | promote |
      | Page by Editor    | Test Editor | BASIC PAGE BODY  | 1       |
    And "module_page" content:
      | title             | author      | body             | promote |
      | Module by Editor  | Test Editor | MODULE PAGE BODY | 1       |
