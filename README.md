# E-commerce webapp

## Resources (all RESTful routes available): 
<ul>
  <li>Categories;</li>
  <li>ProductShoppingCarts;</li>
  <li>Products;</li>
  <li>Sessions;</li>
  <li>ShoppingCarts;</li>
  <li>Users.</li>
</ul>

## Associations:
<ul>
  <li>One-to-many between users / shopping_carts;</li>
  <li>Many-to-many beteeen products / categories.</li>
</ul>

## Authentication: based on logged in/logged out state;
## Security: admin user functionality and access level;
## Dependencies:
<ul>
  <li>Bootstrap 5.1 (Popper and Webpacker also required)</li>
  <li>PostgreSQL (Heroku hosted)</li>
  <li>Bcrypt, authentication system built manually</li>
</ul>

### App based on Rails 6 and ruby 2.7.4.1.
### Hosted by heroku -> https://zefcommerce.herokuapp.com/
