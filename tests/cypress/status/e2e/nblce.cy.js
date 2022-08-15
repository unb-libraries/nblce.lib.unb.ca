const host = 'https://nblce.lib.unb.ca'
describe('New Brunswick Literature Curriculum in English', {baseUrl: host, groups: ['sites']}, () => {

  context('Front page', {baseUrl: host}, () => {
    beforeEach(() => {
      cy.visit('/')
      cy.title()
        .should('eq', 'New Brunswick Literature Curriculum in English (NBLCE)')
    })

    specify('Navigation menu should contain "Home" item', () => {
      cy.get('.region-header .navbar')
        .should('contain', 'Home')
    })

    specify('"Resources" submenu should contain "Author List", "Module List" items', () => {
      cy.get('.region-nav-main ul.navbar-nav li.nav-item:nth-child(3)')
        .click()
      cy.get('.navbar-nav li.show ul.show')
        .contains('Author List')
        .its('0.href')
        .should('match', /\/resources\/authors/)
      cy.get('.navbar-nav li.show ul.show')
        .contains('Module List')
        .its('0.href')
        .should('match', /\/resources\/modules/)
    })

    specify('Sidebar block title should contain "MODULES"', () => {
      cy.get('.sidebar-first-wrapper h2')
        .should('contain', 'Modules')
    })

    specify('Content title should contain "New Brunswick Literature Curriculum in English"', () => {
      cy.get('.main-page-content-wrapper .block-system')
        .should('be.visible')
      cy.get('.region-content')
        .should('contain', 'New Brunswick Literature Curriculum in English')
    })

    specify('Slideshow should feature 6+ slides', () => {
      cy.get('.slick-slide img')
        .should('have.lengthOf.at.least', 6)
    })

    specify('Footer should contain "Tony Trembley"', () => {
      cy.get('.region-footer')
        .should('contain', 'Tony Tremblay')
    })
  })

  context('Author List', {baseUrl: `${host}/resources/authors`}, () => {
    beforeEach(() => {
      cy.visit('/')
        cy.title()
          .should('contain', 'Author List')
    })

    specify('10+ authors should be listed', () => {
      cy.get('.view-content ul.list-unstyled li')
        .should('have.lengthOf.at.least', 10)
    });
  })

  context('Module List', {baseUrl: `${host}/resources/modules`}, () => {
    beforeEach(() => {
      cy.visit('/')
      cy.title()
        .should('contain', 'Module List')
    })

    specify('10+ modules should be listed', () => {
      cy.get('.view-content ul.list-unstyled li')
        .should('have.lengthOf.at.least', 10)
    });
  })
})
