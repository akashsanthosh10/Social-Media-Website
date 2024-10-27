// Event listeners for menu items
document.getElementById('homeMenu').addEventListener('click', function() {
    switchSection('feed');
});

document.getElementById('profileMenu').addEventListener('click', function() {
    switchSection('profile');
});

document.getElementById('friendsMenu').addEventListener('click', function() {
    switchSection('friends');
});

document.getElementById('notificationsMenu').addEventListener('click', function() {
    switchSection('notifications');
});

// Function to switch between sections
function switchSection(sectionId) {
    // Hide all sections
    const sections = document.querySelectorAll('main section');
    sections.forEach(section => {
        section.classList.remove('active');
    });

    // Show the selected section
    document.getElementById(sectionId).classList.add('active');
}

// Default load the home section
switchSection('feed');

function openEditDialog() {
    document.getElementById('editDialog').style.display = 'flex';
}

function closeEditDialog() {
    document.getElementById('editDialog').style.display = 'none';
}



// Function to open the profile edit dialog
function openProfileDialog() {
    document.getElementById('profileDialog').style.display = 'block';
}

// Function to close the profile edit dialog
function closeProfileDialog() {
    document.getElementById('profileDialog').style.display = 'none';
}



function openPostDialog() {
    document.getElementById('postDialog').style.display = 'block';
}

// Function to close the profile edit dialog
function closePostDialog() {
    document.getElementById('postDialog').style.display = 'none';
}
//Notification
// Notification
// Notification
document.addEventListener('DOMContentLoaded', loadNotifications);

function loadNotifications() {
    fetch('get_notifications.php')
        .then(response => response.json())
        .then(notifications => {
            const notificationsList = document.getElementById('notificationsList');
            notificationsList.innerHTML = ''; // Clear current notifications

            // Check if there are any notifications
            if (notifications.length === 0) {
                const li = document.createElement('li');
                li.textContent = 'No notifications available.'; // Message for no notifications
                notificationsList.appendChild(li);
            } else {
                // Append each notification as a list item
                notifications.forEach(notification => {
                    const li = document.createElement('li');
                    li.textContent = notification; // Display only the notification message
                    notificationsList.appendChild(li);
                });
            }
        })
        .catch(error => console.error('Error fetching notifications:', error));
}



//Friends
document.addEventListener('DOMContentLoaded', function() {
    fetchFriends(); // Call the function to fetch friends when the DOM is fully loaded
});

function fetchFriends() {
    fetch('get_friends.php') // Your PHP script that returns the friends list
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(friends => {
            const friendsList = document.getElementById('friendsList');
            friendsList.innerHTML = ''; // Clear existing content
            
            if (friends.length === 0) {
                friendsList.innerHTML = '<li>No friends found.</li>'; // Message for no friends
                return;
            }

            friends.forEach(friend => {
                const listItem = document.createElement('li');
                listItem.classList.add('friend-item');
                listItem.innerHTML = `
                    <div class="friend-info">
                        <p class="friend-name">${friend.username || 'Unknown User'}</p>
                        <button class="follow-button" data-userid="${friend.user_id}" data-following="${friend.is_following}">
                            ${friend.is_following ? 'Unfollow' : 'Follow'}
                        </button>
                    </div>
                `;
                friendsList.appendChild(listItem);
            });

            // Add event listeners for follow/unfollow buttons
            const followButtons = document.querySelectorAll('.follow-button');
            followButtons.forEach(button => {
                button.addEventListener('click', handleFollowButtonClick);
            });
        })
        .catch(error => console.error('Error fetching friends:', error));
}

function handleFollowButtonClick(event) {
    const button = event.target;
    const userId = button.getAttribute('data-userid');
    const isFollowing = button.getAttribute('data-following') === '1';

    const action = isFollowing ? 'unfollow' : 'follow';

    // Send the follow/unfollow request to the server
    fetch('follow_unfollow.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ userId: userId, action: action }),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            // Update the button text and data attribute
            button.innerText = isFollowing ? 'Follow' : 'Unfollow';
            button.setAttribute('data-following', isFollowing ? '0' : '1');
        } else {
            console.error(data.message); // Log any error message from the server
        }
    })
    .catch(error => console.error('Error with follow/unfollow action:', error));
}






//post
async function fetchPosts() {
    const response = await fetch('fetch_posts.php');
    const posts = await response.json();
    const postContainer = document.getElementById('postContainer');
    postContainer.innerHTML = ''; // Clear existing posts

    // Check if the response is valid
    if (posts.success === false) {
        alert(posts.message);
        return;
    }

    posts.forEach(post => {
        const postElement = document.createElement('div');
        postElement.innerHTML = `
            <p><strong>${post.username}</strong>: ${post.content}</p>
            <p><em>${new Date(post.created_at).toLocaleString()}</em></p>
        `;
        postContainer.appendChild(postElement);
    });
}

// Call the function to fetch posts on page load
document.addEventListener('DOMContentLoaded', fetchPosts);



document.getElementById('addPostButton').addEventListener('click', function() {
    document.getElementById('addPostForm').style.display = 'block'; // Show post form
});

document.getElementById('cancelPostButton').addEventListener('click', function() {
    document.getElementById('addPostForm').style.display = 'none'; // Hide post form
});

document.getElementById('submitPostButton').addEventListener('click', async function() {
    const postContent = document.getElementById('postContent').value;

    if (!postContent) {
        alert('Please enter some content for your post.');
        return;
    }

    try {
        const response = await fetch('add_post.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                content: postContent
            })
        });

        const result = await response.json();
        alert(result.message); // Display success or error message

        if (result.success) {
            document.getElementById('postContent').value = ''; // Clear the input
            document.getElementById('addPostForm').style.display = 'none'; // Hide the form
            fetchPosts(); // Refresh the posts to include the new post
        }
    } catch (error) {
        console.error('Error adding post:', error);
    }
});









//profile
document.addEventListener('DOMContentLoaded', function() {
    fetchProfile(); // Fetch profile data when the page loads

    // Event listeners for menu items
    document.getElementById('profileMenu').addEventListener('click', fetchProfile);
    // Add similar event listeners for friends and notifications
});

function fetchProfile() {
    fetch('fetch_profile.php') // Ensure this path is correct
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                displayProfile(data.data);
            } else {
                console.error('Error fetching profile:', data.message);
            }
        })
        .catch(error => {
            console.error('Error fetching profile:', error);
        });
}

function displayProfile(profileData) {
    console.log(profileData);
    const profileContainer = document.getElementById('profileContainer');
    profileContainer.innerHTML = `
        <div class="profile-header">
            <img src="p5.jpg" alt="Profile Pic" class="profile-pic">
            <div class="profile-info">
                <h3 class="profile-name">${profileData.username}</h3>
                <p class="profile-bio">${profileData.bio || 'No bio available'}</p>
                <button class="edit-button" onclick="openEditDialog()">Edit Profile</button>
            </div>
        </div>
        <div class="profile-details">
            <h4>Contact Information</h4>
            <ul class="contact-info">
                <li>Email: ${profileData.email}</li>
                <li>Phone: ${profileData.phone || 'Not provided'}</li>
                <li>Website: ${profileData.website || 'Not provided'}</li>
            </ul>
        </div>
    `;
}

function openEditDialog() {
    document.getElementById('editDialog').style.display = 'block';
}

function closeEditDialog() {
    document.getElementById('editDialog').style.display = 'none';
}




document.getElementById('logoutButton').addEventListener('click', function() {
    window.location.href = 'logout.php';
});
