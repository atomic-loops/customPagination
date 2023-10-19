# paginationexp


# Custom Pagination Example

This is a Flutter application with a custom pagination feature. The application is designed to fetch data from an API and display it with pagination. Here's a breakdown of the code and how it works:

## ExampleController

`ExampleController` is a GetX controller class responsible for managing the application's state and data retrieval logic. It interacts with the API and updates the UI based on the data received. It has the following important functions and properties:

- `demomodel`: An instance of the `Demomodel` class.
- `result`: A list of `Result` objects to store the fetched data.
- `isLoading`: A flag to indicate whether data is being loaded.
- `isEmpty`: A flag to indicate whether there is no more data to fetch.

### Functions:
1. `getSeconData()`: This function is used to fetch additional data for pagination. It checks if there's more data to fetch based on the `count` and `result.length`. If more data is available, it makes an API request, adds the new data to the `result` list, and updates the UI accordingly.

2. `getData()`: This function is responsible for fetching the initial set of data. It updates the UI with loading indicators and then makes an API call. If the API call is successful, it updates the `result` list with the new data and checks for the end of data. It also handles errors if they occur during the API call.

3. `changeBool()`: This function resets the `isEmpty` and `isLoading` flags, used for resetting the pagination state.

4. `apiCall()`: This function makes an HTTP GET request to the specified API endpoint and returns the response.

5. `apiCallSecond(String url)`: This function makes an HTTP GET request to a given URL (for pagination purposes) and returns the response.

## CustomPaginationPage

`CustomPaginationPage` is a Flutter widget that represents the UI of the application. It's responsible for displaying the data, handling pagination through scrolling, and showing loading indicators. It also uses `GetBuilder` for state management. The important parts of this widget are as follows:

- `controller`: An instance of `ExampleController` used to manage the state.

- `_scrollController`: A `ScrollController` to detect when the user reaches the end of the scroll to trigger pagination.

- `future`: A variable to hold the future data retrieval operation.

### Widget Building:
1. In the `initState`, the widget sets up the `_scrollController` and initiates the data fetching by calling `controller.getData()`.

2. The UI is displayed inside a `Scaffold` with a `Scrollbar` and a `SingleChildScrollView` to enable scrolling.

3. The `FutureBuilder` widget is used to handle asynchronous data retrieval. It shows a loading indicator while waiting for data, displays the data when available, and handles errors.

4. Inside the `FutureBuilder`, data is displayed using a `ListView.builder`, and loading indicators and "No Data Found" messages are displayed based on the state of the application (`isLoading` and `isEmpty` flags).
