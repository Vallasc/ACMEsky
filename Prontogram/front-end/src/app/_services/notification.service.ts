import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from '../../environments/environment';
import { Notification } from '../_models';

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
        return this.http.post(`${environment.apiUrl}/posts/notification`, notification);
    }

    getAll() {
        return this.http.get<Notification[]>(`${environment.apiUrl}/gets/find/notification`); 
    }

    getById(id: string) {
        return  this.http.get<Notification>(`${environment.apiUrl}/gets/notification/${id}`);
    }

    update(id, params) {
        return this.http.patch(`${environment.apiUrl}/posts/notificication/${id}`, params);
    }

    delete(id: string) {
        return this.http.delete(`${environment.apiUrl}/posts/notification/${id}`)
            .pipe(map(x => {
                return x;
            }));
    }

    addPushSubscriber (sub:any) {
        return  this.http.post(`${environment.apiUrl}/posts/sub`,sub);
    }

    send() {
        return this.http.post(`${environment.apiUrl}/posts/news`,null);
    }

}