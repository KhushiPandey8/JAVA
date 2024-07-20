    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>React-like TODO List</title>
        <style>
          @import url('https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100..900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700&family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Protest+Riot&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Source+Code+Pro:ital,wght@0,200..900;1,200..900&display=swap');
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Exo 2", sans-serif;
        font-optical-sizing: auto;

    }
       body {
            margin: 0;
            height: 100vh;
            overflow: hidden; /* Prevent scrolling of the body */
            position: relative;
        }

        .image {
            width: 100%;
            height: 100%;
            position: fixed; /* Fix the background image */
            top: 0;
            left: 0;
            z-index: -1;
            background-size: cover;
            background-position: center;
            opacity: 0.5;
        }

        .container {
            position: relative;
            z-index: 1;
            max-height: 80vh; /* Define the maximum height for the scrolling area */
            overflow-y: auto; /* Enable vertical scrolling */
            padding: 20px;
            margin-top: 20px;
        }

        #username-display {
            text-align: center;
            margin-top: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        #todos {
            height: 50px;
            width: 500px;
            font-size: 20px;
            margin-right: 10px;
        }

        #add {
            color: white;
            background-color: blue;
            height: 50px;
            width: 100px;
            font-size: 20px;
            border: 2px solid black;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 5px;
        }

        .list {
            margin-top: 50px;
        }

        .mylist {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 80%;
            max-width: 600px;
            height: auto;
            background-color: lightskyblue;
            margin: 20px auto;
            padding: 10px;
            box-sizing: border-box;
            border-radius: 5px;
        }

        .lists {
            font-size: 20px;
            list-style-type: none;
            margin: 0;
            padding: 0;
            flex: 1; /* Takes up remaining space */
            text-align: left; /* Aligns text to the left */
            margin-right: 10px; /* Adds some space between text and buttons */
        }

        .del, .up {
            color: white;
            height: 30px;
            width: 80px;
            font-size: 15px;
            border: 2px solid black;
            border-radius: 5px;
            cursor: pointer;
            font-family: "Source Code Pro", monospace;
            margin-left: 5px;
        }

        .del {
            background-color: darkred;
        }

        .up {
            background-color: green;
        }

        .controls {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        #heading {
            text-align: center;
        }

        #logout {
            position: absolute;
            top: 10px;
            right: 10px;
            color: white;
            background-color:crimson;
            height: 40px;
            width: 100px;
            font-size: 20px;
            border: 2px solid black;
            border-radius: 5px;
            cursor: pointer;
        }

        .completed {
            text-decoration: line-through;
            opacity: 0.5;
        }
            #username-display {
            text-align: center;
            margin-top: 20px;
            font-size: 24px;
            font-weight: bold;
            color: crimson;
             font-family: "Source Code Pro", monospace;
        }
        .mylist input[type="checkbox"] {
    margin-right: 10px; /* Adds space between checkbox and text */
    
}

        #heading{
            font-size: 30px;
              font-family: "Pacifico", cursive;
            margin-top: 10px;
        }

        </style>
    </head>
    <body>
    <img src="i2.jpg" alt="background image" class="image"/>
    <button id="logout">Logout</button>
    <h2 id="username-display">Welcome, User!</h2> <!-- Placeholder for username -->
    <h1 id="heading">TODO List</h1>
    <div class="container">
        <div class="controls">
            <input type="text" name="todo" id="todos" placeholder="Add Your Task"/>
            <button id="add">Add</button>
        </div>
        <div class="Show">
            <ul class="list" id="todo-list">
                <!-- Existing list items will be dynamically inserted here -->
            </ul>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Function to get the username from the URL query string
            const getUsernameFromUrl = () => {
                const params = new URLSearchParams(window.location.search);
                return params.get('username') || 'defaultUser';
            };

            // Get the username from the URL
            const username = getUsernameFromUrl();

            // Set the username in the header
            document.getElementById('username-display').textContent = `Welcome, ${username}!`;

            // Create a key for storing todos specific to the user
            const storageKey = `todos_${username}`;

            // State Management
            let state = {
                todos: JSON.parse(localStorage.getItem(storageKey)) || []
            };

            // Function to render the list based on the current state
            const render = () => {
                const listContainer = document.getElementById('todo-list');
                listContainer.innerHTML = ''; // Clear current list

                state.todos.forEach((todo, index) => {
                    const listItem = createListItem(todo, index);
                    listContainer.appendChild(listItem);
                });
            };

            // Function to create a TODO list item element
            const createListItem = (todo, index) => {
                const listItem = document.createElement('div');
                listItem.classList.add('mylist');

                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.addEventListener('change', () => {
                    if (checkbox.checked) {
                        todoItem.classList.add('completed');
                    } else {
                        todoItem.classList.remove('completed');
                    }
                });

                const todoItem = document.createElement('li');
                todoItem.classList.add('lists');
                todoItem.textContent = todo;

                const deleteButton = document.createElement('button');
                deleteButton.classList.add('del');
                deleteButton.textContent = 'Delete';
                deleteButton.addEventListener('click', () => {
                    state.todos.splice(index, 1);
                    updateLocalStorage();
                    render();
                });

                const updateButton = document.createElement('button');
                updateButton.classList.add('up');
                updateButton.textContent = 'Update';
                updateButton.addEventListener('click', () => {
                    const newText = prompt('Enter updated text:', todo);
                    if (newText !== null && newText.trim() !== '') {
                        state.todos[index] = newText.trim();
                        updateLocalStorage();
                        render();
                    }
                });

                listItem.appendChild(checkbox);
                listItem.appendChild(todoItem);
                listItem.appendChild(updateButton); // Ensure Update button is first
                listItem.appendChild(deleteButton);

                return listItem;
            };

            // Function to add a new TODO item
            const addTodo = () => {
                const inputTodo = document.getElementById('todos');
                const todoText = inputTodo.value.trim();
                if (todoText !== '') {
                    state.todos.push(todoText);
                    updateLocalStorage();
                    render();
                    inputTodo.value = '';
                    inputTodo.focus();
                }
            };

            // Function to update localStorage
            const updateLocalStorage = () => {
                localStorage.setItem(storageKey, JSON.stringify(state.todos));
            };

            // Initial render
            render();

            // Add button event listener
            document.getElementById('add').addEventListener('click', addTodo);

            // Logout button event listener
            document.getElementById('logout').addEventListener('click', () => {
                window.location.href = 'index.jsp'; // Redirect to home page
            });
        });
    </script>
</body>
    </html>
