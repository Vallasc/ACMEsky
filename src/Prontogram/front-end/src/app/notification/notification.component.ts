import { ApplicationRef, Component, OnInit} from '@angular/core';
import { Notification } from '../_models';
import { NotificationService } from '../_services';
import { first } from 'rxjs/operators';
import {SwPush, SwUpdate} from '@angular/service-worker'
import { interval } from 'rxjs';

@Component({ templateUrl: './notification.component.html' })

export class NotificationComponent implements OnInit {
    notifications: Notification[] = [];
    sub: PushSubscription;
    readonly VAPID_PUBLIC_KEY = "BMKtc1sW54C54akN2A0T_2g0DcCYVQqgmzW3Mx7um85HY28Vj4nmImOfx6KMzD807WABeeqAifOZgwnfkNU7erY";
    constructor(
        private swPush: SwPush,       
        private notificationService: NotificationService,
        private update: SwUpdate,
        private appRef: ApplicationRef,
    
        ) {    
           
        }

    ngOnInit() {
        this.pushSubscription();
        this.updateClient();
        this.checkUpdate();
        this.swPush.messages.subscribe((message) => console.log(message));
    
        this.swPush.notificationClicks.subscribe(({ action, notification }) => {
          window.open(notification.data.url);
        });
        this.notificationService.getAll().subscribe (notification => this.notifications = notification);
    
    }

   /* basicDetails(notification) {
        const { _id, flyNumber, flyCompany, flyToken} = notification;
        return { _id, flyNumber, flyCompany, flyToken};
    }*/
    
    deleteNotification(id: string) {
        const user = this.notifications.find(x => x._id === id);
        this.notificationService.delete(id)
           .pipe(first())
           .subscribe(() => this.notifications = this.notifications.filter(x => x._id !== id));
    }

    pushSubscription () {
        
        if (!this.swPush.isEnabled) {
            console.log('Notification is not enabled');
            return;
          }
        this.swPush.requestSubscription({
            serverPublicKey: this.VAPID_PUBLIC_KEY
        })
        .then(sub => {

            this.sub = sub;


            console.log("Notification Subscription: ", sub);

            this.notificationService.addPushSubscriber(sub).subscribe(
                () => console.log('Sent push subscription object to server.'),
                err =>  console.log('Could not send subscription object to server, reason: ', err)
            );

        })
        .catch(err => console.error("Could not subscribe to notifications", err));
    }

    sendNewsletter() {
        console.log("Sending Newsletter to all Subscribers ...");
        this.notificationService.send().subscribe();
    }

    updateClient() {
        if (!this.update.isEnabled) {
          console.log('Not Enabled');
          return;
        }
        console.log(`UPDATE`+ "in UPDATE" );
        this.update.available.subscribe((event) => {
          console.log(`current`, event.current, `available `, event.available);
          if (confirm('update available for the app please conform')) {
            this.update.activateUpdate().then(() => location.reload());
          }
        });
    
        this.update.activated.subscribe((event) => {
          console.log(`current`, event.previous, `available `, event.current);
        });
      }
    
      checkUpdate() {
        this.appRef.isStable.subscribe((isStable) => {
          if (isStable) {
            const timeInterval = interval(8 * 60 * 60 * 1000);
    
            timeInterval.subscribe(() => {
              this.update.checkForUpdate().then(() => console.log('checked'));
              console.log('update checked');
            });
          }
        });
      }
}

