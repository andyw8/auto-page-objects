Feature: Collections

  Tags annotated with the special 'data-collection' attribute, such as tables and lists, will be treated as
  collections.

  It's assumed that the member elements of that collection are the direct child descendants of the collection tag.

  Scenario: A list

    The data-name attribute indicates which part of the collection member to extract

    Given the following HTML fragment:
      """html
      <ul data-collection="products">
        <li data-name>Car</li>
        <li data-name>Boat</li>
      </ul>
      """
    Then the page object data should be:
      """ruby
      {products: ["Car", "Boat"]}
      """

  Scenario: A list with inline attributes but no name

    Given the following HTML fragment:
      """html
      <ul data-collection="products">
        <li data-condition="new">Car</li>
        <li data-condition="used">Boat</li>
      </ul>
      """
    Then the page object data should be:
      """ruby
      {products: [{condition: 'new'}, {condition: 'used'}]}
      """

  Scenario: A list with inline attributes and names

    Given the following HTML fragment:
      """html
      <ul data-collection="products">
        <li data-condition="new" data-name>Car</li>
        <li data-condition="used" data-name>Boat</li>
      </ul>
      """
    Then the page object data should be:
      """ruby
      {:products=>[
        {"Car" => {condition: "new"}},
        {"Boat"  => {condition: "used"}}]
      }
      """

  Scenario: A table

    Given the following HTML fragment:
      """html
      <table data-collection="products">
        <tr data-condition="new">
          <td>Car</td>
        </tr>
        <tr data-condition="used">
          <td>Boat</td>
        </tr>
      </table>
      """
    Then the page object data should be:
      """ruby
      {products: [{condition: 'new'}, {condition: 'used'}]}
      """

  Scenario: A list, with names specified

    The special 'data-name' attribute is used as the key for the returned set.

    Given the following HTML fragment:
      """html
      <ul data-collection="products">
        <li data-condition="new" data-name>Car</li>
        <li data-condition="used" data-name>Boat</li>
      </ul>
      """
    Then the page object data should be:
      """ruby
      {
        products: [
          {"Car" => {
            condition: "new"}
          },
          {"Boat" => {
            condition: "used"}
          }
        ]
      }
      """

  Scenario: single collection with name indicators but no data attributes

    Given the following HTML fragment:
      """html
      <ul data-collection="products">
        <li data-name>Car</li>
        <li data-name>Boat</li>
      </ul>
      """
    Then the page object data should be:
      """ruby
      {
        products: ['Car', 'Boat']
      }
      """

  Scenario: Multiple collections

    Given the following HTML fragment:
      """html
      <ul data-collection="products">
        <li data-condition="new" data-name>Car</span>
        <li data-condition="used" data-name>Boat</span>
      </ul>
      <ul data-collection="services">
        <li data-available="yes" data-name>Wash</span>
        <li data-available="no" data-name>Engine Inspection</span>
      </ul>
      """
    Then the page object data should be:
      """ruby
      {
        products: [
          {"Car" => {
            condition: "new"}
          },
          {"Boat" => {
            condition: "used"}
          }
        ],
        services: [
          {"Wash" => {
            available: "yes"}
          },
          {"Engine Inspection" => {
            available: "no"}
          }
        ]
      }
      """
