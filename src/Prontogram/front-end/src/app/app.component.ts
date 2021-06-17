import { Component, OnInit } from '@angular/core';
import { AccountService, NotificationService } from './_services';
import { User, Notification } from './_models';
import { SwPush, SwUpdate } from '@angular/service-worker';
import { take } from 'rxjs/operators';
@Component({ selector: 'app', templateUrl: 'app.component.html' })
export class AppComponent implements OnInit {

    user: User;
    notification: Notification;
    readonly VAPID_PUBLIC_KEY = "BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM";

    constructor(
        private accountService: AccountService, 
        private notificationService: NotificationService,
        private swUpdate: SwUpdate,
        private swPush: SwPush,
        ) {
        this.accountService.user.subscribe(x => this.user = x);
        this.notificationService.notification.subscribe(x => this.notification = x);
        this.pushSubscription();
        }

    ngOnInit () {

        if (this.swUpdate.isEnabled) {

            this.swUpdate.available.subscribe(() => {

                if (confirm("New version available. Load New Version?")) {
                    window.location.reload();
                }

            });

        }
    }

    pushSubscription () {
        if(this.swPush.isEnabled){
        this.swPush.requestSubscription({
        serverPublicKey: this.VAPID_PUBLIC_KEY
        })
        .then(sub =>{this.notificationService.sendSubscriptionToTheServer(sub,this.user).subscribe(x=>console.log(x),err=>console.log(err))})
        .catch(err => console.error("Could not subscribe to notifications", err));
        }
    }

    logout() {
        this.accountService.logout();
        this.unsubscribeNotifications();
    }

    unsubscribeNotifications(){
        this.swPush.subscription.pipe(take(1)).subscribe(subscriptionValue=>{
          if (subscriptionValue) {
              this.notificationService.unsubscribeToNotification (subscriptionValue)
              .subscribe(
                res => {
                  // Unsubscribe current client (browser)
                  subscriptionValue.unsubscribe()
                    .then(success => {
                      console.log('[App] Unsubscription successful', success)
                    })
                    .catch(err => {
                      console.log('[App] Unsubscription failed', err)
                    })
                },
                err => {
                  console.log('[App] Delete subscription request failed', err)
                }
              );
          }
          else {
            console.log("Prima di fare unsubscribe devi fare subscribe!");
          }
          
      });
    }
}