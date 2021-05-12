/**
 * CS 2110 - Spring 2021 - Homework 9
 *
 * @author Sai Nikhil Vangala
 *
 * list.c: Complete the functions!
 */

/**
 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!-IMPORTANT-!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * For any function that must use malloc, if malloc returns NULL, the function
 * itself should return NULL if needs to return something (or return FAILURE if
 * the function returns an int).
 */

// Do not add ANY additional includes!!!
#include "list.h"

/* You should NOT have any global variables. */

/* These are static helper functions not intended to be called anywhere outside this file. */
static struct user *create_user(char *name, int id);
static struct node *create_node(char *name, int id);
static int user_equal(const struct user *user1, const struct user *user2);

/** create_user
 *
 * Helper function that creates a user by allocating memory for it on the heap
 * and initializing with the passed in data. You MUST create a deep copy of
 * the name by malloc'ing space for it on the heap.
 *
 * If malloc returns NULL, you should free everything you've allocated and
 * return NULL.
 *
 * @param the fields of the user struct
 * @return a user struct, return NULL if malloc fails
 */
static struct user *create_user(char *name, int id)
{
    struct user *n = malloc(sizeof(struct user));
    if (n == NULL) {
      return NULL;
    } else if (name == NULL) {
      n->name = NULL;
    }
    else {
      (*n).name = malloc(strlen(name) + 1);
      if (!(*n).name) {
        free(n);
        return NULL;
      }
      strcpy((*n).name, name);
    }
    (*n).id = id;
    return n;
}


/** create_node
 *
 * Helper function that creates a struct node by allocating memory for it on
 * the heap. Be sure to set its next pointer to NULL.
 *
 * Remember that you need to malloc both the node itself and the user that's
 * contained in the struct. You might want to call create_user instead of
 * malloc'ing again.
 *
 * If malloc returns NULL for either of them, you should return NULL to
 * indicate failure. In the case that you successfully malloc one of them but
 * fail to malloc the other one, you should free the one you successfully
 * malloc'd.
 *
 * @param the fields of the user struct
 * @return a linked list node
 */
static struct node *create_node(char *name, int id)
{
    struct node *n = malloc(sizeof(struct node));
    if (n == NULL) {
      return NULL;
    }
    (*n).data = create_user(name, id);
    if (n->data == NULL) {
      free(n);
      return NULL;
    }
    (*n).next = NULL;
    return n;
}


/** user_equal
 * Helper function to help you compare two user structs.
 *
 * If the name and id are both equal, you should return 1.
 * Otherwise, return 0.
 *
 * NOTE: struct members that are pointers may be null! If two users both have
 * null for a certain pointer, the pointers are considered equal. However, if
 * either of the input users is NULL, you should return 0.
 *
 * Make sure you're using the right function when comparing the name.
 * Remember that you are allowed to use functions from string.h
 *
 * This is meant to be used as a helper function in 'contains'; it is not tested
 * by the autograder.
 *
 * @param the two user structs to be compared
 * @return 1 if equal, 0 otherwise
 */
static int user_equal(const struct user *user1, const struct user *user2)
{
    if (!user1 && !user2) {
        return 1;
    } else if ((!user1 && user2) || (user1 && !user2)){
        return 0;
    } else {
        if ((!user1 -> name && user2 -> name) || (user1 -> name && !user2 -> name)) {
            return 0;
        } else if(!user1 -> name && !user2 -> name) {
            if (user1 -> id == user2 -> id) {
                return 1;
            } else {
                return 0;
            }
        } else {
             if ((strcmp(user1 -> name, user2 -> name) == 0) && (user1 -> id == user2 -> id)) {
                return 1;
            } 
        }
    }
    return 0;
}

/** create_list
 *
 * Creates a 'struct linked_list' by allocating memory for it on the heap.
 * Be sure to initialize size to zero and head to NULL.
 *
 * If malloc returns NULL, you should return NULL to indicate failure.
 *
 * @return a pointer to a new list or NULL on failure
 */
struct linked_list *create_list(void)
{
    struct linked_list *list = malloc(sizeof(struct linked_list));
    if (list == NULL) {
      return NULL;
    }
    (*list).head = NULL;
    (*list).size = 0;
    return list;
}

/** push_front
 *
 * Adds the element at the front of the linked list.
 *
 * @param list a pointer to the linked list struct.
 * @param the fields of the user struct
 * @return FAILURE if the linked_list is NULL or if allocating the new node
 *         fails, SUCCESS if successful.
 */
int push_front(struct linked_list *list, char *name, int id)
{
    if (list == NULL) {
      return FAILURE;
    }
    struct node *node = create_node(name, id);
    if (node == NULL) {
      return FAILURE;
    }
    if ((*list).head == NULL) {
      (*list).head = node;
    }
    else {
      (*node).next = (*list).head;
      (*list).head = node;
    }
    (*list).size++;
    return SUCCESS;
}

/** push_back
 *
 * Adds the element to the back of the struct linked_list.
 *
 * @param list a pointer to the linked_list struct.
 * @param the fields of the user struct
 * @return FAILURE if the linked list is NULL or if allocating the new node
 *         fails, SUCCESS if successful.
 */
int push_back(struct linked_list *list, char *name, int id)
{
    if (list == NULL) {
      return FAILURE;
    }
    struct node *node = create_node(name, id);
    int size = (*list).size;
    int count = 0;
    if (node == NULL) {
      return FAILURE;
    }
    struct node *temp = (*list).head;
    if ((*list).head == NULL) {
      (*list).head = node;
    }
    else {
        while (count < (size - 1)) {
          temp = (*temp).next;
        }
        (*temp).next = node;
    }
    (*list).size++;
    return SUCCESS;
}

/** add_at_index
 *
 * Add the element at the specified index in the linked list. This index must
 * lie in the inclusive range [0,size].
 *
 * For example, if you have no elements in the linked list, you should be able
 * to add to index 0, but no less. If you have two elements in the linked list,
 * you should be able to add to index 2 but no further.
 *
 * @param list a pointer to the linked list struct
 * @param index 0-based, starting from the head in the inclusive range [0,size]
 * @param the fields of the user struct
 * @return FAILURE if the index is out of bounds or the linked list is NULL or
 *         malloc fails (do not add the data in this case) otherwise (on
 *         success) return SUCCESS
 */
int add_at_index(struct linked_list *list, int index, char *name, int id)
{
    if (list == NULL || index > (*list).size || index < 0) {
        return FAILURE;
    }
    if (index == 0) {
        return push_front(list, name, id);
    }
    if (index == (*list).size) {
        return push_back(list, name, id);
    }
    struct node *node = create_node(name, id);
    struct node *temp = list -> head;
    struct node *prev = NULL;
    if (node == NULL) {
        return FAILURE;
    }
    int count = 0;
    while (count < index) {
        prev = temp;
        temp = (*temp).next;
        if (temp == NULL) {
            return FAILURE;
        }
        (*list).size++;
        count++;
    }
    (*node).next = temp;
    (*prev).next = node;
    return SUCCESS;
}

/** get
 *
 * Gets the data at the specified index in the linked list
 *
 * @param list a pointer to the linked list struct
 * @param index 0-based, starting from the head.
 * @param dataOut A pointer to a pointer used to return the data from the
 *        specified index in the linked list or NULL on failure.
 * @return FAILURE if dataOut is NULL or index is out of range of the linked
 *         list or the linked list is NULL, SUCCESS otherwise
 */
int get(struct linked_list *list, int index, struct user **dataOut)
{
    if (dataOut == NULL || list == NULL || (*list).size == 0 || index < 0 || index >= (*list).size) {
      return FAILURE;
    }
    int i = 0;
    struct node *curr = (*list).head;
    while (i < index) {
      i++;
      curr = (*curr).next;
    }
    *dataOut = (*curr).data;
    return SUCCESS;
}

/** contains
 *
 * Traverses the linked list, trying to see if the linked list contains some
 * data. We say the list contains some input if there exists some node with
 * equal data as the input.
 *
 * You should use 'user_equal' here to compare the data. Note that pointers are
 * allowed to be null!
 *
 * If there are multiple pieces of data in the linked list which are equal to
 * the "data" parameter, return the one at the lowest index.
 *
 *
 * @param list a pointer to the linked list struct
 * @param data The data, to see if it exists in the linked list
 * @param dataOut A pointer to a pointer used to return the data contained in
 *        the linked list or NULL on failure
 * @return 0 (false) if dataOut is NULL, the list is NULL, or the list does not
 *         contain data, else 1 (true)
 */
int contains(struct linked_list *list, struct user *data, struct user **dataOut)
{
    if (dataOut == NULL) {
      return 0;
    }
    if ( list == NULL || (*list).size == 0) {
      *dataOut = NULL;
      return 0;
    }
    int i = 0;
    struct node *curr = (*list).head;
    if (user_equal((*curr).data, data) == 1) {
        *dataOut = (*curr).data;
        return 1;
    }
    while ( i < (*list).size - 1) {
        i = i + 1;
        curr = (*curr).next;
        if (user_equal((*curr).data, data) == 1) {
          *dataOut = (*curr).data;
          return 1;
        }
    }
    *dataOut = NULL;
    return 0;
}

/** pop_front
 *
 * Removes the node at the front of the linked list, and returns its data to
 * the program user.
 *
 * @param list a pointer to the linked list.
 * @param dataOut A pointer to a pointer used to return the data in the first
 *        node or NULL if the linked list is NULL or empty
 * @return FAILURE if dataOut is NULL (the linked list is NULL or empty), else
 *         SUCCESS
 */
int pop_front(struct linked_list *list, struct user **dataOut)
{
    if (list == NULL || (*list).size == 0) {
      dataOut = NULL;
      return FAILURE;
    }
    struct node *temp = (*list).head;
    (*list).head = (*((*list).head)).next;
    (*list).size--;
    if (dataOut == NULL) {
      return FAILURE;
    }
    *dataOut = (*temp).data;
    free(temp);
    return SUCCESS;
}

/** pop_back
 *
 * Removes the node at the back of the linked list, and returns its data to the
 * program user.
 *
 * @param list a pointer to the linked list.
 * @param dataOut A pointer to a pointer used to return the data in the last
 *        node or NULL if the linked list is NULL or empty
 * @return FAILURE if dataOut is NULL (the linked list is NULL or empty), else
 *         SUCCESS
 */
int pop_back(struct linked_list *list, struct user **dataOut)
{
     if (dataOut == NULL) {
        return FAILURE;
    }
    if (list == NULL || (*list).size == 0) {
        *dataOut = NULL;
        return FAILURE;
    }
    if ((*list).size == 1) {
        return pop_front(list, dataOut);
    }
    struct node *node = (*list).head;
    if (node == NULL) {
        return FAILURE;
    }
    struct node *temp = (*list).head;
    while((*temp).next -> next) {
        temp = (*temp).next;
    }
    *dataOut = (*temp).next -> data;
    free((*temp).next);
    (*temp).next = NULL;
    (*list).size--;
    return SUCCESS;
}


/** remove_at_index
 *
 * Remove the element at the specified index in the linked list.
 *
 * @param list a pointer to the linked list structure
 * @param dataOut A pointer to a pointer used to return the data in the last
 *        node or NULL if the linked list is NULL or empty
 * @param index 0-based, starting from the head in the inclusive range
 *        [0,size-1]
 * @return FAILURE if the index is out of bounds, the linked list is NULL or the
 *         dataOut is NULL, otherwise return SUCCESS
 */
int remove_at_index(struct linked_list *list, struct user **dataOut, int index)
{
    if (list == NULL || index > (*list).size|| index < 0) {
        return FAILURE;
    }
    if (index == (*list).size - 1) {
        return pop_back(list, dataOut);
    } 
    else if (index == 0) {
        return pop_front(list, dataOut);
    }
    struct node *temp = (*list).head;
    struct node *node = (*temp).next;
    if (temp == NULL) {
        return FAILURE;
    }
    int i = 0;
    while (i < index - 1) {
        temp = node;
        node = (*node).next;
    }
    *dataOut = (*node).data;
    (*temp).next = (*node).next;
    free(node);
    (*list).size--;
    return SUCCESS;
}

/** empty_list
 *
 * Empties the linked list. After this is called, the linked list should be
 * empty. This does NOT free the linked list struct itself, just all nodes and
 * data within. Make sure to check that the list is not NULL before using it.
 *
 * Once again, the things that need to be freed after this function are:
 * - the nodes
 * - the user structs within the nodes
 * - all pointers in the user struct
 *
 * However, if you're using other functions you've written (which you should
 * be), those functions might take care of some of the freeing for you.
 *
 * You may call free on char pointers as well as struct pointers.
 *
 * If 'list' is NULL, simply return.
 *
 * @param list a pointer to the linked list struct
 */
void empty_list(struct linked_list *list)
{
    if (list == NULL) {
      return;
    }
    while ((*list).size != 0) {
      struct user *node;
      struct user **curr = &node;
      pop_front(list, curr);
      free((*curr)->name);
      free((*curr));
    }
}


/** replace_name_at_index
 *
 * Replaces the name field in the user data struct of the node at the specified
 * index with a new name
 *
 * Note that new name may be a different size than old one (hint: use realloc to
 * resize the buffer).
 *
 * If realloc or malloc fails, leave the name at the specified index unchanged.
 *
 * @param list a pointer to the linked list struct
 * @param index 0-based, starting from the head in the inclusive range
 *        [0,size-1]
 * @param newName a pointer to the new name
 * @return FAILURE if the index is out of bounds, the linked list is NULL or
 *         realloc fails otherwise return SUCCESS
 */
int replace_name_at_index(struct linked_list *list, int index, char *newName)
{
    if (list == NULL || index < 0 || index >= (*list).size) {
      return FAILURE;
    }

    if (index == 0){
      void *node;
      if((node = realloc(list->head->data->name, sizeof(strlen(newName)+1))) == NULL) {
        return FAILURE;
      }
      list->head->data->name = node;
      strcpy(list->head->data->name, newName);
    } else {
      struct node *temp = (*list).head;
      int count = 0;
      while (count < index) {
        temp = (*temp).next;
        count++;
      }
      void *node;
      if ((node = realloc(temp->data->name, strlen(newName)+1)) == NULL) {
        return FAILURE;
      }
      temp->data->name = node;
      strcpy(temp->data->name, newName);
    }
    return SUCCESS;
}
