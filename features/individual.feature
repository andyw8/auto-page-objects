Feature: Individual

  Scenario: Multiple data attributes

    Any 'valueless' data attribute will be used as the key for the data in the return set

    Given the following HTML fragment:
      """html
      <span data-opening-time class="foo">9am</span>
      <span data-closing-time class="bar">6pm</span>
      """
    Then the page object data should be:
      """ruby
      {
        opening_time: '9am',
        closing_time: '6pm'
      }
      """

  Scenario: Additional inline data attributes

    Sometimes it can be useful to attach additional data attributes to a tag.

    Given the following HTML fragment:
      """html
      <span data-product-name data-sku="12345">6pm</span>
      """
    Then the page object data should be:
      """ruby
      {product_name: '6pm', sku: '12345'}
      """

  Scenario: Empty HTML fragment

    Given an empty HTML fragment
    Then the page object data should be:
      """ruby
      {}
      """

  Scenario: Element fragment with no data attributes

    Any context not annotated with data attributes will be ignored.

    Given the following HTML fragment:
      """html
      <ul>
        <li>Car</span>
        <li>Boat</span>
      </ul>
      """
    Then the page object data should be:
      """ruby
      {}
      """