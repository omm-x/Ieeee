#include <stdio.h>
#include <stdlib.h>

typedef struct binarytree {
    int data;
    struct binarytree *left, *right;
} node;

node *root = NULL;

node *insert(node *ptr, int val) {
    if (ptr == NULL) {
        ptr = (node *)malloc(sizeof(node));
        ptr->data = val;
        ptr->left = ptr->right = NULL;
    } else if (val < ptr->data)
        ptr->left = insert(ptr->left, val);
    else
        ptr->right = insert(ptr->right, val);
    return ptr;
}

void preorder(node *ptr) {
    if (ptr != NULL) {
        printf("%d ", ptr->data);
        preorder(ptr->left);
        preorder(ptr->right);
    }
}

void inorder(node *ptr) {
    if (ptr != NULL) {
        inorder(ptr->left);
        printf("%d ", ptr->data);
        inorder(ptr->right);
    }
}

void postorder(node *ptr) {
    if (ptr != NULL) {
        postorder(ptr->left);
        postorder(ptr->right);
        printf("%d ", ptr->data);
    }
}

node *binarySearch(node *ptr, int key) {
    if (ptr == NULL)
        return NULL;
    if (ptr->data == key)
        return ptr;
    else if (key < ptr->data)
        return binarySearch(ptr->left, key);
    else
        return binarySearch(ptr->right, key);
}

node *deletenode(node *ptr, int val) {
    node *tmp;
    if (ptr == NULL)
        return NULL;

    if (val < ptr->data)
        ptr->left = deletenode(ptr->left, val);
    else if (val > ptr->data)
        ptr->right = deletenode(ptr->right, val);
    else {
        if (ptr->left == NULL && ptr->right == NULL) {
            free(ptr);
            return NULL;
        } else if (ptr->left != NULL && ptr->right == NULL) {
            tmp = ptr->left;
            free(ptr);
            return tmp;
        } else if (ptr->left == NULL && ptr->right != NULL) {
            tmp = ptr->right;
            free(ptr);
            return tmp;
        } else {
            tmp = ptr->right;
            while (tmp->left != NULL)
                tmp = tmp->left;
            ptr->data = tmp->data;
            ptr->right = deletenode(ptr->right, tmp->data);
        }
    }
    return ptr;
}

int main() {
    int choice, val, key;
    node *searchResult;

    while (1) {
        printf("\n1. Insert\n2. Preorder\n3. Inorder\n4. Postorder\n5. Search\n6. Delete\n7. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                printf("Enter value: ");
                scanf("%d", &val);
                root = insert(root, val);
                break;
            case 2:
                printf("Preorder: ");
                preorder(root);
                printf("\n");
                break;
            case 3:
                printf("Inorder: ");
                inorder(root);
                printf("\n");
                break;
            case 4:
                printf("Postorder: ");
                postorder(root);
                printf("\n");
                break;
            case 5:
                printf("Enter value to search: ");
                scanf("%d", &key);
                searchResult = binarySearch(root, key);
                if (searchResult != NULL)
                    printf("%d found in tree.\n", key);
                else
                    printf("%d not found in tree.\n", key);
                break;
            case 6:
                printf("Enter value to delete: ");
                scanf("%d", &val);
                root = deletenode(root, val);
                break;
            case 7:
                exit(0);
            default:
                printf("Invalid choice.\n");
        }
    }
}