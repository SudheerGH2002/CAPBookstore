using Bookstore as service from '../../srv/service';



annotate service.Books with @(
    UI: {
        LineItem: [
            { Value: ID, Label: 'ID' },
            { Value: title, Label: 'Title' },
            { Value: author.firstName, Label: 'Author' },
            { Value: publisher.name, Label: 'Publisher' },
            { Value: price, Label: 'Price' },
            { Value: stock, Label: 'Stock' }
        ]
    }
);