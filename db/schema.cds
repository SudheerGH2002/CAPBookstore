// /d:/Practice/CAP/bookstore/db/schema.cds
using { cuid, managed } from '@sap/cds/common';

namespace bookstore.db;

entity Authors : cuid, managed {
    firstName  : String(100);
   key lastName   : String(100) not null;
    bio        : String(2000);
    birthDate  : Date;
    country    : String(100);
    books      : Association to many Books on books.author = $self;
}

entity Publishers : cuid, managed {
    name       : String(200) not null;
    address    : String(500);
    website    : String(200);
    books      : Association to many Books on books.publisher = $self;
}

entity Categories : cuid {
    name        : String(100) not null;
    description : String(1000);
    parent      : Association to Categories;
    books       : Association to many Books on books.category = $self;
}

entity Books :  managed {
    key ID : String(36);
    isbn          : String(32);
    title         : String(500) not null;
    subtitle      : String(500);
    description   : String(2000);
    author        : Association to Authors;
    publisher     : Association to Publishers;
    category      : Association to Categories;
    price         : Decimal(9,2) not null;
    currency      : String(3) default 'USD';
    stock         : Integer default 0;
    publishedDate : Date;
    language      : String(50);
    pages         : Integer;
    coverImage    : String(1000);
    avgRating     : Decimal(2,1);
    reviews       : Association to many Reviews on reviews.book = $self;
    orderItems    : Association to many OrderItems on orderItems.book = $self;
}

entity Customers : cuid, managed {
    firstName  : String(100) not null;
    lastName   : String(100) not null;
    email      : String(200) not null;
    phone      : String(50);
    address    : String(500);
    city       : String(100);
    country    : String(100);
    orders     : Association to many Orders on orders.customer = $self;
    reviews    : Association to many Reviews on reviews.customer = $self;
}

entity Orders : cuid, managed {
    orderDate    : Timestamp default $now;
    customer     : Association to Customers;
    status       : String(30) default 'NEW';
    totalAmount  : Decimal(12,2) default 0;
    currency     : String(3) default 'USD';
    items        : Composition of many OrderItems on items.order = $self;
}

entity OrderItems : cuid {
    order        : Association to Orders;
    book         : Association to Books;
    quantity     : Integer not null default 1;
    unitPrice    : Decimal(9,2) not null;
    lineTotal    : Decimal(12,2) default 0; // can be computed in service logic
}

entity Reviews : cuid, managed {
    book         : Association to Books;
    customer     : Association to Customers;
    rating       : Integer not null;
    comment      : String(2000);
    reviewDate   : Timestamp default $now;
}