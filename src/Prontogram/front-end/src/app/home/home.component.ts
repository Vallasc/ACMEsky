import { Component, OnInit } from '@angular/core';
import { SwPush } from '@angular/service-worker';
import { User } from '@app/_models';
import { AccountService, NotificationService } from '@app/_services';

@Component({ templateUrl: 'home.component.html' })
export class HomeComponent {
    user: User;
    constructor( 
        private accountService: AccountService,
        ){
        this.user= this.accountService.userValue;
    }

}