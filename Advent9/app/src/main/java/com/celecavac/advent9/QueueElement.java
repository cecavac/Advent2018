package com.celecavac.advent9;

public class QueueElement {
    long value;
    QueueElement next;
    QueueElement prev;

    public QueueElement(long value) {
        this.value = value;
    }

    public void setNext(QueueElement next) {
        this.next = next;
    }

    public QueueElement getNext() {
        return next;
    }

    public void setPrev(QueueElement prev) {
        this.prev = prev;
    }

    public QueueElement getPrev() {
        return prev;
    }

    public long getValue() {
        return  value;
    }
}
