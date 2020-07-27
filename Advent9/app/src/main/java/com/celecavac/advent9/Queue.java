package com.celecavac.advent9;

public class Queue {
    QueueElement current;

    public Queue(long value) {
        current = new QueueElement((value));
        current.setNext(current);
        current.setPrev(current);
    }

    private void rotateRight2() {
        current = current.getNext().getNext();
    }

    private void rotateLeft7() {
        for (int i = 0; i < 7; i++)
            current = current.getPrev();
    }

    public void add(long value) {
        QueueElement newElement = new QueueElement((value));
        rotateRight2();

        newElement.setNext(current);
        newElement.setPrev(current.getPrev());
        current.getPrev().setNext(newElement);
        current.setPrev(newElement);


        current = newElement;
    }

    public long remove() {
        rotateLeft7();
        long value = current.getValue();

        current.getPrev().setNext(current.getNext());
        current.getNext().setPrev(current.getPrev());

        current = current.getNext();
        return value;
    }

    public String toString() {
        String ret = "";
        QueueElement pointer = current;

        while (pointer.getValue() != 0)
            pointer = pointer.getNext();

        if (pointer == current)
            ret += "(";
        ret += pointer.getValue();
        if (pointer == current)
            ret += ")";
        ret += " ";
        pointer = pointer.getNext();

        while (pointer.getValue() != 0) {
            if (pointer == current)
                ret += "(";
            ret += pointer.getValue();
            if (pointer == current) {
                ret += ")";
            }
            ret += " ";
            pointer = pointer.getNext();
        }

        return  ret;
    }
}
