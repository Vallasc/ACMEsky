import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../environments/environment';
import { Notification, Subscription, User } from '../_models';

@Injectable({ providedIn: 'root' })
export class NotificationService {
    private notificationSubject: BehaviorSubject<Notification>;
    public notification: Observable<Notification>;
    constructor(
        private http: HttpClient,
        
    ) {
        this.notificationSubject = new BehaviorSubject<Notification>(JSON.parse(localStorage.getItem('notification')));
        this.notification = this.notificationSubject.asObservable();
    }

    public get notificationValue(): Notification {
        return this.notificationSubject.value;
    }

    createNotification(notification: Notification) {
        return this.http.post(`${environment.apiUrl}/notification/posts/new`, notification);
    }

    getAll(id: string) {
        return this.http.get<Notification[]>(`${environment.apiUrl}/notification/gets/all/${id}`); 
    }

    getById(id: string) {
        return  this.http.get<Notification>(`${environment.apiUrl}/notification/gets/${id}`);
    }

    update(id, params) {
        return this.http.patch(`${environment.apiUrl}/notification/posts/notification/${id}`, params);
    }

    delete(id: string) {
        return this.http.delete(`${environment.apiUrl}/notification/posts/notification/${id}`)
            .pipe(map(x => {
                return x;
            }));
    }

    sendSubscriptionToTheServer (subscription: PushSubscription, user: User) {
        const sub = new Subscription ();
        sub.subscription = subscription;
        sub.user_id = user._id;
        return  this.http.post(`${environment.apiUrl}/notification/posts/sub`,sub);
    }

    unsubscribeToNotification (subscription: PushSubscription) {
        return  this.http.delete(`${environment.apiUrl}/notification/posts/${subscription.toJSON()}`);
    }

    send() {
        return this.http.post(`${environment.apiUrl}/notification/posts/news`,null);
    }

}