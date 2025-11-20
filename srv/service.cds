// srv/srv.cds
// Expose the entities defined in db/schema.cds.
// Adjust the entity list below to match the actual names in your db/schema.cds.

using { bookstore.db as my } from '../db/schema.cds';

service Bookstore @(path: '/bookstore') {
    entity Books      as projection on my.Books;
    entity Authors    as projection on my.Authors;
    entity Customers  as projection on my.Customers;
    entity Orders     as projection on my.Orders;
    entity OrderItems as projection on my.OrderItems;
    entity Reviews    as projection on my.Reviews;
}

annotate Bookstore.Books with @odata.draft.enabled;