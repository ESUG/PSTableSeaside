# PSTableSeaside

PSTableSeaside is a package that you can use to create multiple tables with pagination or searching bar to filter or searching rows in your application.

If you want to create a table you need to select the type of table that you want to use.
There are two types of tables to create with PSTableSeaside:

* A Ordered Dictionary table
* A Ordered Collection table

# Create a table

## Implement a Collection Table

If you want to use this type of table, you need to inherit from class **PSTableCollectionComponent**. I will take as example the following table:

```
PSTableCollectionComponent subclass: #ExampleTable
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'ExamplePackage'
```


## Implement a Dictionary Table

If you want to use this type of table, you need to inherit from class **PSTableDictionaryComponent**. I will take as example the following table:

```
PSTableDictionaryComponent subclass: #ExampleTable
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'ExamplePackage'
```

## Overriden methods

You need to override the method **render:with:** if you want to show the rows of your table. An example is the following code:

```
render: html with: anObject
   "Render object on html"

   anObject do: [ :content |
      html mdlTableCell nonNumerical; with: content.
   ].
```

Now, you can create a table with the following variables and values ​​if you want to render your table on your page

```
ExampleTable new
  headers: self headers;
  listObject: self contacts;
  tableId: 'example-table';
  limitPerPage: 2.
```
## Explaining the variables

There are four important variables that you need to assign a value if you want render your table correctly:

* The **headers:** option allows assigning the headers of the table.
* The **listObject:** option give the list of elements that you want to show in you table.
* The **tableId:** option give the ID of table (It's required if you want to use all functionalities of your table).
* The **limitPerPage:** option  allows you to limit the number of rows per page in your table.

# Pagination Bar

The pagination bar is an option to display the rows of your tables divided into pages.

## Disable pagination bar

If you want to disable the pagination bar, you need to add the following attribute with the following value:

```
ExampleTable new
  headers: self headers;
  listObject: self contacts;
  tableId: 'example-table';
  limitPerPage: 2;
  disablePagination: true.
```

By default, the pagination bar is not disabled

## Change options of pagination bar

The class contains the option **limitPageShowed:** if you want to customize your pagination bar. The **limitPageShowed:** option allows you to limit the number of button pages displayed in your pagination bar.

```
ExampleTable new
  headers: self headers;
  listObject: self contacts;
  tableId: 'example-table';
  limitPerPage: 2;
  limitPageShowed: 3.
```

The given value shows only three buttons in your table, apart from the button of the current page. If you have more than four pages, the pagination bar will cycle through the buttons according to the current page.

# Searching bar

The searching bar is an option to filter the rows of your table with a simple filter or the possibility to create your own filter.

## Disable Searching bar

If you want to disable the searching bar, you need to add the following attribute with the following value:

```
ExampleTable new
  headers: self headers;
  listObject: self contacts;
  tableId: 'example-table';
  limitPerPage: 2;
  disableSearching: true.
```

By default, the searching bar is not disabled

## Functionality of searching bar

By default, the class has a simple filter for rows. If you want to customize your filter or the default filter does not work, the method shown below must be overwritten:

```
validateFilterOf: anObject
 "Validate the rows that you want to filter in your table"
 | result |
 result := "Some filter here"
 ^ result
```

The method must return a boolean value.