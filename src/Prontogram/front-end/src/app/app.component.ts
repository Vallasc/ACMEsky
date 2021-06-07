import { Component, OnInit } from '@angular/core';
import { AccountService, NotificationService } from './_services';
import { User, Notification } from './_models';
import { SwUpdate } from '@angular/service-worker';
@Component({ selector: 'app', templateUrl: 'app.component.html' })
export class AppComponent implements OnInit {

    user: User;
    notification: Notification;
    
    constructor(
        private accountService: AccountService, 
        private notificationService: NotificationService,
        private swUpdate: SwUpdate,
        ) {
        this.accountService.user.subscribe(x => this.user = x);
        this.notificationService.notification.subscribe(x => this.notification = x);
        }

    ngOnInit() {

        if (this.swUpdate.isEnabled) {

            this.swUpdate.available.subscribe(() => {

                if (confirm("New version available. Load New Version?")) {
                    window.location.reload();
                }

            });

        }
    }

    logout() {
        this.accountService.logout();
    }
}