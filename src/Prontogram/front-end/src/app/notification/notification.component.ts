import { Component, OnDestroy, OnInit} from '@angular/core';
import { Notification } from '../_models';
import { AccountService, NotificationService } from '../_services';
import { first, take, takeUntil } from 'rxjs/operators';
import {SwPush} from '@angular/service-worker'
import { Observable, Subject } from 'rxjs';
import { User } from '../../../../../../../../../ACMEsky/src/app/_models';

@Component({ templateUrl: './notification.component.html' })

export class NotificationComponent implements  OnDestroy,OnInit{
    notifications: Notification [];
    sub: PushSubscription;
    user: User;
    private ngUnsubscribe = new Subject();

    readonly VAPID_PUBLIC_KEY = "BA161ZnkX9G6CwYOZifUyGpOxslxcANly0PfMtti7y1rDO9NZlPNI1yepdaTodQXX0gVHqXHVApmArL1MUNsBoM";
    constructor(
        private swPush: SwPush,
        private notificationService: NotificationService,
        private accountService: AccountService        
        ) {   
           this.user= this.accountService.userValue;
          }
          
    ngOnInit(){
      if(navigator.serviceWorker){
      // First, do a one-off check if there's currently a service worker in control.

        if (navigator.serviceWorker.controller) {
          console.log(`This page is currently controlled by: ${navigator.serviceWorker.controller}`);
          navigator.serviceWorker.controller.onstatechange=function(){
          console.log('state'+ navigator.serviceWorker.controller.state);
        }
        } else {
          //This happens on ctrl+f5(force refresh)
          console.log('This page is not currently controlled by a service worker.');
          navigator.serviceWorker.register('./ngsw-worker.js').then(function(registration) {
          console.log('Service worker registration succeeded:', registration);
          window.location.reload();
          })
          , function(error) {
                console.log('Service worker registration failed:', error);
              };
            }
            // Then, register a handler to detect when a new or
            // updated service worker takes control.
            navigator.serviceWorker.oncontrollerchange = function() {
              console.log('This page is now controlled by:', navigator.serviceWorker.controller);
            };
      }
      else {
        console.log('Service workers are not supported.');
      }
      //load all notifications
      this.getAllNotifications ();

       //add new notification to notifications
      this.swPush.messages
      .pipe(takeUntil(this.ngUnsubscribe))
      .subscribe(message => {
        //Create new Notification
        let notification = message['notification']
        let notify = new Notification ();
        notify.flyNumber = notification['data']['flyNumber'];
        notify.flyCompany = notification['data']['flyCompany'];
        notify.flyToken = notification['data']['flyToken'];
        notify.user_id = notification['data']['user_id']
        this.addNotification (notify);
      });
       //notification's actions
      this.swPush.notificationClicks.subscribe(({ action, notification }) => {
      //window.open(notification.data.url);
      });
      
    }

    deleteNotification(id: string) {
      this.notificationService.delete(id)
      .pipe(first())
      .subscribe(() => this.notifications = this.notifications.filter(x => x._id !== id));
    }

    /*pushSubscription () {
      if(this.swPush.isEnabled){
      this.swPush.requestSubscription({
      serverPublicKey: this.VAPID_PUBLIC_KEY
      })
      .then(sub =>{this.notificationService.sendSubscriptionToTheServer(sub,this.user).subscribe(x=>console.log(x),err=>console.log(err))})
      .catch(err => console.error("Could not subscribe to notifications", err));
      }
    }*/

    /*unsubscribeNotifications(){
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
  }*/

    getAllNotifications () {
      this.notificationService.getAll(this.user._id).subscribe(
        (res : Notification []) => {
          this.notifications = res;
        },
        (err) => {
          console.error(err);
        }
      );
    }

    addNotification (notification: Notification) {
      if (notification.user_id == this.user._id) {
        this.notifications.push(notification);
      } 
    }

    ngOnDestroy() {
      this.ngUnsubscribe.next();
      this.ngUnsubscribe.complete();
    }

}

