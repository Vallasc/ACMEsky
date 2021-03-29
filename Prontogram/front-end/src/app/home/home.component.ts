import { Component } from '@angular/core';

import { User } from '/Users/riccardobaratin/ACMEsky/src/app/_models';
import { AccountService } from '/Users/riccardobaratin/ACMEsky/src/app/_services';

@Component({ templateUrl: 'home.component.html' })
export class HomeComponent {
    user: User;
    constructor(private accountService: AccountService) {
        this.user = this.accountService.userValue;
    }
}