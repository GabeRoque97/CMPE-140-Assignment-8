#include <iostream>
#include <string>
#include "delete.hpp"
using namespace std;

int main()
{
	node* head = new node;
	node* tail = new node;
	node* current = new node;
	
	head->next = tail;
	tail->next = NULL;
	head->data = NULL;
	tail->data = NULL;
	head->data = 10;
	tail->data = 11;
	current = head;
	cout << "according to current, head is: " << current->data << endl;
	current = tail;
	cout << "according to current, tail is: " << current->data;
	
	return 0;

}
