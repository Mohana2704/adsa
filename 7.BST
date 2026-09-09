#include <stdio.h>
#include <stdlib.h>

struct Node
{
    int roll;
    struct Node *left;
    struct Node *right;
};

// Create a new node
struct Node* createNode(int roll)
{
    struct Node *newNode;

    newNode = (struct Node*)malloc(sizeof(struct Node));

    newNode->roll = roll;
    newNode->left = NULL;
    newNode->right = NULL;

    return newNode;
}

// Insert a roll number
struct Node* insert(struct Node *root, int roll)
{
    if(root == NULL)
    {
        return createNode(roll);
    }

    if(roll < root->roll)
    {
        root->left = insert(root->left, roll);
    }
    else if(roll > root->roll)
    {
        root->right = insert(root->right, roll);
    }

    return root;
}

// Search for a roll number
void search(struct Node *root, int roll)
{
    if(root == NULL)
    {
        printf("Roll number not found!\n");
        return;
    }

    if(root->roll == roll)
    {
        printf("Roll number found!\n");
        return;
    }

    if(roll < root->roll)
        search(root->left, roll);
    else
        search(root->right, roll);
}

// Find the smallest node
struct Node* findMin(struct Node *root)
{
    while(root->left != NULL)
    {
        root = root->left;
    }

    return root;
}

// Delete a roll number
struct Node* deleteNode(struct Node *root, int roll)
{
    struct Node *temp;

    if(root == NULL)
    {
        return root;
    }

    if(roll < root->roll)
    {
        root->left = deleteNode(root->left, roll);
    }
    else if(roll > root->roll)
    {
        root->right = deleteNode(root->right, roll);
    }
    else
    {
        // Node has no left child
        if(root->left == NULL)
        {
            temp = root->right;
            free(root);
            return temp;
        }

        // Node has no right child
        if(root->right == NULL)
        {
            temp = root->left;
            free(root);
            return temp;
        }

        // Node has two children
        temp = findMin(root->right);
        root->roll = temp->roll;
        root->right = deleteNode(root->right, temp->roll);
    }

    return root;
}

// Display in sorted order
void inorder(struct Node *root)
{
    if(root != NULL)
    {
        inorder(root->left);
        printf("%d ", root->roll);
        inorder(root->right);
    }
}

int main()
{
    struct Node *root = NULL;
    int choice, roll;

    while(1)
    {
        printf("\n===== STUDENT ROLL NUMBER BST =====\n");
        printf("1. Insert Roll Number\n");
        printf("2. Search Roll Number\n");
        printf("3. Delete Roll Number\n");
        printf("4. Display Sorted Roll Numbers\n");
        printf("5. Exit\n");

        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch(choice)
        {
            case 1:
                printf("Enter Roll Number: ");
                scanf("%d", &roll);

                root = insert(root, roll);
                printf("Roll number inserted successfully!\n");
                break;

            case 2:
                printf("Enter Roll Number to search: ");
                scanf("%d", &roll);

                search(root, roll);
                break;

            case 3:
                printf("Enter Roll Number to delete: ");
                scanf("%d", &roll);

                root = deleteNode(root, roll);
                printf("Roll number deleted if it existed.\n");
                break;

            case 4:
                printf("\nRoll Numbers in Sorted Order:\n");
                inorder(root);
                printf("\n");
                break;

            case 5:
                exit(0);

            default:
                printf("Invalid choice!\n");
        }
    }

    return 0;
}
