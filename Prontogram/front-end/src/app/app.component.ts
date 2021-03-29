import { ApplicationRef, Component, OnInit } from '@angular/core';
import { AccountService, NotificationService } from './_services';
import { User, Notification } from './_models';
import { SwUpdate, SwPush } from '@angular/service-worker';
import { interval } from 'rxjs';
@Component({ selector: 'app', templateUrl: 'app.component.html' })
export class AppComponent {
    user: User;
    notification: Notification;
    constructor(
        private accountService: AccountService, 
        private notificationService: NotificationService,
        ) {
        this.accountService.user.subscribe(x => this.user = x);
        this.notificationService.notification.subscribe(x => this.notification = x);
    }

    logout() {
        this.accountService.logout();
    }
}